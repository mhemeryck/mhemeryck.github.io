+++
title = "cloud key reset"
subtitle = "unifi cloud key factory reset"
date = "2021-12-08"
tags = ["unifi", "homelab", "note-to-self"]
+++

After my [last password issues post], I still had some places for which I didn't have an easy approach to reset the login.
For my local network, I still use a unifi cloud key gen 1, to keep an overview of the network.

# Cloud key

The **[ubiquiti unifi cloud key]** is a small client device on the local network, specifically running the ubiquiti unifi controller software.
The controller software is there to e.g. provision new (ubiquiti) hardware, to configure the network (switch ports, VLANs, firewalls, ...) but also to allow remote management from a web interface or phone app.

Note that you actually **don't need dedicated hardware** to run the controller software.
You can just as well run the software from your own local computer or instead use the [dockerized controller software].
Having it on a dedicated device though means that it is always available, doing logging and monitoring in the background and providing an entry point for remote access.
Additionally, the cloud key does indeed mainly run the controller software, but it also has onboard firmware to set manage the controller software for you.

On the upside, I think the _unifi experience_ is overall quite nice and graphically slick.
Despite being considered a _prosumer_ kind of brand, some features I would consider as basic are missing though (built-in DHCP / DNS, VPN termination, ...)

In the end, I still like the unifi products since they do have somewhat more enhanced features yet mostly **"just work"**.
There was a time when I was running my own [openWrt]-enabled router, but the reality just is that after the initial setup, this is just something I barely feel the need to touch (and maintain).

# Factory reset

As mentioned above, the cloud key hardware runs both the main unifi controller software as well as its own firmware to manage said software.
The login for the controller software is done via my [ui.com] account.
Retrieving that one was as simple as resetting this account.

The controller **firmware management** however is also password-protected and being a good citizen, I obviously changed it from its default of `ubnt` / `ubnt`.
Even though I still had access to the controller software, I figured it'd be better to have full access to the firmware management as well.
The rationale is that the times when you often need this is in case of some breaking issue -- in which event you want to have immediate access.

The cloud key has an **SD-card**, so I figured that it would run from there (pretty much how a raspberry pi does).
After checking the SD card contents though, they only seemed to contain the regularly scheduled backups.

Checking the [cloud key gen1 pdf docs] showed me that there is simple **factory reset button**.
After grabbing a backup snapshot of the controller software, I did decide on just triggering the factory reset.

Sure enough, the firmware management did now work with the default credentials (prompting me to change it straight after that).

# Let's Encrypt certificates setup

I want to be able to also access the cloud key on a regular URL even if it's only from my local network.
Also, by default the cloud key controller software will use an HTTPS version (which is good), but it obviously has no built-in way to provide a valid certificate (not so good).

A side-effect of this factory reset was that I had now lost this setup in where the cloud key itself regularly pulls in an updates Let's Encrypt SSL certificate.
In the past, I had followed this nicely detailed blog post on [cloud key SSL certificates with Let's Encrypt].

To summarize the steps for myself for future reference:

1. Fixed IP for the cloud key: this actually easy to do from the unifi controller software (running on the cloud key)
1. DNS entry for this fixed IP: I use [pihole]'s built-in [dnsmasq] for this. This means that all devices on my local network will be able to resolve the host for the cloud key
1. Set up a job on the cloud key to regularly pull in updated SSL certificates

## `acme.sh` Let's Encrypt cloud key bot setup

The way **Let's Encrypt works** is that you can request a certificate for your own domain name.
Afterwards, the Let's Encrypt server will verify with you whether or not you actually own the domain for which you did request the SSL certificate.
This can be done in a multitude of ways, but the most common ones are:

1. HTTP-based: on the service you expose, you host some kind of secret that was given to you before by Let's Encrypt
1. DNS-based: on the DNS provider on which you host the domain, you provide an `txt` kind of record which Let's Encrypt, again containing the secret Let's Encrypt had provided before

For my home network case, I am obliged to use the DNS-based approach, since my own service isn't exposed on the wide internet for Let's Encrypt to call back to.
It's a nice approach to be able to get valid SSL certificates for a machine on a local network.
Additionally, a lot of tooling is readily available to automate all details for you, such as [certbot] or [cert-manager].

Essentially, these steps are completely taken from the aforementioned post.
Since I wouldn't like to lose these and since I have some minor differences due to using digital ocean as DNS provider, I detail them here again for myself.

Installing the bot:

```bash
https://get.acme.sh | sh
```

Installing a hook script to run on certificate renewal in `/root/.acme.sh/cloudkey-renew-hook.sh`

```bash
#!/bin/bash
# Renew-hook for ACME / Let's encrypt
echo "** Configuring new Let's Encrypt certs"
cd /etc/ssl/private
rm -f /etc/ssl/private/cert.tar /etc/ssl/private/unifi.keystore.jks /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/private/fullchain.pem

openssl pkcs12 -export -in /etc/ssl/private/cloudkey.crt -inkey /etc/ssl/private/cloudkey.key -out /etc/ssl/private/cloudkey.p12 -name unifi -password pass:aircontrolenterprise

keytool -importkeystore -deststorepass aircontrolenterprise -destkeypass aircontrolenterprise -destkeystore /usr/lib/unifi/data/keystore -srckeystore /etc/ssl/private/cloudkey.p12 -srcstoretype PKCS12 -srcstorepass aircontrolenterprise -alias unifi

rm -f /etc/ssl/private/cloudkey.p12
tar -cvf cert.tar *
chown root:ssl-cert /etc/ssl/private/*
chmod 640 /etc/ssl/private/*

echo "** Testing Nginx and restarting"
/usr/sbin/nginx -t
/etc/init.d/nginx restart ; /etc/init.d/unifi restart
```

This will modify the retrieved certificates in such a way that they can be used by the unifi controller software.

Export the proper API keys to the environment.
In my case, I am using the [digitalocean DNS provider].
This changes the line in the `.bashrc` file to adapt to something like

```bash
export DO_API_KEY=<key>
```

The first certificate retrieval line changes to

```bash
acme.sh --force --issue --dns dns_dgon -d <YOUR_DOMAIN> --pre-hook "touch /etc/ssl/private/cert.tar; tar -zcvf /root/.acme.sh/CloudKeySSL_`date +%Y-%m-%d_%H.%M.%S`.tgz /etc/ssl/private/*" --fullchainpath /etc/ssl/private/cloudkey.crt --keypath /etc/ssl/private/cloudkey.key --reloadcmd "sh /root/.acme.sh/cloudkey-renew-hook.sh"
```

The crontab entry becomes:

```bash
0 0 * * * /root/.acme.sh/acme.sh --renew --apache --renew-hook /root/.acme.sh/cloudkey-renew-hook.sh -d <YOUR_DOMAIN>
```

At this point, everything should be back up and running and the cloud key should be accessible from the custom domain _with_ a valid certificate!

# Closing thoughts

This post serves mainly as a **note-to-self** after needing to go through some steps to manually recover my cloud key setup.

At this point, the cloud key is just back running as before.
Going through this process again made me realize some points of improvement.

Firstly, in the past I did **run the controller software as part of my home [k3s] cluster**, but I ended up not doing that since it cost me a lot of resources and I basically did not want to manage that.
However, I still have some plans to upgrade the cluster setup itself at which point it might come interesting again to run it there.
The added value would be that I could manage the certificate renewal using [cert-manager] instead of via a cron job.
The downside of the cron job on the cloud key is that it gets wiped for firmware upgrades.

Secondly, I am also not completely happy with the **manual host name** management.
I first need to configure a static IP manually in the controller software and then also manually configure pihole / dnsmasq.
It seems there is a [unifi terraform] provider that would be able to handle the IP management -- but I haven't been able yet to get that working with the cloud key (perhaps it does not work for the gen 1?).
DNS configuration can be done via API using e.g. [powerdns] or [coredns], which is another route to explore.
Services running on the kubernetes cluster could then also register their host names using [external-dns]

Thirdly, it would also be nice that any of the host names I set for my local network are actually accessible in a similar manner over a **[wireguard] VPN**.

A final small change would be for me to **change DNS provider** from digital ocean to [hetzner cloud] since I have everything else there.

Still a lot of home lab ideas, so little time, let's see what's next!

[last password issues post]: {{< ref "2021-12-01-password_fsckup" >}}
[ubiquiti unifi cloud key]: https://unifi-protect.ui.com/cloud-key-gen2
[openWrt]: https://openwrt.org/
[dockerized controller software]: https://hub.docker.com/r/linuxserver/unifi-controller
[ui.com]: https://ui.com/
[cloud key gen1 pdf docs]: https://dl.ubnt.com/guides/UniFi/UniFi_Cloud_Key_UC-CK_QSG.pdf
[cloud key SSL certificates with Let's Encrypt]: https://www.jamesridgway.co.uk/auto-renewing-ssl-certificate-unifi-cloud-key-lets-encrypt-cloudflare-dns-validation/
[pihole]: https://pi-hole.net/
[dnsmasq]: https://thekelleys.org.uk/dnsmasq/doc.html
[digitalocean DNS provider]: https://github.com/acmesh-official/acme.sh/wiki/dnsapi#20-use-digitalocean-api-native
[k3s]: https://k3s.io/
[cert-manager]: https://cert-manager.io/docs/
[unifi terraform]: https://registry.terraform.io/providers/paultyng/unifi/latest/docs
[powerdns]: https://www.powerdns.com/
[coredns]: https://coredns.io/
[wireguard]: https://www.wireguard.com/
[external-dns]: https://github.com/kubernetes-sigs/external-dns
[hetzner cloud]: https://www.hetzner.com/cloud
[certbot]: https://certbot.eff.org/

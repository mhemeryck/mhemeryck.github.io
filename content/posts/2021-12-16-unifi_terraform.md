+++
title = "unifi terraform"
subtitle = "unifi cloud key infrastructure-as-code"
date = "2021-12-16"
tags = ["unifi", "homelab", "infrastructure-as-code", "terraform", "note-to-self"]
+++

Last week, I did write about [resetting my unifi cloud key].

The main reason I did gain a renewed interest in the cloud key was because I wanted to add some more fixed IPs to my home network.
One of the nice things about the unifi controller software is that it provides a single dashboard interface to manage everything network-related.

On the downside, the interface is overall quite limited.
While it does offer DHCP (the fixed IPs) in this fashion, it does not offer built-in DNS (e.g. for naming dedicated hosts on the home network).

Additionally, I also don't really like these point-and-click interfaces which are hard to put under version control except for a full snapshot.
Coming from a software development background and with the current infrastructure-as-code movement, I wanted to look into an alternative.

# infrastructure-as-code and HashiCorp terraform

Nowadays, if you want to run some kind of software service, all the major cloud providers do provide web APIs to manage the (virtual) infrastructure for you.
Managing infrastructure at this point becomes another **software problem** for interacting with these APIs, thus the term infrastructure-as-code.

One platform that has become increasingly popular in that regard has been HashiCorp's **[terraform]**.
It provides an abstraction layer for all of these different cloud provider and offers an ecosystem for easily adding more modules.

Additionally, the format is **declarative**, meaning that the tool will manage the life cycle of the components you describe.
As an example, adding a resource means just declaring it in the configuration file and running it through the `terraform` CLI tool.
At that point, the resource becomes managed by terraform.
Destroying the resource is done by removing the entry from the configuration file and once again applying.
Essentially, the configuration file will always reflect the state of the resources being managed and vice versa.

# unifi-terraform

What does any of that have to do with my tiny homelab setup?
Enter **[unifi-terraform]**, which is a community provided terraform module that interacts with the API of the unifi cloud key.
This way, I could manage all the required fixed IPs.

As I mentioned in my previous post, I did have some trouble getting started though, so let's walk a bit through the steps I had taken.

## terraform configuration file

The first step is creating a `main.tf` file containing the actual configuration.
I'm not going to elaborate too much on this here, see the [terraform docs] for that.

Generally, my configuration file looked like this (redacted).

```
terraform {
  required_providers {
    unifi = {
      source = "paultyng/unifi"
      version = "0.34.0"
    }
  }
}

provider "unifi" {
  username = var.username  # These are in a variables file
  password = var.password
  api_url = var.api_url
}

resource "unifi_site" "sitename" {
  description = "Default"
}

resource "unifi_user_group" "default" {
  name = "Default"
}

# the network / DHCP config
resource "unifi_network" "lan" {
  name = "LAN"
  purpose = "corporate"

  dhcp_dns = [
    "192.168.1.21",
    "1.1.1.1",
    "8.8.8.8",
    "9.9.9.9",
  ]
  dhcp_enabled = true
  dhcp_start = "192.168.1.20"
  dhcp_stop = "192.168.1.254"
  domain_name = "lan"
  igmp_snooping = true
  subnet = "192.168.1.0/24"
}

# WLAN

resource "unifi_wlan" "wlan" {
  name = "wlan"
  security = "wpapsk"
  passphrase = var.passphrase_wifi_wlan
  network_id = unifi_network.lan.id
  user_group_id = unifi_user_group.default.id

  wlan_band = "5g"
  multicast_enhance = true  # chromecast
  # default group ID
  ap_group_ids = [
    var.ap_group_id
  ]

  # enable WPA2/WPA3 support
  wpa3_support = true
  wpa3_transition = true
  pmf_mode = "optional"
}

...

# Devices

resource "unifi_device" "my-router" {
  name = "my-router"
}

...

# Users: network clients

resource "unifi_user" "my_client" {
  name = "my-client"
  mac = "d9:6e:3d:12:8f:53"
  fixed_ip = "192.168.1.10"
  network_id = unifi_network.lan.id
}

...

resource "unifi_user" "floating_client" {
  name = "floating"
  mac = "bc:e4:26:db:df:e4"
}
```

At the top of this file the `required_provider` is mentioned, i.e. the module that contains the client code to talk to the unifi cloud key API.
The `provider` block contains the data used for the provider to do the actual connection (essentially username / password and a URL to connect to).

There's a couple of interesting resources in there:

- `unifi_site`: just the physical location -- I guess this makes more sense if you have multiple locations to manage
- `unifi_user_group`: this is relevant if you want to separate out specific access for e.g. WiFi clients.
- `unifi_network`: main (wired) network parameters, including e.g. the DHCP settings
- `unifi_wlan`: wireless network configuration. Helpful if you want push in passwords
- `unifi_device`: the unifi hardware such as switches, routers and wireless access points. I actually don't have anything in particular to manage here, but I guess if you want to have specific port profiles for a switch, this would be the way to link to it
- `unifi_user`: the clients on the network. It's at this point that I can actually fix the IPs.

Have a look at [unifi-terraform] for more resources that can be managed.

## terraform import

At this point, you could in theory start creating all of the resources by applying it (with `terraform apply`).
In reality, these resources are likely already recognized and managed by the cloud key itself.
The way around that is by **importing** the resources via `terraform import {resource_name} {resource_id}`

The `{resource_name}` is just the name as you did provide it in the main configuration file, e.g. `unifi_user.my_client`
The `{resource_id}` is an ID that's used in the API of the cloud key.
This was for me the point for which it all broke down since I couldn't find any good documentation of this API.

## cloud key API

Fortunately, I did find some pointer into the cloud key API in a [blog post from the original module author].
Another real help to me has been this [unifi PHP client code] which also lists most of the endpoints.

I did distill all my findings into this [cloud key postman collection].

Let's walk through some of the API calls, built using [`httpie`].

### login: `POST {host}/api/login`

```bash
printf '{
    "username": "foo",
    "password": "bar"
}'| http  --follow --timeout 3600 POST 'https://cloudkey.lan:8443/api/login' \
 Content-Type:'application/json' \
 Cookie:'csrf_token=abc; unifises=dfcwZvHcpBwc5LTlOzgxYSlsutpC6F2b'
HTTP/1.1 200
Access-Control-Allow-Credentials: true
Access-Control-Expose-Headers: Access-Control-Allow-Origin,Access-Control-Allow-Credentials
Connection: keep-alive
Content-Length: 30
Content-Type: application/json;charset=UTF-8
Date: Thu, 16 Dec 2021 20:55:24 GMT
Keep-Alive: timeout=60
Set-Cookie: unifises=19uFvBLta4optBuzwV4QyVip5TbdR0t6; Path=/; Secure; HttpOnly
Set-Cookie: csrf_token=Z1dK47sp8NsjfpdbgHNyVNgYewNYIodd; Path=/; Secure
X-Frame-Options: DENY
vary: Origin

{
    "data": [],
    "meta": {
        "rc": "ok"
    }
}
```

This call will perform the login on the login endpoint and set a cookie for subsequent calls.
Note that all other calls will need this cookie and that it will expire.

### self: `GET {host}/api/s/{site}/self`

```bash
http --follow --timeout 3600 GET 'https://cloudkey.lan:8443/api/s/default/self' \
 Cookie:'csrf_token=cNHfNcA1zQoMW9wzFvCmGwEEo22irJ6D; unifises=dfcwZvHcpBwc5LTlOzgxYSlsutpC6F2b'
HTTP/1.1 200
Access-Control-Allow-Credentials: true
Access-Control-Expose-Headers: Access-Control-Allow-Origin,Access-Control-Allow-Credentials
Connection: keep-alive
Content-Encoding: gzip
Content-Type: application/json;charset=UTF-8
Date: Thu, 16 Dec 2021 20:58:28 GMT
Keep-Alive: timeout=60
Transfer-Encoding: chunked
X-Frame-Options: DENY
vary: accept-encoding,origin,accept-encoding

{
    "data": [
        {
            ...
            "site_id": "{site_id}",
            "site_name": "default",
            ...
        }
    ],
    "meta": {
        "rc": "ok"
    }
}
```

This just lists some generic information about the site (location), e.g. the `site_id` to be imported.

### devices: `GET {host}/api/s/{site}/stat/device`

```bash
http --follow --timeout 3600 GET 'https://cloudkey.lan:8443/api/s/default/stat/device' \
 Cookie:'csrf_token=cNHfNcA1zQoMW9wzFvCmGwEEo22irJ6D; unifises=dfcwZvHcpBwc5LTlOzgxYSlsutpC6F2b'
...
{
    "meta": {
        "rc": "ok"
    },
    "data": [
        {
            "_id": "5ea4395234309a00041ffa6e",
            "adopted": true,
            "anon_id": "d5416fde-c2ad-4558-9aa0-4b4024c441de",
            "antenna_table": [
                {
                    "default": true,
                    "id": 4,
                    "name": "Combined",
                    "wifi0_gain": 3,
                    "wifi1_gain": 3
                }
            ],
          ...
         }
     ]
}
```

This endpoint is interesting to get the IDs of the devices to import.

### users: `GET {host}/api/s/{site}/rest/user`

```bash
http --follow --timeout 3600 GET 'https://cloudkey.lan:8443/api/s/default/rest/user' \
 Cookie:'csrf_token=cNHfNcA1zQoMW9wzFvCmGwEEo22irJ6D; unifises=dfcwZvHcpBwc5LTlOzgxYSlsutpC6F2b'
...

{
    "meta": {
        "rc": "ok"
    },
    "data": [
        {
            "_id": "9dfeee213c227000f47aade2",
            "mac": "48:98:e3:f6:21:a5",
            "site_id": "5dffdda64c2370010eb91fa0",
            ...
        },
    ]
}
```

This was the most important endpoint for my purposes: it lists the resource ID under `_id` and makes it possible to import it.

Practically, this means

```bash
terraform import unifi_user.my_client 9dfeee213c227000f47aade2
```

At this point, the client should be managed by terraform.

Refer to the [cloud key postman collection] for more resources.
Note that I only really looked into the read-only endpoints (the `GET` operations) since I would have terraform do the actual operations (`POST`, `PATCH`).

# Closing thoughts

I was really pleased to see that after some crawling of the cloud key API I was able to get the unifi resources managed with terraform.
At this point, I can **manage my unifi configuration under source control**, most notably the DHCP fixed IPs and some firewall rules.
This only scratches the surface of what is now possible at this point though.

Since terraform also has modules for various **DNS providers** such as [powerdns], [coredns] and even [pihole] I could start thinking of managing the fixed IPs and the host names from a single spot.
The same local network DNS could then be used by my local kubernetes to register service names into.

Since it's supposedly infrastructure-as-code, I could also start thinking of integrating everything in **CI/CD** flow, where the terraform code is first validated and then automatically applied.
This in turn would mean I'd need to find a way to either self-host a source control / CI/CD platform (thinking of [gitlab]) or find some way to safely tunnel out to a cloud-based platform with (thinking github actions + [wireguard]).

Another change I'd like to make, is to use a **[remote state back-end]** instead of the local file storage.

... but that's for another time!

[resetting my unifi cloud key]: {{< ref "2021-12-08-cloudkey_reset" >}}
[terraform]: https://www.terraform.io/
[unifi-terraform]: https://registry.terraform.io/providers/paultyng/unifi/latest/docs
[`terraform import`]: https://www.terraform.io/cli/import
[terraform docs]: https://www.terraform.io/docs
[blog post from the original module author]: https://thenewstack.io/how-to-manage-a-home-network-with-infrastructure-as-code/
[unifi PHP client code]: https://github.com/Art-of-WiFi/UniFi-API-client/blob/fbfd6a824628d2d45f7b5dadb211cb1191335156/src/Client.php
[cloud key postman collection]: /2021-12-16/cloudkey.postman_collection.json
[postman]: https://www.postman.com/
[`httpie`]: https://httpie.io/
[powerdns]: https://registry.terraform.io/providers/pan-net/powerdns/latest/docs
[coredns]: https://github.com/shelmangroup/terraform-provider-coredns
[pihole]: https://registry.terraform.io/providers/ryanwholey/pihole/latest/docs
[gitlab]: https://about.gitlab.com/
[wireguard]: https://www.wireguard.com/
[remote state back-end]: https://www.terraform.io/language/state/remote-state-data

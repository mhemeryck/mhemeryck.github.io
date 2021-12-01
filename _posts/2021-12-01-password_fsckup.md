---
title: Password troubles
subtitle: gpg + pass part deux
cover-img:
  - "/assets/2021-12-01/cover.jpg": "Photo by Markus Spiske on Unsplash"
readtime: true
tags:
  - gpg
  - pass
  - git
  - yubikey
  - note-to-self
---

Last Saturday, my new phone arrived in the mail.
As a techie, I was naturally delighted to get my new treat up and running.
Both my old and my new phone are Android phones and I was surprised to see how (shockingly) easy it was to migrate all my stuff.
Not all settings were migrated directly though; mostly passwords would need to be set up again.

Since I did use gnu pass + GPG for my password management as described in my [previous password management post] earlier this year, I figured this would be quite easy to do!

Unfortunately, the whole endeavor ended with me losing my current GPG sub keys and (again) _all_ my passwords.

# Recap

But first, let's explain the setup again.

## GPG

I have a main GPG public / private key pair, valid indefinitely, stored offline.
From these, I generate 3 sub key pairs valid for the coming year:

1. encryption key: encrypt / decrypt stuff, notably passwords
1. signing key
1. authentication key: to be used for SSH.

## `pass`

[`pass`] is essentially a wrapper around GPG.
It manages a folder in your home folder containing an encrypted file using a previously defined GPG encryption key.
Typically, that's the GPG encryption sub key mentioned earlier.

`pass` also wraps around `git`, meaning you can have remote (encrypted) versioned backup of your password storage using `git`.

## Chrome integration: browserpass

Chrome has an extension called [browserpass] which essentially allows you to fill in passwords by calling `pass`.
Apart from the passwords, it's also possible to store the usernames (or any extra data, really) as part of the secret in `pass`, which browserpass will fill in for you.
I'm using the extension for chrome, but I suppose there are similar integrations for other browsers as well.

## Android integration: openkeychain + password store

My phone setup is quite similar:

1. [openkeychain] for the keys (`gpg`)
1. [password store] for the passwords (`pass`)

Since `pass` has the possibility to sync the full password store based on `git`, it's actually quite easy to keep my laptop and phone in sync.

## yubikey

The yubikey provides a suite of different cryptographic operations (e.g. [U2F]), but in this case, I use to also _physically_ contain aforementioned GPG private sub keys.

For example, in the case of password management:

- encrypt a new password: insert a new password with pass `pass insert <passname>`. `pass` will use the public key to encrypt the password
- decrypt the password: you'd need the private key to decrypt. Since the private key is never on my laptop, I need to insert my yubikey to decrypt.

For SSH authentication, I use something similar where the GPG agent provides the SSH process an SSH private key, based on the GPG authentication sub key, which lives on the yubikey.

Having the GPG sub keys not physically on the laptop is safer but means you can't afford losing the yubikey.
To mitigate this risk of losing the yubikey (and the GPG sub keys on them), I would save an offline backup of the sub keys prior to copying them to the yubikey.

So, at this point, when there's a backup, nothing can go wrong anymore, right?

# The problem

Well, no.

In my [previous password management post], the issue was that I did drop my old GPG decryption key before decrypting the passwords.

In this case, multiple things went wrong.

First of all the [openkeychain] app on my **new phone** did not directly recognize my yubikey.
After trying a second time, it indicated _there were no GPG keys on the yubikey_.
Checking on my laptop indeed revealed the yubikey had no more GPG keys.
Even more, at this point, it looked like the yubikey had been pretty much wiped to factory state.

Next step is checking out the offline backup.
I did find the sub keys again that I had saved for this very purpose.
Re-importing them did however not result in being able to decrypt again.

To verify what had happened, I did start from a live OS boot (i.e. [tails]) and tried a clean setup with all my private keys.

What it showed me was something like this (redacted):

```
~ gpg -K
/$HOME/.gnupg/pubring.kbx
----------------------------------
sec   rsa4096 2016-06-24 [SC]
      1B477ADA04B47A5CE61AEDE01AA36833BC86F0F1
uid           [ultimate] Martijn ... <user@mail.com>
ssb   rsa4096 2016-06-24 [E]
ssb>  rsa4096 2021-03-09 [E] [expires: ...]
ssb>  rsa4096 2021-03-09 [S] [expires: ...]
ssb>  rsa4096 2021-03-09 [A] [expires: ...]
```

The bracket `>` in front of `ssb` means that it's a _stub_ of a sub key.
A stub is what is left over on the key ring after the private key has been moved to the key card (the yubikey).
Apparently, instead of making a backup of the key, I had made a back-up of the stub ...

The **key issue is that the `gpg` `keytocard` operation is a destructive one**.
If you move the private key to the card, only the stub is left, never to be retrieved again.
To make a proper back-up of the private key (sub key or full key), do it before you move it over to the key card!

# Closing thoughts

Since this was the second time in a relatively short time I had principally lost all my logins, I really felt like giving up altogether on this solution for password management.

However, the whole `gpg` + `pass` + `git` + yubikey combo still is quite appealing to me.
It fits in the true [Unix philosophy] of "having each program do one thing well".
I also like the fact I'm myself in complete control of the data instead of relying on a remote cloud provider, specifically if it is about sensitive data.

Ultimately, after a couple of days of re-requesting logins, I'm back to before, this time with a proper backup (fingers crossed!).

[previous password management post]: {% post_url 2019-07-09-updating_gpg_subkeys %}
[openkeychain]: https://www.openkeychain.org/
[password store]: https://play.google.com/store/apps/details?id=dev.msfjarvis.aps
[`pass`]: https://www.passwordstore.org/
[browserpass]: https://github.com/browserpass/browserpass-extension
[U2F]: https://www.yubico.com/authentication-standards/fido-u2f/
[tails]: https://tails.boum.org/index.en.html
[Unix philosophy]: https://en.wikipedia.org/wiki/Unix_philosophy

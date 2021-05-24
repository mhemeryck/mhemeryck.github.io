---
title: Updating GPG subkeys
subtitle: My yearly yubikey GPG subkey rotation process
cover-img:
  - "/assets/2019-07-09/keys.jpg": "Photo by Florian Berger on Unsplash"
readtime: true
tags:
  - gpg
  - yubikey
  - note-to-self
---

This is just a list of things to consider when updating my GPG subkeys (encryption, signing, authentication) for the particular setup I use on a daily basis:

1. one master key without any expiry date to generate and revoke subkeys
1. I use [`pass`] as my password manager.
   1. the basic idea is that it's a command-line password manager that uses gpg under the hood for encrypting / decrypting the passwords.
   1. the passwords are encrypted with an encryption subkey
   1. pass allows managing its history with git, linking the storage on a remote gitlab / github server.
1. the subkeys are only stored on my yubikey
1. the subkeys are always valid for a period of one year
1. the yubikey I use also has NFC, which makes it possible to use it on my android phone as well

I recently needed to go through this proces and did forget to re-encrypt ...

The main steps are:

1. generate new subkeys
1. pass: re-encrypt with _both_ sets of keys available
1. move the new keys to the card
1. backup the master key again and remove all keys from the local machine

# Generate the new subkeys

First, put the master key back on the local machine, such that we can generate new subkeys.

If you're really paranoid, you should consider something like [tails] to have a safe life OS for doing all these operations, but

Add the key again:

    gpg --import priv.asc

where `priv.asc` obviously is the backup of your master key.

Start generating new subkeys for that master key:

    gpg --edit-key <foo@bar.com>

You will now get a prompt for doing operations on the master key. Go for `addkey`

    gpg>addkey

Note: in case you didn't have your master key, this will not work.

You can now add your signing and encryption keys; some parameters I'd like to use:

- 4096b size
- 1y expiration date
- RSA for both encryption / signing

don't forget to call `save` in the end.

You can now list all the keys:

    gpg -K

# Re-encrypt all passwords

This is really important (I messed up big time here): before you remove any older keys, make sure that they are re-encrypted with the new subkey!

List the fingerprint of the new subkey you'd like to use for re-encrypting:

    gpg --fingerprint --fingerprint <foo@bar.com>

Re-encrypt:

    pass init <fingerprint subkey>

Optionally, already push them out

    pass git push

# Push the new subkeys to the card

Again edit the key

    gpg --edit-key <foo@bar.com>

Select the subkey

    key <N>

where N is the count in the list of keys (visually not that obvious)

Add the key to the card

    addkeytocard

select the slot to save to (encryption for encryption, signing for signing ...)

and save

# Remove the keys from the local computer again

First, make a backup of everything again; see [gpg backup tutorial]

Export your private key:

    gpg -a --export-secret-keys <foo@bar.com> > priv.asc

Export public key:

    gpg -a --export <foo@bar.com> > pub.asc

Optionally, already push it out to a key server:

    gpg --send-keys <fingerprint>

Now, delete everything (best to unplug the key card):

    gpg --delete-secret-key <fingerprint>

Plug the key card back in and sync

    gpg --card-status

Check the keys are available albeit from the key card:

    gpg -K

[`pass`]: https://www.passwordstore.org/
[tails]: https://tails.boum.org/
[gpg backup tutorial]: http://www.racoonlab.com/2013/02/how-to-remove-the-private-master-key-from-your-laptop/

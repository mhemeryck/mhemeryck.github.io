+++
title = "Bootstrapping a pi4"
subtitle = "bootstrapping a raspberry pi4 with arch for ARM"
date = "2021-02-21"
tags = ["tech", "raspberry pi 4", "note-to-self"]
+++

I've recently bought myself a [raspberry pi 400], a small form factor keyboard with a _raspberry pi 4 4GB RAM_ built into it.
In hindsight, there are probably very few scenarios in which such a computer makes actually makes sense to me, but it still looks quite nice.
I first took it for a spin using the raspberry pi OS that was on the SD card that came along with the set, but while I can acknowledge that it works quite OK out of the box, it just looks so ugly.
Henceforth, I did decide on installing [arch for ARM] on it.
Since I did notice that I need to rethink every time again what are the best tools to install on a fresh install, this is a write-up of the most important tools I would always install.

The key 2 tools are:

- [pass] password manager
- [yadm] yet-another-dotfile-manager

The rationale behind it is the following: I use `pass` to be able to get easy access to all my passwords and logins, `yadm` manages all the other dotfiles for me.

## Arch

For a "regular" arch install, see the [arch installation guide].
In this case, the installation was a bit atypical since it was for an ARM platform, see [arch for ARM] for this (I did use the ARMv7 installation guide).

Other noteworthy steps in the installation ...

## arch linux arm: noisy boot

Terminal would show all of the kernel audit messages; add `audit=0` to command line options `/boot/cmdline.txt`

Remove noisy welcome message

    rm /etc/motd

## Helpers

Some helpers to install with the subsequent steps:

    pacman -Syu --noconfirm zsh sudo which vim git openssh libfido2
    pacman -S --noconfirm --needed base-devel

## Add a user

    touch /etc/skel/.zshrc
    groupadd sudo
    useradd -m $USER -g $GROUP -G sudo -s /usr/bin/zsh
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

Update password

    passwd $USER

## Install `pikaur`

    git clone https://aur.archlinux.org/pikaur.git
    cd pikaur
    makepkg -fsri

## Some more helpers

Some more helpers I'd always like to keep around

    pikaur -S --noconfirm ctags oh-my-zsh-git ripgrep fzf bat tmux

## git default config

Since we'll be using `git`, you'll need to define some initial config

    git config --global user.email <email>
    git config --global user.name "<name>"
    git config --global init.defaultBranch master
    git config --global pull.rebase true

## `gpg`

Import stubs from yubikey

Install and enable smart card reader:

    pikaur -S ccid
    systemctl enable pcscd
    systemctl start pcscd

Fetch keys from card

    gpg --edit-card
    > fetch
    > quit

Get the key id

    KEYID=$(gpg --with-colons --fingerprint | awk -F: '$1 == "fpr" {print $10;}' | head -n1)

Update the trust of the key

    gpg --edit-key $KEYID
    > trust
    > 5
    > quit

Enable ssh-agent using gpg-agent (temporarily; the final `zshrc` file will contain the proper setup)

    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

Tell the gpg-agent to prompt on the current TTY:

    gpg-connect-agent updatestartuptty /bye

## `pass`

Install pass

    pikaur -S pass

Init pass

    pass init $KEYID
    pass git remote add origin git@gitlab.com:<repo>
    pass git pull
    pass git reset --hard origin/master

## `yadm`

    pikaur -S yadm
    yadm clone git@gitlab.com:<repo>

At this point, I have all the minimum tools I would use for my daily work.

## UI

Even though I would spend most of my life on the command line, I also a graphical environment to work in.

I'm not going to delve to deeply into that, since I mostly prefer vanilla [gnome3] for that, combined with [`gdm`] for a login manager.

## Closing thoughts

My initial goal was to find a way of completely automating my initial installs, but in the end I figured this wasn't what I really needed, because:

1. distro-specific: I don't always run on the same distro, so not everything is portable
1. other requirements: for unattended installs (servers), I don't want / need to copy all my secrets on there (albeit encrypted or not)
1. outdated: for my daily driver install, I have no need to often keep on reprovisioning my install. By the time I would have a need to reprovision, a lot of the setup has probably changed, so it makes more sense to (vaguely) document some of the _basic_ steps instead of a fully automated machine image.

[pass]: https://www.passwordstore.org/
[yadm]: https://yadm.io/
[raspberry pi 400]: https://www.raspberrypi.com/products/raspberry-pi-400/
[arch for arm]: https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4
[arch installation guide]: https://wiki.archlinux.org/index.php/installation_guide
[gnome3]: https://www.gnome.org
[`gdm`]: https://wiki.gnome.org/Projects/GDM

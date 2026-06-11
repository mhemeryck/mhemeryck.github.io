# mhemeryck.github.io

I like to use this repo to dump some random notes-to-self, which also happen to be shared with the rest of the world.

Deployed using [github pages] with the [re-terminal] Hugo theme.

[github pages]: https://pages.github.com/
[re-terminal]: https://github.com/mirus-ua/hugo-theme-re-terminal

## Local development

Enter the Nix development shell first:

    nix develop

Then run a local preview:

    just serve

Verify a production build with:

    just build

Run all local checks with:

    just check

# mhemeryck.github.io

I like to use this repo to dump some random notes-to-self, which also happen to be shared with the rest of the world.

Deployed using [github pages], theme stolen from [hugo beautiful jekyll], which in turns was stolen from [beautiful jekyll].

[github pages]: https://pages.github.com/
[hugo beautiful jekyll]: https://github.com/halogenica/beautifulhugo
[beautiful jekyll]: https://beautifuljekyll.com/

## Local development

Enter the Nix development shell first:

    nix develop

Then run a local preview:

    just serve

Verify a production build with:

    just build

Run all local checks with:

    just check

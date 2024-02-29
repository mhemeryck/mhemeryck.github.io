+++
title = "Revamping the blog"
subtitle = "Migrating from jekyll to hugo"
date = "2024-02-29"
tags = ["meta", "blog", "hugo", "jekyll", "github", "github-actions", "fluff"]
+++

# Why

It has been a long time since I have dedicated some time to posting something on this blog.
Over the past years, I think I have spent quite some of my spare time examing things, coding, etc..
The main reason I would want to write again is that I believe it should help me scope things a bit more.

I have had this idea already a couple of times before, but whole blogging setup had become a bit of a nuissance to me.

Up to this post, I had been using [jekyll], a ruby-based blogging framework, which has been the standard framework used by [github pages].
Since github pages directly deploys the generated content after a merge to the main branch, I figured a way to preview the rendered result is quite important to me.
This was perfectly possible before , using a dockerized / docker compose based setup, see e.g. this link with the old [docker compose setup].
However, for some reason -- probably related to a newer version of jekyll (v4), I could no longer reliably preview the generated site content.

I did attempt a couple of ways to get a proper jekyll setup again:

- updating the compose setup
- installing ruby through [`rvm`] -- the ruby version manager and installing jekyll and related dependencies
- using a [nix] based approach, through the a specific nix "flake" -- `rubyPackages.github-pages` looked promising

None of these approaches really worked out for me.
I suspect it might have been related to the theme I was using, the [beautiful jekyll theme] in combination by trying to use a "remote theme" ...
Since I am not really an expert in ruby and since overall the intent is to write content and not focus on the blogging engine, I figured to look for something simpler.

Enter [hugo].

# Hugo

Hugo is a similar blogging engine to jekyll in that it takes markdown content and using a theme, it generates static websites.
Since it is also based on markdown content, migrating my existing blog content would also be fairly to do.
The blogging engine itself is written in go, which seemed already simpler for me to install and maintain.
The actual process of building a website generally is also faster, which makes for faster feedback loops.

[jekyll]: https://jekyllrb.com/
[github pages]: https://pages.github.com/
[docker compose setup]: https://github.com/mhemeryck/mhemeryck.github.io/blob/e0977dac2425b40b42ba23d799e28f0f41469a9d/docker-compose.yml
[`rvm`]: https://rvm.io/
[nix]: https://nixos.org/
[beautiful jekyll theme]: https://beautifuljekyll.com/
[hugo]: https://gohugo.io/

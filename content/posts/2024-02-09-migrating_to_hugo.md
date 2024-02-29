+++
title = "Revamping the blog"
subtitle = "Migrating from jekyll to hugo"
date = "2024-02-29"
tags = ["meta", "blog", "hugo", "jekyll", "github", "github-actions", "fluff"]
+++

# Why

It has been a long time since I have dedicated some time to posting something on this blog.
Over the past years, I think I have spent quite some of my spare time examining things, coding, etc..
The main reason I would want to write again is that I believe it should help me scope things a bit more.

I have had this idea already a couple of times before, but the whole blogging setup had become a bit of a nuisance to me.

Up to this post, I had been using [jekyll], a ruby-based blogging framework, which has been the standard framework used by [github pages].
Since github pages directly deploys the generated content after a merge to the main branch, I figured a way to preview the rendered result is quite important to me.
This was perfectly possible before, using a dockerized / docker compose based setup, see e.g. this link with the old [docker compose setup].
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

Overall, the following where some things I did need to go through while migrating everything.

## Theme

Hugo doesn't seem to come with a true built-in theme.
There are quite a lot of websites which do list some free themes, such as [hugo themes] and it is even possible to write your own.
I did not want to bother that much with the theme itself, so I just went for [beautiful hugo] -- which is in the end just a port of [beautiful jekyll theme].
The pretty header images I had collected for each of my posts were not supported by this theme though, so these sadly had to go.

## Preamble format

Each jekyll post had a YAML-like preamble containing some metadata.
Since the default in hugo seems to be to use a TOML-based preamble and since not all keys were still supported (e.g. the header image), I did reformat all of those.
In hindsight, I did find out YAML might actually also supported, but TOML seemed to be the default way of doing things anyway.

## Syntax

Even though the main format of the posts is written in markdown, some "meta" tags, like linking to other posts is obviously different between the two frameworks.
That also thus needed to be updated.

## Dead links

Considering my [last post] had already been from 2021, there were bound to be some dead links in the posts.
Based on some CI checks (more on that later), I cleaned those where possible.

## Social links

The new theme had some support for more social links, so I did update those as well, linking e.g. to my mastodon page and strava.

## Deployment itself

Since github pages by default still uses jekyll, I did need to change the deployment setup.
Fortunately, the "new way" of doing things for github pages nowadays seems to integrate quite easily with [github actions].

Speaking of github actions, I also did take some time to update those

### runners

All runners, which were still using some older ubuntu version just got updated.

### linter: from prettier to dprint

Before, I was using [`prettier`] to format my markdown files locally and them check in the CI if they were formatted correctly.
With the proliferation of a lot of rust-based CLI tools, I also switched that one over to [`dprint`].

### pyspelling

For [pyspelling], a CLI spellchecker, I just did update the setup.

### Dead link check

As mentioned before, I did check the dead links through the [markdown-link-check] and overall, they still seemed quite up to date.
I did update some of those where possible.
I no longer made it a mandatory part of the CI though since it seemed quite brittle.
Instead, it should now run on a schedule.

### Hugo deploy itself

This was the easiest part actually: the github actions marketplace just suggested the workflow for me and it ran without issues on the first merge to the main branch!

For more details, check the [github repo actions folder].

# Conclusions

Hugo is overall a lot simpler to me than my earlier setup with jekyll and it's blazing fast.
I might even consider moving more things here, like my [CV] since github than posts it for me.

With this out of the way, let's do some actual blogging!

[jekyll]: https://jekyllrb.com/
[github pages]: https://pages.github.com/
[docker compose setup]: https://github.com/mhemeryck/mhemeryck.github.io/blob/e0977dac2425b40b42ba23d799e28f0f41469a9d/docker-compose.yml
[`rvm`]: https://rvm.io/
[nix]: https://nixos.org/
[beautiful jekyll theme]: https://beautifuljekyll.com/
[hugo]: https://gohugo.io/
[hugo themes]: https://themes.gohugo.io/
[beautiful hugo]: https://github.com/halogenica/beautifulhugo
[github actions]: https://github.com/features/actions
[`prettier`]: https://prettier.io/
[`dprint`]: https://dprint.dev/
[pyspelling]: https://facelessuser.github.io/pyspelling/
[markdown-link-check]: https://github.com/tcort/markdown-link-check
[github repo actions folder]: https://github.com/mhemeryck/mhemeryck.github.io/tree/33b938480e69477431faff0fb5a292b797aae5ac/.github/workflows
[CV]: https://cv.mhemeryck.com/

[last post]: {{< ref "2021-12-16-unifi_terraform" >}}

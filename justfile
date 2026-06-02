default:
    just --list

serve:
    hugo server -D

build:
    hugo --minify

check:
    dprint check
    hugo --minify

format:
    dprint fmt

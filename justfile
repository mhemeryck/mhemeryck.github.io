set shell := ["nu", "-c"]

default:
    just --list

serve:
    hugo server -D

build:
    hugo --minify
    just cv-pdf

check:
    dprint check
    pyspelling
    hugo --minify
    just cv-pdf

format:
    dprint fmt

cv-pdf:
    mkdir public/cv
    open --raw content/cv.md \
        | str replace --regex '(?s)^\+\+\+\r?\n.*?\r?\n\+\+\+\r?\n*' '' \
        | pandoc - \
            --from markdown+footnotes \
            --pdf-engine typst \
            --template layouts/cv.typ \
            --metadata title=CV \
            --metadata 'author=Martijn Hemeryck' \
            --metadata lang=en \
            --metadata 'mainfont=Liberation Serif' \
            --output public/cv/martijn-hemeryck-cv.pdf

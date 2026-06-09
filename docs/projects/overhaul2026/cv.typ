#let accent = rgb("#1f5f75")
#let accent-muted = rgb("#bfd2d9")
#let body-color = rgb("#202020")
#let muted = rgb("#555555")

#set page(
  paper: "a4",
  margin: (x: 18mm, y: 15mm),
  numbering: "1",
)

#set text(
  font: "IBM Plex Sans",
  size: 10pt,
  fill: body-color,
  lang: "en",
)

#set par(
  leading: 0.64em,
  spacing: 0.55em,
)

#show link: it => {
  set text(fill: accent)
  it
}

#show list: it => {
  set list(marker: "-", indent: 1.15em, body-indent: 0.45em)
  it
}

#show heading.where(level: 1): it => {
  v(0.85em)
  text(
    font: "IBM Plex Mono",
    size: 14pt,
    weight: "bold",
    fill: accent,
    tracking: 0.5pt,
  )[#it.body]
  v(0.28em)
  line(length: 100%, stroke: 0.6pt + accent-muted)
  v(0.36em)
}

#show heading.where(level: 2): it => {
  v(0.7em)
  text(
    font: "IBM Plex Mono",
    size: 9.5pt,
    weight: "bold",
    fill: accent,
    tracking: 0.35pt,
  )[#upper(it.body)]
  v(0.22em)
}

#show heading.where(level: 3): it => {
  v(0.45em)
  text(size: 10pt, weight: "bold")[#it.body]
}

#show heading.where(level: 4): it => {
  v(0.36em)
  text(
    font: "IBM Plex Mono",
    size: 8.4pt,
    weight: "bold",
    fill: muted,
  )[#it.body]
}

#show strong: it => text(weight: "bold")[#it.body]

#grid(
  columns: (1fr, 24mm),
  gutter: 7mm,
  align: (left, center),
  [
    #text(
      font: "IBM Plex Mono",
      size: 18pt,
      weight: "bold",
      fill: accent,
      tracking: 0.8pt,
    )[Martijn Hemeryck]

    #v(0.25em)
    #text(size: 9pt, fill: muted)[
      dev | maker | engineer
    ]
  ],
  [#image("static/about/avatar-160.png", width: 24mm)],
)

#v(0.55em)

$body$

#let accent = rgb("#ffa86a")
#let accent-muted = rgb("#ffd7bd")
#let body-color = rgb("#222129")
#let muted = rgb("#5f5c65")

#set page(
  paper: "a4",
  margin: (x: 17mm, y: 14mm),
  numbering: "1",
)

#set text(
  font: "IBM Plex Sans",
  size: 10pt,
  fill: body-color,
  lang: "en",
)

#set par(
  leading: 0.68em,
  spacing: 0.72em,
)

#show link: it => {
  set text(fill: accent)
  it
}

#show list: it => {
  set list(marker: "-", indent: 1.15em, body-indent: 0.45em, spacing: 0.35em)
  it
}

#show heading.where(level: 1): it => {
  block(above: 1.15em, below: 0.6em)[
    #text(
      font: "FiraCode Nerd Font",
      size: 14pt,
      weight: "bold",
      fill: accent,
      tracking: 0.5pt,
    )[#it.body]
    #v(0.35em)
    #line(length: 100%, stroke: 0.6pt + accent-muted)
  ]
}

#show heading.where(level: 2): it => block(above: 0.95em, below: 0.45em)[
  #text(
    font: "FiraCode Nerd Font",
    size: 9.5pt,
    weight: "bold",
    fill: accent,
    tracking: 0.35pt,
  )[#upper(it.body)]
]

#show heading.where(level: 3): it => block(above: 0.9em, below: 0.7em)[
  #text(size: 10pt, weight: "bold")[#it.body]
]

#show heading.where(level: 4): it => block(above: 0.9em, below: 0.45em)[
  #line(length: 100%, stroke: 0.35pt + rgb("#f0e2d8"))
  #v(0.28em)
  #text(
    font: "FiraCode Nerd Font",
    size: 8.8pt,
    weight: "bold",
    fill: muted,
  )[#it.body]
]

#show strong: it => text(weight: "bold")[#it.body]

#grid(
  columns: (1fr, 24mm),
  gutter: 7mm,
  align: (left, center),
  [
    #text(
      font: "FiraCode Nerd Font",
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

# TokenGenerator

A small program that turns design tokens into code. This is no ~~Dana~~ templating system, only code.

## Motivation

Design systems are great. Your goals might include increased consistency for users, efficient collaboration between disciplines, and saving your team time. Generating code from a shared resource helps with all of those: it cuts down on inconsistencies in manually copying, is faster than manually copying, and lets everybody collaborate on one resource.

Why not a shrink-wrapped “build system” like [this one from Amazon](https://amzn.github.io/style-dictionary/#/)? Or why not talk directly to the [Figma API](https://www.figma.com/developers/api)? Sometimes you don’t need a code- and process-heavy suite of generalized tools just to generate a little code, especially when you’re still in the scrappy stage!

## Installation

Download the latest program from [Releases](https://github.com/loganmoseley/TokenGenerator/releases).

## Usage

The `TokenGenerator` program has one required and two optional parameters:

- `target` — Required. Use `target` to specify the output platform: Android, iOS, or web.
- `--semantic <semantic>` — Optional. Location of the semantic colors. A URL or a local file is fine.
- `--swatch <swatch>` — Optional. Location of the swatch colors. A URL or a local file is fine.

```sh
$./TokenGenerator <target> [--semantic <semantic>] [--swatch <swatch>]
```

The program writes to stdout, so to write a file use the write pipe `>`. It goes `source > file`. For example,

```sh
$ ./TokenGenerator ios --semantic 'URL_HERE' > Semantic.swift
$ ./TokenGenerator android --swatch ~/Downloads/colors.csv > Swatch.xml
$ ./TokenGenerator web --semantic 'URL_HERE' --swatch 'URL_HERE' > _colors.scss
```

Also try out `$./TokenGenerator --help`

## Spreadsheet Format

### Semantic

COLUMNS — The origin spreadsheet must have exactly five columns with these exact names:

- Name
- Light HighContrast
- Light Normal
- Dark
- More Description

ROWS — The rows must be contiguous. You won’t like the output if they’re not. :)

CELLS — All color cells are required. A name’s “More Description” is optional.

## Swatch

COLUMNS — The origin spreadsheet must have exactly two columns with these exact names:

- Name
- Hex Color

ROWS — The rows must be contiguous.

CELLS — All color cells are required.

## Questions, bugs & contributing

If you’ve got a question, found a bug, or are wondering about contributing, please open an [Issue](https://github.com/loganmoseley/TokenGenerator/issues). For contributing, please also read [CONTRIBUTING.md](CONTRIBUTING.md).


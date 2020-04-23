# TokenGenerator

A small program that turns design tokens into code. There are no templates for input for output, only code.

## Motivation

Let’s say you’re establishing a design system. Your goals might include increased consistency for users, efficient collaboration between disciplines, and saving your team time. Generating code from a shared resource helps with all of those: it cuts down on inconsistencies in manually copying, is faster than manually copying, and lets everybody collaborate on one resource.

## Installation

Download the latest program from [Releases](https://github.com/loganmoseley/TokenGenerator/releases).

## Usage

The `TokenGenerator` program has exactly two parameters: `target` and `path`.

- Use `target` to specify the output platform: Android, iOS, or web. *Note: Adding or changing targets is easy!*
- Use `path` to specify the CSV input file.

```sh
$./TokenGenerator <target> <path>
```

The program writes to stdout, so to write a file use the write pipe `>`. It goes `source > file`. For example,

```sh
$ ./TokenGenerator android Colors.csv > Colors.xml
$ ./TokenGenerator ios Colors.csv > Colors.swift
$ ./TokenGenerator web Colors.csv > Colors.scss
```

Also try out `$./TokenGenerator --help`

## File Format

COLUMNS — The origin spreadsheet must have exactly five columns with these exact names:

- Name
- Light HighContrast
- Light Normal
- Dark
- More Description

ROWS — The rows must be contiguous. You won’t like the output if they’re not. :)

CELLS — All color cells are required. A name’s “More Description” is optional.


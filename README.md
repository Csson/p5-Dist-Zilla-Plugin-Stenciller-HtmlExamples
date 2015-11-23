# NAME

Dist::Zilla::Plugin::Stenciller::HtmlExamples - Create Html example files from text files parsed with Stenciller

![Requires Perl 5.14+](https://img.shields.io/badge/perl-5.14+-brightgreen.svg) [![Travis status](https://api.travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples.svg?branch=master)](https://travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples)

# VERSION

Version 0.0001, released 2015-11-23.

# SYNOPSIS

    ; in dist.ini
    ; these are the defaults
    [Stenciller::HtmlExamples]
    source_directory = examples/source
    output_directory = examples
    template_file = examples/source/template.html
    file_pattern = .+\.stencil

# DESCRIPTION

Dist::Zilla::Plugin::Stenciller::HtmlExamples uses [Stenciller](https://metacpan.org/pod/Stenciller) and [Stenciller::Plugin::ToHtmlPreBlock](https://metacpan.org/pod/Stenciller::Plugin::ToHtmlPreBlock) to turn
stencil files in `source_directory` (that matches the `file_pattern`) into
html example files in `output_directory` by applying the `template_file`.

This [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla) plugin does the `FileGatherer` role.

# ATTRIBUTES

## source\_directory

Path to where the stencil files are.

## output\_directory

Path to where the generated files are saved.

## file\_pattern

This is put inside a regular expression (with start and end anchors) to find stencil files in the `source_directory`. The output files
will have the same basename, but the suffix is replaced by `html`. 

## template\_file

The template file is an ordinary html file, with one exception: The first occurence of `[STENCILS]` will be replaced with the
string returned from [Stenciller::Plugin::ToHtmlPreBlock](https://metacpan.org/pod/Stenciller::Plugin::ToHtmlPreBlock). The template file is applied to each stencil file, so the number of generated example files is equal
to the number of stencil files.

# SEE ALSO

- [Stenciller](https://metacpan.org/pod/Stenciller)
- [Stenciller::Plugin::ToHtmlPreBlock](https://metacpan.org/pod/Stenciller::Plugin::ToHtmlPreBlock)

# SOURCE

[https://github.com/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples](https://github.com/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples)

# HOMEPAGE

[https://metacpan.org/release/Dist-Zilla-Plugin-Stenciller-HtmlExamples](https://metacpan.org/release/Dist-Zilla-Plugin-Stenciller-HtmlExamples)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

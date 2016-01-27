# NAME

Dist::Zilla::Plugin::Stenciller::HtmlExamples - Create Html example files from text files parsed with Stenciller

![Requires Perl 5.14+](https://img.shields.io/badge/perl-5.14+-brightgreen.svg) [![Travis status](https://api.travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples.svg?branch=master)](https://travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples)

# VERSION

Version 0.0102, released 2016-01-10.

# SYNOPSIS

    ; in dist.ini
    ; these are the defaults
    [Stenciller::HtmlExamples]
    source_directory = examples/source
    output_directory = examples
    template_file = examples/source/template.html
    file_pattern = .+\.stencil
    output_also_as_html = 0

# DESCRIPTION

Dist::Zilla::Plugin::Stenciller::HtmlExamples uses [Stenciller](https://metacpan.org/pod/Stenciller) and [Stenciller::Plugin::ToHtmlPreBlock](https://metacpan.org/pod/Stenciller::Plugin::ToHtmlPreBlock) to turn
stencil files in `source_directory` (that matches the `file_pattern`) into
html example files in `output_directory` by applying the `template_file`.

This [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla) plugin does the `FileGatherer` role.

# ATTRIBUTES

## source\_directory

## output\_directory

## file\_pattern

## template\_file

## separator

## output\_also\_as\_html

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

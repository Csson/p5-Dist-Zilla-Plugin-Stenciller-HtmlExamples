# NAME

Dist::Zilla::Plugin::Stenciller::HtmlExamples - Create Html example files from text files parsed with Stenciller

![Requires Perl 5.14+](https://img.shields.io/badge/perl-5.14+-brightgreen.svg) [![Travis status](https://api.travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples.svg?branch=master)](https://travis-ci.org/Csson/p5-Dist-Zilla-Plugin-Stenciller-HtmlExamples) 

# VERSION

Version 0.0103, released 2016-01-27.

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

<table cellpadding="0" cellspacing="0">
<tr>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;"><a href="https://metacpan.org/pod/Types::Path::Tiny#Dir">Dir</a></td>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;">optional, default: <code>examples/source</code></td>
    <td style="padding-left: 6px; padding-right: 6px; white-space: nowrap;">read-only</td>
</tr>
</table>

<p>Path to where the stencil files are.</p>

## output\_directory

<table cellpadding="0" cellspacing="0">
<tr>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;"><a href="https://metacpan.org/pod/Types::Path::Tiny#Path">Path</a></td>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;">optional, default: <code>examples</code></td>
    <td style="padding-left: 6px; padding-right: 6px; white-space: nowrap;">read-only</td>
</tr>
</table>

<p>Path to where the generated files are saved.  The output files
will have the same basename as the stencil they are based on, but with the suffix replaced by C<html>.</p>

## file\_pattern

<table cellpadding="0" cellspacing="0">
<tr>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;"><a href="https://metacpan.org/pod/Types::Standard#Str">Str</a></td>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;">optional, default: <code>.+\.stencil</code></td>
    <td style="padding-left: 6px; padding-right: 6px; white-space: nowrap;">read-only</td>
</tr>
</table>

<p>This is used as a part of a regular expression (so do not use start and end anchors) to find stencil files in the C<source_directory>.</p>

## template\_file

<table cellpadding="0" cellspacing="0">
<tr>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;"><a href="https://metacpan.org/pod/Types::Path::Tiny#AbsFile">AbsFile</a></td>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;">optional, default: <code>&#39;template.html&#39; in <a href="#source_directory">&quot;source_directory&quot;</a></code></td>
    <td style="padding-left: 6px; padding-right: 6px; white-space: nowrap;">read-only</td>
</tr>
</table>

<p>The template file should be an html file. The first occurence of C<[STENCILS]> will be replaced with the output from L<Stenciller::Plugin::ToHtmlPreBlock>
for each stencil.</p>

## separator

<table cellpadding="0" cellspacing="0">
<tr>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;"><a href="https://metacpan.org/pod/Types::Standard#Maybe">Maybe</a> [ <a href="https://metacpan.org/pod/Types::Standard#Str">Str</a> ]</td>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;">optional</td>
    <td style="padding-left: 6px; padding-right: 6px; white-space: nowrap;">read-only</td>
</tr>
</table>

<p>Passed on to the L<Stenciller::Plugin::ToHtmlPreBlock> constructor.</p>

## output\_also\_as\_html

<table cellpadding="0" cellspacing="0">
<tr>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;"><a href="https://metacpan.org/pod/Types::Standard#Bool">Bool</a></td>
    <td style="padding-right: 6px; padding-left: 6px; border-right: 1px solid #b8b8b8; white-space: nowrap;">optional, default: <code>0</code></td>
    <td style="padding-left: 6px; padding-right: 6px; white-space: nowrap;">read-only</td>
</tr>
</table>

<p>Passed on to the L<Stenciller::Plugin::ToHtmlPreBlock> constructor.</p>

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

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

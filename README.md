# NAME

Dist::Zilla::Plugin::Stenciller::HtmlExamples - Short intro

![Requires Perl 5.14+](https://img.shields.io/badge/perl-5.14+-brightgreen.svg) [![Travis status](https://api.travis-ci.org//.svg?branch=master)](https://travis-ci.org//)

# VERSION

Version 0.0001, released 2015-11-22.

class Dist::Zilla::Plugin::Stenciller::HtmlExamples with Dist::Zilla::Role::BeforeBuild using Moose {

    # VERSION

    has source_directory => (
        is => 'ro',
        isa => Dir,
        coerce => 1,
        default => 'examples/source',
    );
    has file_pattern => (
        is => 'ro',
        isa => Str,
        default => '.+\.stencil',
    );
    has output_directory => (
        is => 'ro',
        isa => Dir,
        coerce => 1,
        default => 'examples',
    );
    has template_file => (
        is => 'ro',
        isa => AbsFile,
        lazy => 1,
        coerce => 1,
        default => sub { shift->source_directory->child('template.html')->absolute },
    );

    method before_build {
        my $template = $self->template_file->slurp_utf8;
        my @source_files = $self->source_directory->children(qr{^@{[ $self->file_pattern ]}$});

        $self->log('Generating from stencils');

        foreach my $file (@source_files) {
            my $contents = Stenciller->new(filepath => $file->stringify)->transform(plugin_name => 'ToHtmlPreBlock', transform_args => { require_in_extra => { key => 'is_html_example', value => 1, default => 1 }});
            my $all_contents = $template;
            $all_contents =~ s{\[STENCILS\]}{$contents};
            my $new_filename = $file->basename(qr/\.[^.]+$/) . '.html';
            $self->log("Generated $new_filename");
            $self->output_directory->child($new_filename)->spew_utf8($all_contents);
        }
    }
}

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
stencil files in `source_directory` matching the `file_pattern` into
html example files in `output_directory` by applying the `template_file`.

Note that this plugin is run in the **before build** phase: The generated files are created on disk.

# ATTRIBUTES

## source\_directory

Path to where the stencil files are.

## output\_directory

Path to where the generated files are saved.

## file\_pattern

This is put inside a regular expression (with start and end anchors) to find stencil files in the `source_directory`. The output files
will have the same basename, but the suffix is replaced by `html`. 

## template\_file

The template file is an ordinary html file, with one exception. The first occurence of `[STENCILS]` will be replaced with the
string returned from [Stenciller::Plugin::ToHtmlPreBlock](https://metacpan.org/pod/Stenciller::Plugin::ToHtmlPreBlock). This is done once for every source file, so if you have five files matching `file_pattern`,
you will have five example files.

# SEE ALSO

- [Stenciller](https://metacpan.org/pod/Stenciller)
- [Stenciller::Plugin::ToHtmlPreBlock](https://metacpan.org/pod/Stenciller::Plugin::ToHtmlPreBlock)

# HOMEPAGE

[https://metacpan.org/release/Dist-Zilla-Plugin-Stenciller-HtmlExamples](https://metacpan.org/release/Dist-Zilla-Plugin-Stenciller-HtmlExamples)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

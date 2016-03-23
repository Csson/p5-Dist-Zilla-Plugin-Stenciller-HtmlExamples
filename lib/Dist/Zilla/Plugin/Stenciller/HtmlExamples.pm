use 5.10.0;
use strict;
use warnings;

package Dist::Zilla::Plugin::Stenciller::HtmlExamples;

# VERSION
# ABSTRACT: Create Html example files from text files parsed with Stenciller

use Moose;
with 'Dist::Zilla::Role::FileGatherer';
use Stenciller;
use Types::Standard qw/Bool Maybe Str/;
use Types::Path::Tiny qw/AbsFile Dir Path/;
use Types::Stenciller -types;
use Path::Tiny;
use Dist::Zilla::File::InMemory;
use String::Stomp;
use syntax 'qs';
use namespace::autoclean;

has '+zilla' => (
    traits => ['Documented'],
    documentation_order => 0,
);
has '+plugin_name' => (
    traits => ['Documented'],
    documentation_order => 0,
);
has '+logger' => (
    traits => ['Documented'],
    documentation_order => 0,
);

has source_directory => (
    is => 'ro',
    isa => Dir,
    coerce => 1,
    default => 'examples/source',
    traits => ['Documented'],
    documentation => 'Path to where the stencil files are.',
    documentation_order => 1,
);
has file_pattern => (
    is => 'ro',
    isa => Str,
    default => '.+\.stencil',
    traits => ['Documented'],
    documentation => stomp qs{
        This is used as a part of a regular expression (so do not use start and end anchors) to find stencil files in the C<source_directory>.
    },
    documentation_order => 3,
);
has output_directory => (
    is => 'ro',
    isa => Path,
    coerce => 1,
    default => 'examples',
    traits => ['Documented'],
    documentation => stomp qs{
        Path to where the generated files are saved.  The output files
        will have the same basename as the stencil they are based on, but with the suffix replaced by C<html>.
    },
    documentation_order => 2,
);
has template_file => (
    is => 'ro',
    isa => AbsFile,
    lazy => 1,
    coerce => 1,
    default => sub { shift->source_directory->child('template.html')->absolute },
    traits => ['Documented'],
    documentation => stomp qs{
        The template file should be an html file. The first occurence of C<[STENCILS]> will be replaced with the output from L<Stenciller::Plugin::ToHtmlPreBlock>
        for each stencil.
    },
    documentation_default => q{'template.html' in L</source_directory>},
    documentation_order => 4,
);
has separator => (
    is => 'ro',
    isa => Maybe[Str],
    traits => ['Documented'],
    documentation => q{Passed on to the L<Stenciller::Plugin::ToHtmlPreBlock> constructor.},
    documentation_order => 5,
);
has output_also_as_html => (
    is => 'ro',
    isa => Bool,
    default => 0,
    traits => ['Documented'],
    documentation => q{Passed on to the L<Stenciller::Plugin::ToHtmlPreBlock> constructor.},
    documentation_order => 6,
);

sub gather_files {
    my $self = shift;

    my $template = $self->template_file->slurp_utf8;
    my @source_files = $self->source_directory->children(qr{^@{[ $self->file_pattern ]}$});

    $self->log('Generating from stencils');

    foreach my $file (@source_files) {
        my $contents = Stenciller->new(filepath => $file->stringify)->transform(
            plugin_name => 'ToHtmlPreBlock',
            constructor_args => {
                output_also_as_html => $self->output_also_as_html,
                separator => $self->separator,
            },
            transform_args => {
                require_in_extra => {
                    key => 'is_html_example',
                    value => 1,
                    default => 1,
                },
            },
        );
        my $all_contents = $template;
        $all_contents =~ s{\[STENCILS\]}{$contents};
        my $new_filename = $file->basename(qr/\.[^.]+$/) . '.html';
        $self->log("Generated $new_filename");

        my $generated_file = Dist::Zilla::File::InMemory->new(
            name => path($self->output_directory, $new_filename)->stringify,
            content => $all_contents,
        );
        $self->add_file($generated_file);

    }
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

:splint classname Dist::Zilla::Plugin::Stenciller::HtmlExamples

=head1 SYNOPSIS

    ; in dist.ini
    ; these are the defaults
    [Stenciller::HtmlExamples]
    source_directory = examples/source
    output_directory = examples
    template_file = examples/source/template.html
    file_pattern = .+\.stencil
    output_also_as_html = 0

=head1 DESCRIPTION

Dist::Zilla::Plugin::Stenciller::HtmlExamples uses L<Stenciller> and L<Stenciller::Plugin::ToHtmlPreBlock> to turn
stencil files in C<source_directory> (that matches the C<file_pattern>) into
html example files in C<output_directory> by applying the C<template_file>.

This L<Dist::Zilla> plugin does the C<FileGatherer> role.

=head1 ATTRIBUTES

:splint attributes

=head1 SEE ALSO

=for :list
* L<Stenciller>
* L<Stenciller::Plugin::ToHtmlPreBlock>

=cut

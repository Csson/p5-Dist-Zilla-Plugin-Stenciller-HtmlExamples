use 5.14.0;
use strict;
use warnings;

package Dist::Zilla::Plugin::Stenciller::HtmlExamples {

    # VERSION
    # ABSTRACT: Create Html example files from text files parsed with Stenciller

    use Moose;
    with 'Dist::Zilla::Role::FileGatherer';
    use Stenciller;
    use Types::Stenciller -types;
    use Path::Tiny;
    use Dist::Zilla::File::InMemory;

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
        isa => Path,
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
    has output_also_as_html => (
        is => 'ro',
        isa => Bool,
        default => 0,
    );
    has separator => (
        is => 'ro',
        isa => Maybe[Str],
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

}

1;

__END__

=pod

=head1 SYNOPSIS

    ; in dist.ini
    ; these are the defaults
    [Stenciller::HtmlExamples]
    source_directory = examples/source
    output_directory = examples
    template_file = examples/source/template.html
    file_pattern = .+\.stencil

=head1 DESCRIPTION

Dist::Zilla::Plugin::Stenciller::HtmlExamples uses L<Stenciller> and L<Stenciller::Plugin::ToHtmlPreBlock> to turn
stencil files in C<source_directory> (that matches the C<file_pattern>) into
html example files in C<output_directory> by applying the C<template_file>.

This L<Dist::Zilla> plugin does the C<FileGatherer> role.

=head1 ATTRIBUTES

=head2 source_directory

Path to where the stencil files are.

=head2 output_directory

Path to where the generated files are saved.

=head2 file_pattern

This is put inside a regular expression (with start and end anchors) to find stencil files in the C<source_directory>. The output files
will have the same basename, but the suffix is replaced by C<html>. 

=head2 template_file

The template file is an ordinary html file, with one exception: The first occurence of C<[STENCILS]> will be replaced with the
string returned from L<Stenciller::Plugin::ToHtmlPreBlock>. The template file is applied to each stencil file, so the number of generated example files is equal
to the number of stencil files.

=head1 SEE ALSO

=for :list
* L<Stenciller>
* L<Stenciller::Plugin::ToHtmlPreBlock>

=cut

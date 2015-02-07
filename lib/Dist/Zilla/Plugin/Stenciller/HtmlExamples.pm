use Stenciller::Standard imports => [
    'Stenciller' => [],
    'Dist::Zilla::File::InMemory' => [],
];

# PODCLASSNAME
# ABSTRACT: Short intro

class Dist::Zilla::Plugin::Stenciller::HtmlExamples with Dist::Zilla::Role::FileGatherer using Moose {

    # VERSION

    has source_directory => (
        is => 'ro',
        isa => Dir,
        coerce => 1,
        default => 'examples/source',
    );
    has file_pattern => (
        is => 'ro',
        isa => RegexpRef,
        default => sub { qr{.+\.stencil$} },
    );
    has output_directory => (
        is => 'ro',
        isa => Dir,
        coerce => 1,
        default => 'examples',
    );
    has template_file => (
        is => 'ro',
        isa => File,
        lazy => 1,
        coerce => 1,
        default => sub { shift->source_directory->child('template.html') },
    );

    method gather_files {
        my $template = $self->template_file->slurp_utf8;
        my @source_files = $self->source_directory->children($self->file_pattern);
    }

}




1;


__END__

=pod

=head1 SYNOPSIS

    use Dist::Zilla::Plugin::Stenciller::HtmlExamples;

=head1 DESCRIPTION

Dist::Zilla::Plugin::Stenciller::HtmlExamples is ...

=head1 SEE ALSO

=cut

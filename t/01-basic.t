use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::DZil;
use File::Temp 'tempdir';
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Dist::Zilla::Plugin::Stenciller::HtmlExamples;

ok 1;

my $tempdir = tempdir();

my $tzil = Builder->from_config(
    {   dist_root => 't/whatever' },
    {   add_files => {
            'source/dist.ini' => simple_ini(
                ['Stenciller::HtmlExamples' => {
                    source_directory => 't/corpus',
                    output_directory => $tempdir,

                }],
            )
        }
    },
);
$tzil->build;

done_testing;

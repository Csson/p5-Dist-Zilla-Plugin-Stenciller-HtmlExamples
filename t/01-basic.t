use 5.10.1;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::DZil;
use Test::Differences;
use Path::Tiny;
use File::Temp 'tempdir';
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Dist::Zilla::Plugin::Stenciller::HtmlExamples;

ok 1;

my $tempdir = path(tempdir());
$tempdir->child('example')->mkpath;
diag "tempdir: $tempdir";
my $tzil = Builder->from_config(
    {   dist_root => 'corpus' },
    {   add_files => {
            'source/t/corpus/template.html' => path('t/corpus/template.html')->slurp_utf8,
            'source/t/corpus/01-test.stencil' => path('t/corpus/01-test.stencil')->slurp_utf8,
            'source/example/du.mmy' => '',
            'source/dist.ini' => simple_ini(
                ['Stenciller::HtmlExamples' => {
                    source_directory => 't/corpus',
                    file_pattern => '.+\.stencil',
                    output_directory => $tempdir->child('example')->stringify,
                    template_file => 't/corpus/template.html',
                }],
            )
        }
    },
);

$tzil->build;

my $generated_html = $tzil->slurp_file('example/01-test.html');
eq_or_diff $generated_html, expected_html(), 'Generated correct html';

done_testing;

sub expected_html {
    return qq{<!DOCTYPE html>
<html>
    <head>
        <title>Stencils</title>
    </head>
    <body>
        <div class="container">
            


<pre>&lt;% badge &#39;3&#39; %&gt;</pre>
<pre>&lt;span class=&quot;badge&quot;&gt;3&lt;/span&gt;</pre>
        </div>
    </body>
</html>
};

}

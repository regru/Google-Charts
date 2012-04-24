# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Google-Charts.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;

use strict;
use warnings;

BEGIN { use_ok('Google::Charts') };

is(
    get_chart_url(
        labels => [ 'a', 'b', 'c', 'd', 'e'],
        data =>   [ 1,   2,    3,  4,   5],
        generate_html => 1,
    ),
    'http://chart.apis.google.com/chart?cht=p3&amp;chf=bg,s,44ccff&amp;chl=%39&amp;chs=500x150&amp;chd=t:1,2,3,4,5'
);

is(
    get_chart_url(
        labels => [ 'test label', 'test label2' ],
        data   => [ 50, 100 ], 
        type   => 'p',
    ),
    'http://chart.apis.google.com/chart?cht=p&chf=bg,s,44ccff&chl=%32%32&chs=500x150&chd=t:50,100'
);


package Google::Charts;

use strict;
use warnings;

use Exporter::Lite;
use Encode qw( decode encode from_to );

our $VERSION = '0.02';

our @EXPORT  = qw/get_chart_url/;

# Work only without use utf8 pragma!!!
sub urlescape_utf8 {
    my ($text) = @_;

    $text = from_to( $text, 'cp1251', 'utf-8' );

    return join '', map { sprintf("%%%2.2x", ord) } split '|', $text;
}

# Create diagramm URL for service Google::Charts
# STATIC
sub get_chart_url {
    my %param = @_;

    return '' unless ref $param{labels} eq 'ARRAY' &&  @{ $param{labels} } &&
        ref $param{data} eq 'ARRAY' && @{ $param{data} };

    my $gc = 'http://chart.apis.google.com/chart?';

    my %chart = (
        chs =>          # is the chart's size in pixels
            '500x150',
        cht =>          # is the chart's type
            $param{type} || 'p3',
        chd =>          # is the chart's data
            't:' . ( join ',', @{ $param{data} } ),
        chl =>          # is the chart's label
            urlescape_utf8( join '|', @{ $param{labels} }),
        chf =>          # solid fill
            'bg,s,44ccff',
    );
    
    my $delimiter = $param{generate_html} ? '&amp;' : '&';

    return $gc . join $delimiter, map { join '=', $_, $chart{$_} } keys %chart;
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Google::Charts - Perl extension for Google Charts web service
Don`t use this module! Use URI::GoogleChart!

=head1 SYNOPSIS

  use Google::Charts;
  
    my $chart = get_chart_url(
        labels => [ 'a', 'b', 'c', 'd', 'e'],
        data =>   [ 1,   2,    3,  4,   5],
        generate_html => 1,
    );

    my $yachart = get_chart_url(
        labels => [ 'test label', 'test label2' ],
        data   => [ 50, 100 ], 
        type   => 'p',
    ),

=head1 DESCRIPTION

Stub documentation for Google::Charts, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

nrg, E<lt>nrg@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by nrg

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut

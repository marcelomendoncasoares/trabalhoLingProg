use strict;
use warnings;
use 5.010;
use Time::Piece;

my $date1 = 'Fri Aug 30 10:53:38 2013';
my $date2 = 'Fri Aug 30 02:12:25 2013';

my $format = '%a %b %d %H:%M:%S %Y';

my $diff = Time::Piece->strptime($date1, $format) - Time::Piece->strptime($date2, $format);

say $diff/(3600*24);
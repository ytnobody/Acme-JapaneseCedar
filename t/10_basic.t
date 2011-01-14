use Test::More tests => 2;
use Acme::JapaneseCedar;
use Data::Dumper;

my $sugi = Acme::JapaneseCedar->new;
isa_ok $sugi, 'Acme::JapaneseCedar';

warn Dumper( $sugi );
undef $sugi;
warn Dumper( $sugi );

warn Dumper( $Atmosphere::air );

use Test::More tests => 2;
use Acme::JapaneseCedar;
use Data::Dumper;

my $sugi = Acme::JapaneseCedar->new;
isa_ok $sugi, 'Acme::JapaneseCedar';

warn Dumper( $sugi->_peek );

# felling( $sugi, axe );

# is $sugi, undef;
# warn Dumper( $Atmosphere::air );

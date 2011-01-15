use Test::More tests => 18;
use Acme::JapaneseCedar;
use DateTime;

my $dt = DateTime->from_epoch( epoch => time() );
chk_blast( sleepin => 366, wakeup => 1, age => 26 );
chk_noblast( sleepin => 366, wakeup => 1, age => 25 );
chk_blast( sleepin => $dt->day_of_year, wakeup => $dt->day_of_year, age => 26 );
chk_noblast( sleepin => $dt->day_of_year, wakeup => $dt->day_of_year, age => 25 );
chk_noblast( sleepin => 1000, wakeup => 1000, age => 26 );
chk_noblast( sleepin => 1000, wakeup => 1000, age => 25 );

sub chk_blast {
    my $sugi = Acme::JapaneseCedar->new( @_ );
    isa_ok $sugi, 'Acme::JapaneseCedar';

    my $pollens = 0;
    is $Atmosphere::air->[0], 'pollen of japanese cedar';
    $pollens = @$Atmosphere::air;

    undef $sugi;
    my $pollens_after = @$Atmosphere::air;
    ok $pollens_after >= $pollens;
    $Atmosphere::air = [];
}

sub chk_noblast {
    my $sugi = Acme::JapaneseCedar->new( @_ );
    isa_ok $sugi, 'Acme::JapaneseCedar';

    is $Atmosphere::air->[0], undef;

    undef $sugi;
    is $Atmosphere::air->[0], undef;
    $Atmosphere::air = [];
}

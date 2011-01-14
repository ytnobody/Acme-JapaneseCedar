package Acme::JapaneseCedar;
use strict;
use warnings;
use vars qw( $VERSION @EXPORT );
$VERSION = '0.01';

use Class::InsideOut qw/ private register id /;
use Data::Dumper;
use DateTime;
use Time::HiRes qw/ sleep /;
use POSIX qw/ ceil /;
use Exporter qw/ import /;
@EXPORT = qw/ felling axe saw /;

private ascus => my %ascus;
private age => my %age;
private doy => my %doy;
private wakeup => my %wakeup;
private sleepin => my %sleepin;

sub new {
    my $class = shift;
    my $self = bless \( my $scalar ), $class;
    register( $self );
    $doy{ id $self } = DateTime->from_epoch( epoch => time() )->day_of_year;
    $age{ id $self } = $self->_rand_age;
    $wakeup{ id $self } = 37 + int(rand(15));
    $sleepin{ id $self } = 131 + int(rand(15));
    $self->_set_ascus;
    $self->_blast;
    return $self;
}

sub _blast {
    my $self = shift;
    my $blasted = $self->_blast_force;
    $blasted = $blasted > $ascus{ id $self } ? $ascus{ id $self } : $blasted;
    $ascus{ id $self } -= $blasted;
    my $pollens = $blasted * ceil(rand(30)+3);
    my $air = $self->_air;
    push @{ $$air }, 'pollen of japanese cedar' for 1 .. $pollens;
}

sub _rand_age { $age{ id shift } = ceil(rand(20)) * ceil(rand(10)) }

sub _set_ascus { 
    my $self = shift;
    $ascus{ id $self } = abs( 60 - ( $age{ id $self } - 60 ) + int(rand(100)) ) if $age{ id $self } > 25;
    $ascus{ id $self } = 0 unless $ascus{ id $self };
}

sub _blast_force {
    my $self = shift;
    ceil( (abs 40 - ($doy{ id $self } - 65) ) / 10 ) if $self->_is_blastable;
}

sub _is_blastable {
    my $self = shift;
    my $is_spring = $doy{ id $self } >= $wakeup{ id $self } && $doy{ id $self } <= $sleepin{ id $self } ? 1 : 0;
}

sub _air {
    no warnings;
    $Atomosphere::air ||= [];
    \$Atmosphere::air;
}

sub _vanish {

}

sub _wane {
    my ( $self, $item ) = @_;
    my $type = ref $item;
    if ( $type =~ /(Axe|Saw)/ ) {
        warn "'Ummm, Ummm, Ummm!'\n";
        sleep sprintf( '%0.04f', ( $age{ id $self } / $$item ) );
        $self->_blast for 1 .. $$item;
        $self->_vanish;
    }
    else {
        warn "Couldn't felling it.\n";
    }
}

sub felling {
    my ( $target, $item ) = @_;
    $target->_wane( $item );
    $target = undef;
}

sub axe { my $num = 20; bless \$num, 'Axe' };

sub saw { my $num = 10; bless \$num, 'Saw' };

1;
__END__

=head1 NAME

Acme::JapaneseCedar - 杉の木です。

=head1 SYNOPSIS

  use Acme::JapaneseCedar;
  
  # もし春なら、この時点で花粉がすこしバラ撒かれ、くしゃみをしてしまうでしょう。
  my $sugi = Acme::JapaneseCedar->new;

どうにかして切り倒してください。うまく切り倒せたら、薪にして火でも起こしましょう！

=head1 DESCRIPTION

杉です。日本人ならご存知の、春になると花粉をバラ撒く鬱陶しい木です。花粉症の身としては、全部ブッタ切ってやりたいところです。

実際に杉の木を切り倒すには、法規や環境、さらには体力等など、色々と問題があって実現できないわけですが、Perlでやる分には自由です。Larry Wallとリャマに感謝しつつ、存分にブッタ切りましょう。切った後はよく乾かして薪にすると、火をおこせますよ。

=head1 AUTHOR

azuma satoshi E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

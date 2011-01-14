package Acme::JapaneseCedar;
use Mouse;
use vars qw( $VERSION @EXPORT );
$VERSION = '0.01';

use DateTime;
use Time::HiRes qw/ sleep /;
use POSIX qw/ ceil /;

{
    package UNIVERSAL;
    use Class::Method::Modifiers;
    use Acme::Sneeze::JP;
    before qw/ sneeze / => sub {
        warn "Achoo!!\n";
    };
}

has ascus => ( is => 'rw' );
has age => ( is => 'rw' );
has doy => ( is => 'rw' );
has wakeup => ( is => 'rw' );
has sleepin => ( is => 'rw' );

sub BUILD {
    my $self = shift;
    $self->wakeup( 10 + int(rand(40)) );
    $self->sleepin( 131 + int(rand(15)) );
    $self->doy( DateTime->from_epoch( epoch => time() )->day_of_year );
    $self->_rand_age;
    $self->_set_ascus;
    $self->_blast;
}

sub _blast {
    my $self = shift;
    my $blasted = $self->_blast_force;
    $blasted = $blasted > $self->ascus ? $self->ascus : $blasted;
    $self->ascus( $self->ascus - $blasted );
    my $pollens = $blasted * ceil(rand(30)+3);
    my $air = $self->_air;
    push @{ $$air }, 'pollen of japanese cedar' for 1 .. $pollens;
    sleep 0.3;
    warn "Oh no! Pollens were discharges into atmosphere air!\n" if $pollens;
}

sub _rand_age { shift->age = ceil(rand(20)) * ceil(rand(10)) }

sub _set_ascus { 
    my $self = shift;
    $self->ascus = abs( 60 - ( $self->age - 60 ) + int(rand(100)) ) if $self->age > 25;
    $self->ascus = 0 unless $self->ascus;
}

sub _blast_force {
    my $self = shift;
    ceil( (abs 40 - ($self->doy - 65) ) / 10 ) if $self->_is_blastable;
}

sub _is_blastable {
    my $self = shift;
    my $is_spring = $self->doy >= $self->wakeup && $self->doy <= $self->sleepin ? 1 : 0;
}

sub _air {
    no warnings;
    $Atomosphere::air ||= [];
    \$Atmosphere::air;
}

sub DEMOLISH {
    my $self = shift;
    my $rolls = int( $self->age / 5 );
    $self->_blast for 1 .. $rolls;
}

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

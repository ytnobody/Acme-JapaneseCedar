package Acme::JapaneseCedar;
use Mouse;
use vars qw( $VERSION @EXPORT );
$VERSION = '0.01';

use DateTime;
use Time::HiRes qw/ sleep /;
use POSIX qw/ ceil /;

has ascus => ( is => 'rw', isa => 'Int' );
has age => ( is => 'rw', isa => 'Int' );
has doy => ( is => 'rw', isa => 'Int' );
has wakeup => ( is => 'rw', isa => 'Int' );
has sleepin => ( is => 'rw', isa => 'Int' );

sub BUILD {
    my $self = shift;
    $self->_air;
    $self->wakeup( 5 + int(rand(40)) ) unless defined $self->wakeup;
    $self->sleepin( 131 + int(rand(15)) ) unless defined $self->sleepin;
    $self->age( ceil(rand(20)) * ceil(rand(10)) ) unless defined $self->age;
    $self->_set_ascus;
    $self->_blast;
}

sub sneeze {
    my $self = shift;
    warn "Achoo!!\n";
}

sub _blast {
    my $self = shift;
    $self->_is_blastable;
    my $blasted = $self->_blast_force;
    $blasted = $blasted > $self->ascus ? $self->ascus : $blasted;
    $self->ascus( $self->ascus - $blasted );
    my $pollens = $blasted * ceil(rand(30)+3);
    my $air = $self->_air;
    push @{ $$air }, 'pollen of japanese cedar' for 1 .. $pollens;
    $self->sneeze if $pollens;
    return $pollens;
}

sub _doy { DateTime->from_epoch( epoch => time() )->day_of_year }

sub _felling {
    my $self = shift;
    my $pollens = $self->_blast;
    sleep 0.2;
    warn "Alley-oop!\n";
    $self->sneeze if $pollens > 10;
    warn "Sxxt, this japanese cedar is so robustness!\n" if int( rand( 100 ) ) < 7;
    sleep 0.6;
    warn "Oh no! Pollens were discharges into atmosphere air!\n" if $pollens;
}

sub _set_ascus { 
    my $self = shift;
    $self->ascus( abs( 60 - ( $self->age - 60 ) + int(rand(100)) ) ) if $self->age > 25;
    $self->ascus( 0 ) unless $self->ascus;
}

sub _blast_force {
    my $self = shift;
    ceil( (abs 40 - ($self->doy - 65) ) / 10 ) if $self->_is_blastable;
}

sub _is_blastable {
    my $self = shift;
    $self->doy( $self->_doy );
    $self->doy >= $self->wakeup && $self->doy <= $self->sleepin ? 1 : 0;
}

sub _air {
    no warnings;
    $Atomosphere::air ||= [];
    \$Atmosphere::air;
}

sub DEMOLISH {
    my $self = shift;
    my $rolls = int( $self->age / 10 );
    $self->_felling for 1 .. $rolls;
    warn "Okey! This japanese cedar were felled!\n";
}

1;
__END__

=head1 NAME

Acme::JapaneseCedar - 杉の木です。

=head1 SYNOPSIS

杉の木を植えるには、Acme::JapaneseCedarのインスタンスを生成します。

  use Acme::JapaneseCedar;
  
  # もし春なら、この時点で花粉がすこしバラ撒かれます。
  my $sugi = Acme::JapaneseCedar->new;
  
  # 大気の様子は、$Atmosphere::airに格納されます。
  print $_ for @$Atmosphere::air;

この杉の木をDESTROYするには、きこりによる伐採作業が必要なため、少々時間がかかります。

しかも、切り倒した時にも花粉を大量にバラ撒いてきます。

このドキュメントを書いてるだけでも花がむずむずしてきました。。。

=head1 DESCRIPTION

Perlで実装された杉です。日本人ならご存知の、春になると花粉をバラ撒く鬱陶しい木です。花粉症の身としては、全部ブッタ切ってやりたいところです。

実際に杉の木を切り倒すには、法規や環境、さらには体力等など、色々と問題があって実現できないわけですが、Perlでやる分には自由です。

Larry WallとPerlハッカー諸氏、そしてリャマに感謝しつつ、存分に杉の木をブッタ切りましょう。

=head1 AUTHOR

azuma satoshi E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

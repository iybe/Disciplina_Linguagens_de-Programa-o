package CaixaLoja;

use feature "say";

use strict;
use warnings;

sub new{
	my $class = shift;

	my $self = {
		saldo => shift,
		t0 => shift,
		t1 => shift,
		t2 => shift,
		t3 => shift,
		t4 => shift,
		t5 => shift,
		t6 => shift,
		t7 => shift,
		t8 => shift,
		t9 => shift,
	};
	bless $self, $class;
	return $self;
}

sub venda {
	my ($self,$val, $qtd, $op) = @_;

	$self->{saldo}+=($val*$qtd);
	$self->{t9}=$self->{t8};
	$self->{t8}=$self->{t7};
	$self->{t7}=$self->{t6};
	$self->{t6}=$self->{t5};
	$self->{t5}=$self->{t4};
	$self->{t4}=$self->{t3};
	$self->{t3}=$self->{t2};
	$self->{t2}=$self->{t1};
	$self->{t1}=$self->{t0};
	$self->{t0}=$op;

	return;
}

return 1;
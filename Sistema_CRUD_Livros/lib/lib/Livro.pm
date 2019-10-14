package Livro;
use strict;
use warnings;

sub new{
	my $class = shift;

	my $self={
		nome => shift,
		valor => shift,
		qtd => shift,
		id => shift,

	};

	bless $self, $class;

	return $self;
}

sub venda {
	my ($self, $qtd) = @_;

	$self->{qtd}-=$qtd;
	return $self->{valor};

}


return 1;
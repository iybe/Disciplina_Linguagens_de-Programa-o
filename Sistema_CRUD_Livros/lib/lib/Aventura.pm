package Aventura;
use strict;
use warnings;
use feature "say";

use parent 'Livro';

#our @ISA = qw(Livro);

sub new{
	my $class = shift;
	my $self = $class->SUPER::new(shift, shift, shift, shift);
	$self->{ilustracoes} = shift;
	bless $self, $class;

	return $self;
}

sub getInfo{
	my ($self) = @_; 
	my $info = ( $self->{ilustracoes} == 1? "Com ilustracoes": "Sem ilustracoes");
	return say $self->{nome}, $self->{valor}, $self->{qtd}, $self->{id}, $info;;
}

sub tipo{
	return "aventura";
}

return 1;
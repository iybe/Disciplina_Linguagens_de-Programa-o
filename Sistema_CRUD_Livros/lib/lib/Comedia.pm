package Comedia;
use strict;
use warnings;
use feature "say";

use parent 'Livro';

#our @ISA = qw(Livro);

sub new{
	my $class = shift;
	my $self = $class->SUPER::new(shift, shift, shift, shift);
	$self->{brochura} = shift;
	bless $self, $class;

	return $self;
}

sub getInfo{
	my ($self) = @_; 
	my $info = ( $self->{brochura} == 1? "Com brochura": "Sem brochura");
	return say $self->{nome}, $self->{valor}, $self->{qtd}, $self->{id}, $info;;
}

sub tipo{
	return "comedia";
}

return 1;
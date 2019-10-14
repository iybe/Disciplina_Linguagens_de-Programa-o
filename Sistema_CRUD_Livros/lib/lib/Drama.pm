package Drama;
use strict;
use warnings;
use feature "say";

use parent 'Livro';

#our @ISA = qw(Livro);

sub new{
	my $class = shift;
	my $self = $class->SUPER::new(shift, shift, shift, shift);
	$self->{capa_dura} = shift;
	bless $self, $class;

	return $self;
}

sub getInfo{
	my ($self) = @_; 
	my $info = ( $self->{capa_dura} == 1? "Com capa dura": "Sem capa dura");
	return say " TESTE", $self->{nome}, " ", $self->{valor}, " ", $self->{qtd}, " ", $self->{id}, " ", $info;
}

sub tipo{
	return "drama";
}

return 1;
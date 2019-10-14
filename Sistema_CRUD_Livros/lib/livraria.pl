use feature "say";
use strict;
use warnings;
use lib 'lib';

use Aventura;
use Drama;
use Comedia;
use CaixaLoja;

use v5.26.2;

my $decisao;
my @produtos;
my $caixa = new CaixaLoja(0, " ", " "," "," "," "," "," "," "," "," ");

my $arquivo = "dados.txt";

sub gravar{
	open(my $fh,'>',$arquivo);
	close $fh;

	open($fh,'>>',$arquivo);
	my $dif = 0;
	for(my $i = 0; $i < scalar @produtos; $i++){
		if($produtos[$i]->{qtd} == 0){
			$dif++;
		}else{
			say $fh $produtos[$i]->tipo();
			say $fh $produtos[$i]->{nome};
			say $fh $produtos[$i]->{valor};
			say $fh (($produtos[$i]->{qtd})-$dif);
			say $fh $produtos[$i]->{id};
			if($produtos[$i]->tipo() eq "aventura"){
				say $fh $produtos[$i]->{ilustracoes};
			}elsif($produtos[$i]->tipo() eq "drama"){
				say $fh $produtos[$i]->{capa_dura};
			}else{
				say $fh $produtos[$i]->{brochura};
			}
		}
	}
	close $fh;
}

sub acrescenta{
	my $fh;
	open($fh,'>>',$arquivo);
	my $i = (scalar @produtos) - 1;
	if(not($produtos[$i]->{qtd} == 0)){
		say $fh $produtos[$i]->tipo();
		say $fh $produtos[$i]->{nome};
		say $fh $produtos[$i]->{valor};
		say $fh $produtos[$i]->{qtd};
		say $fh $produtos[$i]->{id};
		if($produtos[$i]->tipo() eq "aventura"){
			say $fh $produtos[$i]->{ilustracoes};
		}elsif($produtos[$i]->tipo() eq "drama"){
			say $fh $produtos[$i]->{capa_dura};
		}else{
			say $fh $produtos[$i]->{brochura};
		}
	}
	close $fh;
}

sub carregar{
	open(my $fh,'<',$arquivo);
	my $tipo;
	my $nome;
	my $valor;
	my $qtd;
	my $id;
	my $atributo;
	my $cont = 0;
	while(my $linha = <$fh>){
		if(($cont % 6) == 0){
			chop $linha;
			$tipo = $linha;
		}elsif(($cont % 6) == 1){
			chop $linha;
			$nome = $linha;
		}elsif(($cont % 6) == 2){
			chop $linha;
			$valor = $linha;
		}elsif(($cont % 6) == 3){
			chop $linha;
			$qtd = $linha;
		}elsif(($cont % 6) == 4){
			chop $linha;
			$id = $linha;
		}else{
			chop $linha;
			$atributo = $linha;
			if($tipo eq "aventura"){
				push @produtos, (new Aventura($nome,$qtd,$valor,$id,$atributo));
			}elsif($tipo eq "comedia"){
				push @produtos, (new Comedia($nome,$qtd,$valor,$id,$atributo));
			}else{
				push @produtos, (new Drama($nome,$qtd,$valor,$id,$atributo));
			}
		}
		$cont++;
	}
	close $arquivo;
}

sub findId{
	my @params = @_;
	my $name = $params[0];
	my $id = 0;
	while ($id < (scalar @produtos) and not(@produtos[$id]->{nome} eq $name)) {
		$id++;
	}
	if($id < (scalar @produtos)){
		return $id;
	}else{
		return -1;
	}
}

carregar();
while (1) {
	#system("cls");
	print ( "+---------------------------------------------------------+\n".
			 "|Comando\t|Acao                                     |\n". 
			 "|---------------+-----------------------------------------|\n".
			 "|add\t\t|Adicionar novo produto                   |\n".
	         "|compra\t\t|Comprar produto                          |\n".
	         "|nome\t\t|Nome de um produto (Busca por id)        |\n".
	         "|estoque\t|Estoque de um produto (Busca por nome)   |\n".
	         "|lista\t\t|Lista todos os produtos da loja          |\n".
	         "|preco\t\t|Preco de um produto (Busca por nome)     |\n".
	         "|historico\t|historico de operacoes                   |\n".
			 "|sair\t|sai do programa                   |\n".
	         "+---------------------------------------------------------+\n");
	say "O que voce quer fazer agora?";

	$decisao = <STDIN>;
	chop $decisao;

	given($decisao){
		when('sair'){
			gravar();
			last;
		}
		when ('add') {
			say "digite o nome";
			my $name = <STDIN>;
			chop $name;
			say "digite a quantidade em estoque";
			my $qtd = <STDIN>;
			chop $qtd;
			say "digite o valor";
			my $valor = <STDIN>;
			chop $valor;
			my $id = scalar @produtos;

			say "aventura,comedia ou drama?";
			my $genero = <STDIN>;
			chop $genero;
			if($genero eq "aventura"){
				say "com ilustraçoes(1) ou nao(0)";
				my $resp = <STDIN>;
				push @produtos, (new Aventura($name,$qtd,$valor,$id,$resp));
				acrescenta();
			}elsif($genero eq "comedia"){
				say "com brochura(1) ou nao(0)";
				my $resp = <STDIN>;
				push @produtos, (new Comedia($name,$qtd,$valor,$id,$resp));
				acrescenta();
			}elsif($genero eq "drama"){
				say "com capa dura(1) ou nao(0)";
				my $resp = <STDIN>;
				push @produtos, (new Drama($name,$qtd,$valor,$id,$resp));
				acrescenta();
			}else{
				say "genero nao existente";
			}
		}
		when ('compra') {
			say "Qual produto voce deseja comprar?"; 
			my $name = <STDIN>;
			chop $name;
			my $id = findId($name);
			if($id == -1){
				say "Livro nao encontrado";
			}elsif(@produtos[$id]->{qtd} == 0){
				say "Esse livro nao esta mais em estoque";
			}else{
				say "Quantos voce deseja comprar?";
				my $qtd = <STDIN>;
				chop $qtd;
				if($qtd <= @produtos[$id]->{qtd}){
					my $op = "Venda de ".$qtd." unidade(s) do livro ".$name;
					say $op." CONFIRMADA";
					my $value = @produtos[$id]->venda($qtd);
					$caixa->venda($value, $qtd, $op);
				}else{
					say "Quantidade requerida, nao disponivel";
				}
			}
		}
		when ('nome') { 
			say "Qual id de produto você gostaria de consultar?";
			my $id = <STDIN>;
			say "O nome do livro e ".@produtos[$id]->{nome};
		}
		when ('estoque') { 
			say "Qual produto voce deseja verificar o estoque?"; 
			my $name = <STDIN>;
			chop $name;
			say $name." buscado";
			my $id = findId($name);
			say $id." resp";
			if($id == -1){
				say "Livro nao encontrado";
			}else{
				say "Temos ".@produtos[$id]->{qtd}." em estoque.";
			}
		}
		when ('lista') {
			say "\nnome\t\tquantidade\tvalor\tid";
			foreach my $i (@produtos){
				say $i->{nome}."\t\t".$i->{qtd}."\t\t".$i->{valor}."\t".$i->{id}."\n";
			}
		}
		when ('preco') { 
			say "Qual produto voce deseja verificar o preço?"; 
			my $name = <STDIN>;
			chomp $name;
			my $id = findId($name);
			say "O preço de ".$name." é ".@produtos[$id]->{valor};
		}
		when ('historico') { 
			say "Historico de compras";
			say $caixa->{t0};
			say $caixa->{t1};
			say $caixa->{t2};
			say $caixa->{t3};
			say $caixa->{t4};
			say $caixa->{t5};
			say $caixa->{t6};
			say $caixa->{t7};
			say $caixa->{t8};
			say $caixa->{t9};

		}
		default{}
	}
	say "aperte ENTER para continuar";
	<STDIN>;
}
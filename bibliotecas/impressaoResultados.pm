#
# Linguagens de Programação
# Professor Miguel Campista
#
# Trabalho 2: Módulo de Impressão dos Resultados
# Autores: Lucas Carvalho e Marcelo Soares
#
# Este módulo contém a função responsável por imprimir na tela os resultados do programa.
#

package bibliotecas::impressaoResultados;

use 5.010; # Para habilitar a função 'sprintf'

use strict;
use warnings;

use Exporter qw(import);
 
our @EXPORT_OK = qw(imprimeResultados);

sub imprimeResultados {

	my ($interlocutor1, $interlocutor2, $qtdVezesIniciouConversa, $qtdMsg, $qtdPalavras, $qtdEmoticons, $qtdBlocosMsg) = @_;
	my @interlocutor = ($interlocutor1, $interlocutor2);

	foreach (0,1) {
		print"\n $interlocutor[$_]:\n\tIniciou: @$qtdVezesIniciouConversa[$_] conversas\n";
		print "\tEnviou: @$qtdMsg[$_] mensagens\n";
		print "\tEscreveu: @$qtdPalavras[$_] palavras\n";
		print "\tInseriu: @$qtdEmoticons[$_] emoticons\n";
		say sprintf(" Media de mensagens/vez = %.1f\n", @$qtdMsg[$_]/@$qtdBlocosMsg[$_]);	
	}

	return;
}

1;
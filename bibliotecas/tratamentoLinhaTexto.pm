#
# Linguagens de Programação
# Professor Miguel Campista
#
# Trabalho 2: Módulo de Tratamento de Linha de Texto
# Autores: Lucas Carvalho e Marcelo Soares
#
# Este módulo é responsável por receber uma linha de texto formatado como o whatsapp grava e separar os elementos da linha.
#

package bibliotecas::tratamentoLinhaTexto;

use 5.010; # Para habilitar a função usada da biblioteca Time::Piece

use strict;
use warnings;
use Time::Piece;

use Exporter qw(import);
 
our @EXPORT_OK = qw(trataLinhaTexto);

sub trataLinhaTexto {
	
	my ($linha) = @_;

	# Separa a linha em duas partes, sendo uma a que contém a data em texto, e outra contendo o restante
	my ($dataMsgAtualTexto, $resto) = split /[-](.*)/, $linha;

	my $FORMAT = '%m/%d/%Y, %H:%M ';
	my $dataMsgAtual = Time::Piece->strptime($dataMsgAtualTexto, $FORMAT);

	# Separa o resto da linha em nome do interlocutor atual e mensagem
	my ($interlocutorAtual, $msgAtual) = split /[:](.*)/, $resto;

	# Remove o primeiro caracter (espaço) das strings
	$interlocutorAtual =~ s/.//;
	$msgAtual =~ s/.//;

	return ($dataMsgAtual, $interlocutorAtual, $msgAtual);
}
 
1;
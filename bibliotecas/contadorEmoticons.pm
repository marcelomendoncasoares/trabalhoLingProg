#
# Linguagens de Programação
# Professor Miguel Campista
#
# Trabalho 2: Módulo Contador de Emoticons
# Autores: Lucas Carvalho e Marcelo Soares
#
# Este módulo é responsável por receber uma mensagem em texto e retornar a quantidade de emoticons presente na mensagem.
#

package bibliotecas::contadorEmoticons;

use strict;
use warnings;
use POSIX; # Para habilitar a função 'ceil'
 
use Exporter qw(import);
 
our @EXPORT_OK = qw(contaEmoticons);
 
sub contaEmoticons {
	
	my ($msgAtual) = @_;
  	
	#Remove todo caracter que não é emoticon
	$msgAtual =~ s/[^\s\x{0080}-\x{00FF}]+//g;

	@arrayOfCharacteresToRemove = ('à', 'á', 'é', 'í', 'ó', 'ú', 'ã', 'õ', 'ü', 'À', 'Á' , 'É', 'Í', 'Ó', 'Ú', 'Ã', 'Õ', 'Ü', 'ç', 'Ç', 'ª', 'º', '°', '§');
	foreach (@arrayOfCharacteresToRemove) {
		$msgAtual =~ s/$_//g;
	}

	my @arrayPalavras = split(/[\s]+/, $msgAtual);

	# A contagem deve ser manual para identificar emoticons colados um a um, e não como palavras.
	# Cada emoticon normal, do tipo 😵, tem 4 bits, mas os emoticons do tipo  tem apenas 3 bits (muito menos comuns)
	$contador = 0;
	foreach(@arrayPalavras) {
		if ($_ ne "") {
			$contador += length($_)/4;
		}
	}

	# A função 'ceil' arredonda para cima o contador, que fará com que só haja erro de 1 pra cada 4 emoticons de 3 bits na contagem
	return ceil($contador);
}
 
1;
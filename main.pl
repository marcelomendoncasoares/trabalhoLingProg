#
# Linguagens de Programação
# Professor Miguel Campista
#
# Trabalho 2: Módulo Principal do Perl
# Autores: Lucas Carvalho e Marcelo Soares
#
# Este módulo é responsável por processar o arquivo de texto de uma conversa entre duas pessoas e retornar para o módulo C++:
# 
# Quem inicia a conversa;
# Quantidade de palavras por mensagens;
# Quantidade de mensagens enviadas por vez;
# Quantidade de emoticons utilizados;
# Quantidade total de mensagens trocadas na conversa;
# Quantidade total de palavras escritas
# 

use 5.010; # Para habilitar a função usada da biblioteca Time::Piece
use strict;
use warnings;
use Time::Piece;

# Habilita a inclusão do diretório atual como caminho '/lib' para a busca das bibliotecas locais
use File::Basename qw(dirname);
use Cwd  qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

# Inclusão dos módulos do código perl
use bibliotecas::contadorEmoticons qw(contaEmoticons);
use bibliotecas::tratamentoLinhaTexto qw(trataLinhaTexto);
use bibliotecas::impressaoResultados qw(imprimeResultados);

my $HORAS_MIN = 10; # Número de horas para ser considerado uma nova conversa 

# Declaração das variáveis globais que serão utilizadas para o cálculo das saídas do programa
# Cada array guarda uma variável para cada interlocutor

my $interlocutor1 = "";
my $interlocutor2 = "";
my @qtdPalavras = (0, 0);
my @qtdEmoticonsTexto = (0, 0);
my @qtdEmoticonsEmoji = (0, 0);
my @qtdMsg = (0, 0);
my @qtdBlocosMsg = (0, 0); # Blocos de mensagens ininterruptos
my @qtdVezesIniciouConversa = (0, 0);


# Se não for passado o nome do arquivo, encerra o programa com o erro equivalente
($ARGV[0]) or die "--ERRO: não foi passado nome de arquivo texto como argumento.\n\n O programa deve receber o nome de um arquivo texto de conversa do whatsapp entre duas pessoas como argumento.\n";

# Pega o nome do arquivo como argumento passado ao programa em Perl
my $nomeArquivo = $ARGV[0];

# Verifica se o arquivo é vazio antes de abrir
!(-z $nomeArquivo) or die "--ERRO: o arquivo está vazio.\n\n O programa deve receber o nome de um arquivo texto de conversa do whatsapp entre duas pessoas como argumento.\n";
open(my $arquivo, "<", $nomeArquivo) or die "Couldn't open file , $!";

# Declaração das variáveis utilizadas no loop while de varredura do arquivo
my ($dataMsgAnterior, $dataMsgAtual, $msgAtual, $interlocutorAtual, $indice, $indiceAnterior);

# Processa o arquivo linha a linha, sabendo que cada linha corresponde a uma mensagem
while (my $linha = <$arquivo>) {

	# Remove newLine character
	chomp($linha);

	# Pula linhas vazias 
	while ($linha =~ /^$/) {
		$linha = <$arquivo>;
	}

	# Se a linha não começar com data, apenas adiciona as palavras ao mesmo interlocutor
	if ($linha =~ /^\d\d\/\d\d\/\d\d\d\d/) {
		($dataMsgAtual, $interlocutorAtual, $msgAtual) = trataLinhaTexto($linha);
	}
	else {
		# Não precisa do 'our' porque nunca será uma declaração: o arquvo nunca terá a primeria linha não começando com data.
		$msgAtual = $linha;
	}

	# Inicializa a dataMsgAnterior para o caso da primeira mensagem
	if (!$dataMsgAnterior) {
		$dataMsgAnterior = $dataMsgAtual;
	}

	# Declara o interlocutor1 e interlocutor2 se não estiverem declarados ainda, colocando o anterior como sendo o próprio atual
	if (!$interlocutor1) {
		$interlocutor1 = $interlocutorAtual;
		$qtdVezesIniciouConversa[0]++;
		$indiceAnterior = 0; # Valor do índice para o interlocutor1
	}
	elsif (!$interlocutor2 && ($interlocutorAtual ne $interlocutor1)){
		$interlocutor2 = $interlocutorAtual;
	}

	# Define qual o interlocutor atual para o caso de ambos já haverem sido declarados
	if ($interlocutorAtual eq $interlocutor1) {
		$indice = 0;
	}
	else {
		$indice = 1;	
	}

	# Verificação de diferença de data para incrementar quem começa a nova conversa
	my $diferencaDataEmHoras = ($dataMsgAtual - $dataMsgAnterior)/3600;
	
	if ($diferencaDataEmHoras > $HORAS_MIN) {
		$qtdVezesIniciouConversa[$indice]++;
	}

	# Incrementa a quantidade de mensagens para o interlocutorAtual
	$qtdMsg[$indice]++;

	# Conta a quantidade de palavras na mensagem e incrementa no contador do interlocutorAtual
	my @msgAtualArrayPalavras = split(/[\s]+/, $msgAtual);
	$qtdPalavras[$indice] += scalar(@msgAtualArrayPalavras);

	# Contador de blocos de mensagens ininterruptos (conta +1 para o interlocutor anterior sempre que mudar de interlocutor)	
	if ($indice != $indiceAnterior) {
		$qtdBlocosMsg[$indiceAnterior]++;
	}

	# Contador de emoticon por interlocutor
	my ($temp1, $temp2) = contaEmoticons($msgAtual);

	$qtdEmoticonsTexto[$indice] += $temp1;
	$qtdEmoticonsEmoji[$indice] += $temp2;

	$indiceAnterior = $indice;
	$dataMsgAnterior = $dataMsgAtual;
}

close($arquivo) or die "Couldn't close file properly";

imprimeResultados($interlocutor1, $interlocutor2, \@qtdVezesIniciouConversa, \@qtdMsg, \@qtdPalavras, \@qtdEmoticonsTexto, \@qtdEmoticonsEmoji, \@qtdBlocosMsg);
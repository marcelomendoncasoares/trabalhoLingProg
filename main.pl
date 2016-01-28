#
# Linguagens de Programação
# Professor Miguel Campista
#
# Trabalho 2: Módulo Perl
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

# Premissa 2: 
#

use 5.010; # Para habilitar a função usada da biblioteca Time::Piece

use warnings;
use Time::Piece;

# Habilita a inclusão do diretório atual como caminho '/lib' para a busca das bibliotecas locais
use File::Basename qw(dirname);
use Cwd  qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

# Inclusão dos módulos do código perl
use bibliotecas::contadorEmoticons qw(contaEmoticons);
use bibliotecas::tratamentoLinhaTexto qw(trataLinhaTexto);


$HORAS_MIN = 10; # Número de horas para ser considerado uma nova conversa 

# Declaração das variáveis globais que serão utilizadas para o cálculo das saídas do programa
# Cada array guarda uma variável para cada interlocutor

$interlocutor1 = "";
$interlocutor2 = "";
@qtdPalavras = (0, 0);
@qtdEmoticons = (0, 0);
@qtdMsg = (0, 0);
@qtdBlocosMsg = (0, 0); # Blocos de mensagens ininterruptos
@qtdVezesIniciouConversa = (0, 0);

# Pega o nome do arquivo como argumento passado ao programa em Perl
$nomeArquivo = $ARGV[0];


open(my $arquivo, "<", $nomeArquivo) or die "Couldn't open file , $!";

# Processa o arquivo linha a linha, sabendo que cada linha corresponde a uma mensagem
while (my $linha = <$arquivo>) {

	# Remove newLine character
	chomp($linha);

	# Pula linhas vazias ou que não comecem com data para evitar erros (ocorrência muito baixa, pode ser desprezada)
	while (($linha =~ /^$/) or ($linha !~ /^\d\d\/\d\d\/\d\d\d\d/)) {
		$linha = <$arquivo>;
	}

	my ($dataMsgAtual, $interlocutorAtual, $msgAtual) = trataLinhaTexto($linha);

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
	my @msgAtualArrayPalavras = split /[\s]+/, $msgAtual;
	$qtdPalavras[$indice] += scalar(@msgAtualArrayPalavras);

	# Contador de blocos de mensagens ininterruptos (conta +1 para o interlocutor anterior sempre que mudar de interlocutor)	
	if ($indice != $indiceAnterior) {
		$qtdBlocosMsg[$indiceAnterior]++;
	}

	# Contador de emoticon por interlocutor
	$qtdEmoticons[$indice] += contaEmoticons($msgAtual);


	$indiceAnterior = $indice;
	$dataMsgAnterior = $dataMsgAtual;
}

close($arquivo) or die "Couldn't close file properly";

my $media1 = $qtdMsg[0]/$qtdBlocosMsg[0];
my $media2 = $qtdMsg[1]/$qtdBlocosMsg[1];
	
print"\n $interlocutor1:\n\tiniciou: $qtdVezesIniciouConversa[0]\n\tqtdmsg: $qtdMsg[0]\n\tqtdpalavras: $qtdPalavras[0]\n\tqtdemoticons: $qtdEmoticons[0]\n\tqtdblocos: $qtdBlocosMsg[0]\n";
say sprintf(" Media de mensagens/bloco = %.1f\n", $media1);
print" $interlocutor2:\n\tiniciou: $qtdVezesIniciouConversa[1]\n\tqtdmsg: $qtdMsg[1]\n\tqtdpalavras: $qtdPalavras[1]\n\tqtdemoticons: $qtdEmoticons[1]\n\tqtdblocos: $qtdBlocosMsg[1]\n";
say sprintf(" Media de mensagens/bloco = %.1f\n", $media2);
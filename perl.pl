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

use warnings;
use 5.010; # Para habilitar a função usada da biblioteca Time::Piece
use Time::Piece;

# Declaração das variáveis globais que serão utilizadas para o cálculo das saídas do programa
# Cada array guarda uma variável para cada interlocutor

$HORAS_MIN = 10; # Número de horas para ser considerado uma nova conversa 

$interlocutor1 = "";
$interlocutor2 = "";
@qtdPalavras = (0, 0);
@qtdEmoticons = (0, 0);
@qtdMsg = (0, 0);
@qtdBlocosMsg = (0, 0); # Blocos de mensagens ininterruptos
@qtdVezesIniciouConversa = (0, 0);
# Pega o nome do arquivo como argumento passado ao programa em Perl
$nomeArquivo = $ARGV[0];

# Constante utilizada na formatação da hora para calcular a diferença
$format = '%m/%d/%Y, %H:%M ';

open(my $arquivo, "<", $nomeArquivo) or die "Couldn't open file , $!";

# Processa o arquivo linha a linha, sabendo que cada linha corresponde a uma mensagem
while (my $linha = <$arquivo>) {

	# Remove newLine character
	chomp($linha);

	# Pula linhas vazias para evitar erros
	$linha =~ /^$/ and next;

	# VERIFICA SE A LINHA COMEÇA COM DATA. SE NÃO COMEÇA, SOMA A QUANTIDADE DE PALAVRAS AO INTERLOCUTOR ANTERIOR

	# ============================== DECLARAÇÃO DAS VARIÁVEIS DA MENSAGEM ATUAL =====================================

	# Separa a linha em duas partes, sendo uma a que contém a data em texto, e outra contendo o restante
	my ($dataMsgAtual, $resto) = split /[-](.*)/, $linha;

	# Inicializa a dataMsgAnterior para o caso da primeira mensagem
	if (!$dataMsgAnterior) {
		$dataMsgAnterior = $dataMsgAtual;
	}

	# Separa o resto da linha em nome do interlocutor atual e mensagem
	my ($interlocutorAtual, $msgAtual) = split /[:](.*)/, $resto;

	# Remove o primeiro caracter (espaço) das strings
	$interlocutorAtual =~ s/.//;
	$msgAtual =~ s/.//;

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

	# ========================== FIM DA DECLARAÇÃO DAS VARIÁVEIS DA MENSAGEM ATUAL ==================================

	# Verificação de diferença de data para incrementar quem começa a nova conversa
	my $diferencaDataEmHoras = (Time::Piece->strptime($dataMsgAtual, $format) - Time::Piece->strptime($dataMsgAnterior, $format))/3600;
	
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

	# Contador de emoticon por interlocutor, que precisa identificar emoticons tipo EMOJI e escritos usando ':', ';', ')', etc



	$indiceAnterior = $indice;
	$dataMsgAnterior = $dataMsgAtual;
}
	my $media1 = $qtdMsg[0]/$qtdBlocosMsg[0];
	my $media2 = $qtdMsg[1]/$qtdBlocosMsg[1];
 	
 	print"\n $interlocutor1:\n\tiniciou: $qtdVezesIniciouConversa[0]\n\tqtdmsg: $qtdMsg[0]\n\tqtdpalavras: $qtdPalavras[0]\n\tqtdblocos: $qtdBlocosMsg[0]\n";
 	say sprintf(" Media de mensagens/bloco = %.1f\n", $media1);
 	print" $interlocutor2:\n\tiniciou: $qtdVezesIniciouConversa[1]\n\tqtdmsg: $qtdMsg[1]\n\tqtdpalavras: $qtdPalavras[1]\n\tqtdblocos: $qtdBlocosMsg[1]\n";
	say sprintf(" Media de mensagens/bloco = %.1f\n", $media2);
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
# Premissa 1: Será considerado nova conversa quando a diferença entre as mensagens for superior ou igual a 24h
# Premissa 2: 
# 
#

use warnings;
use 5.010; # Para habilitar a função usada da biblioteca Time::Piece
use Time::Piece;

# Declaração das variáveis globais que serão utilizadas para o cálculo das saídas do programa
# Cada array guarda uma variável para cada interlocutor

$interlocutor1 = "";
$interlocutor2 = "";
@qtdPalavras = (0, 0);
@qtdEmoticons = (0, 0);
@qtdMsg = (0, 0);
@qtdVezesFalou = (0, 0); # Blocos de mensagens ininterruptos
@qtdVezesIniciouConversa = (0, 0);

# Pega o nome do arquivo como argumento passado ao programa em Perl
$nomeArquivo = $ARGV[0];

# Constante utilizada na formatação da hora para calcular a diferença
$format = '%d/%m/%Y, %H:%M ';

open(arquivo, "<", $nomeArquivo) or die "Couldn't open file , $!";

# Processa o arquivo linha a linha, sabendo que cada linha corresponde a uma mensagem
while (my @linha = arquivo) {

	# ============================== DECLARAÇÃO DAS VARIÁVEIS DA MENSAGEM ATUAL =====================================

	# Separa a linha em duas partes, sendo uma a que contém a data em texto, e outra contendo o restante
	my ($dataMsgAtual, $resto) = split(/[-]+/, $linha);

	# Inicializa a dataMsgAnterior para o caso da primeira mensagem
	if (!$dataMsgAnterior) {
		$dataMsgAnterior = $dataMsgAtual;
	}

	# Separa o resto da linha em nome do interlocutor atual e mensagem
	my ($interlocutorAtual, $msgAtual) = split(/[:]/, $resto);

	# Remove o primeiro caracter (espaço) das strings
	$interlocutorAtual =~ s/.//;
	$msgAtual =~ s/.//;

	# Declara o interlocutor1 e interlocutor2 se não estiverem declarados ainda 
	if (!$interlocutor1) {
		$interlocutor1 = $interlocutorAtual;
		$qtdVezesIniciouConversa[0]++;
	}
	elsif (!$interlocutor2){
		$interlocutor2 = $interlocutorAtual;
	}

	# Define qual o interlocutor atual para o caso de ambos já haverem sido declarados
	if ($interlocutorAtual == $interlocutor1) {
		$indice = 0;
	}
	else {
		$indice = 1;	
	}

	# ========================== FIM DA DECLARAÇÃO DAS VARIÁVEIS DA MENSAGEM ATUAL ==================================

	# Verificação de diferença de data para incrementar quem começa a nova conversa
	my $diferencaDataEmHoras = (Time::Piece->strptime($dataMsgAtual, $format) - Time::Piece->strptime($dataMsgAnterior, $format))/3600;
	
	if ($diferencaDataEmHoras > 24) {
		$qtdVezesIniciouConversa[$indice]++;
	}

	# Conta a quantidade de palavras na mensagem e incrementa no contador do interlocutorAtual
	my @msgAtualArrayPalavras = split(/[\s]+/, $msgAtual);
	$qtdPalavras[$indice] += scalar(@msgAtualArrayPalavras);

	
	# Precisa adicionar:
	#
	# Contador de mensagens por interlocutor
	# Contador de blocos de mensagens ininterruptos (conta +1 para o interlocutor atual sempre que mudar para o outro)
	# Contador de emoticon por interlocutor (como identificar um emoticon?)
	#


	$dataMsgAnterior = $dataMsgAtual;
}
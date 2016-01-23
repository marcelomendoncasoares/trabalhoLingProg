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
use Time::Local;

# Declaração das constantes referentes à formatação das mensagens do whatsapp

use constant NUMERO_CARACTERES_DATA_HORA = 17;
use constant NOME_POSICAO_PRIMEIRA_LETRA = 20;

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

open(arquivo, "<", nomeArquivo) or die "Couldn't open file , $!";

# Processa o arquivo linha a linha (cada linha corresponde a uma mensagem)
# 
# Precisa pegar a data/hora da mensagem e o interlocutor, mantendo registrados também a data/hora e interlocutor da 
# mensagem anterior também fiquem armazenados até a leitura da próxima
#
while (my @linha = arquivo) {

	# Separa a linha em duas partes, sendo uma a que contém a data em texto, e outra contendo o restante
	my ($dataMsgAtualTexto, $resto) = split(/[-]+/, $linha);
	my ($interlocutorAtual, $msgAtual) = split(/[:]/, $resto);

	# Remove o primeiro caracter (espaço) das strings
	$interlocutorAtual =~ s/.//;
	$msgAtual =~ s/.//;

	# Declara o interlocutor1 e interlocutor2 se não estiverem declarados ainda 
	if (!interlocutor1) {
		$interlocutor1 = interlocutorAtual;
		$qtdVezesIniciouConversa[0]++;
	}
	elsif (!interlocutor2){
		$interlocutor2 = interlocutorAtual;
	}

	# Pega a data e hora da mensagem, separa cada pedaço da data e hora e os converte para 'timestamp'
	my ($mday, $mon, $year, $hour, $min) = split(/[\s\/,:]+/, $dataMsgAtualTexto);
	$dataMsgAtual = timelocal(0, $min, $hour, $mday, $mon-1, $year);

	
	# Precisa adicionar:
	#
	# Uma verificação de diferença de tempo das datas para contar a quantidade de vezes que cada um inicia a conversa
	# Contador de palavras por interlocutor (com split por // e length do array resultante)
	# Contador de mensagens por interlocutor
	# Contador de blocos de mensagens ininterruptos (conta +1 para o interlocutor atual sempre que mudar para o outro)
	# Contador de emoticon por interlocutor (como identificar um emoticon?)
	#


	$dataMsgAnterior = $dataMsgAtual;
}
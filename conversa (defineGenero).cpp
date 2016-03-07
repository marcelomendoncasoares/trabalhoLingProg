#include <string>
#include <iostream>
#include <stdlib.h>
#include <vector>
#include "conversa.h"


// Compara em ordem de disparidade encontrada
void Conversa::defineGenero(interlocutor1, interlocutor2) {

	// Foi dada uma pontuação por cada critério, que um ou outro interlocutor ganha por ser maior.
	// A maior pontuação indica o interlocutor de sexo feminino.
	// A variável qtdBlocosMsg é usada apenas no relatório, não importando aqui.

	const int PONTOS_MSG = 4
	const int PONTOS_EMOJIS = 4
	const int PONTOS_VEZES_INICIOU_CONVERSA = 3
	const int PONTOS_EMOTICONS_TEXTO = -1
	const int PONTOS_PALAVRAS = 1


	int pontuacao[2] = (0, 0);

	// Comparação de maior quantidade de mensagens
	if (qtdMsg[0] > qtdMsg[1]) 
		pontuacao[0] += PONTOS_MSG;
	else
		pontuacao[1] += PONTOS_MSG;

	// Comparação de maior quantidade de emoticons emoji enviados
	if (qtdEmoticonsEmoji[0] > qtdEmoticonsEmoji[1])
		pontuacao[0] += PONTOS_EMOJIS;
	else
		pontuacao[1] += PONTOS_EMOJIS;

	// Comparação de maior quantidade de vezes que iniciou conversa, como estabelecido segundo critério no arquivo analisaConversa.pl
	if (qtdVezesIniciouConversa[0] > qtdVezesIniciouConversa[1])
		pontuacao[0] += PONTOS_VEZES_INICIOU_CONVERSA;
	else
		pontuacao[1] += PONTOS_VEZES_INICIOU_CONVERSA;

	// Comparação de maior quantidade de emoticons texto (sexo masculino predominantemente)
	if (qtdEmoticonsTexto[0] > qtdEmoticonsTexto[1])
		pontuacao[0] += PONTOS_EMOTICONS_TEXTO;
	else
		pontuacao[1] += PONTOS_EMOTICONS_TEXTO;

	// Comparação de maior quantidade de palavras (não demonstrou influência determinística)
	if (qtdPalavras[0] > qtdPalavras[1])
		pontuacao[0] += PONTOS_EMOTICONS_TEXTO;
	else
		pontuacao[1] += PONTOS_EMOTICONS_TEXTO;


	// Compara as pontuações finais e determina os gêneros na classe conversa
	if (pontuacao[0] > pontuacao[1]) {
		interlocutora = interlocutor1;
		interlocutor = interlocutor2;
	}
	else {
		interlocutor = interlocutor1;
		interlocutora = interlocutor2;	
	}
}
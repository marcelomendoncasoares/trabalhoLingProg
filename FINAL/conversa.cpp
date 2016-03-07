/*
 *
 * Linguagens de Programação
 * Professor Miguel Campista
 *
 * Trabalho 3: Classes Conversa e Registro
 * Autores: Lucas Carvalho e Marcelo Soares
 *
 */

#include <string>
#include <iostream>
#include <fstream>
#include <EXTERN.h>
#include <perl.h>
#include <stdlib.h>
#include <vector>
#include <stdexcept>
#include "conversa.h"

Conversa::Conversa (string nomeArquivo, PerlInterpreter *my_perl) : arquivo(nomeArquivo) {

	dSP;																	// Inicializa o ponteiro da pilha
	ENTER;																	// Tudo criado à partir daqui...
	SAVETMPS;																// ...são variáveis temporárias
	PUSHMARK(SP);															// Lembra o ponteiro para a pilha
	XPUSHs(sv_2mortal(newSVpv(nomeArquivo.c_str(), nomeArquivo.length())));	// Coloca o nomeArquivo na pilha
	PUTBACK;																// Transforma o ponteiro local para a pilha em global
	int numberElemntsOfStack = perl_call_pv("analisaConversa", G_ARRAY);	// Chama a função em Perl
	SPAGAIN;																// Atualiza o ponteiro para a pilha

	interlocutor[0] = POPp;
	interlocutor[1] = POPp;
	
	for (int index = 0; ((index < 2) && (numberElemntsOfStack > 0)); ++index) {

		qtdVezesIniciouConversa[index] = POPi;
		qtdMsg[index] = POPi;
		qtdPalavras[index] = POPi;
		qtdEmoticonsTexto[index] = POPi;
		qtdEmoticonsEmoji[index] = POPi;
		qtdBlocosMsg[index] = POPi;
	}

	PUTBACK;
	FREETMPS;		// Libera os valores de retorno da memória...
	LEAVE;			// ...e os argumentos "mortal XPUSHed"

	defineGenero();
}

void Conversa::analisarConversa() {

	cout << "\nNome do arquivo de origem: " << arquivo << endl << endl;

	for (int i = 0; i < 2; i++) {

		cout << "\tInterlocutor " << (i + 1) << ": " << interlocutor[i] << "(" << genero[i] << ")" << endl;
		cout << "\tQuantidade vezes que iniciou conversa: " << qtdVezesIniciouConversa[i] << endl;
		cout << "\tQuantidade de mensagens: " << qtdMsg[i] << endl;
		cout << "\tQuantidade de palavras: " << qtdPalavras[i] << endl;
		cout << "\tQuantidade de emoticons de texto: " << qtdEmoticonsTexto[i] << endl;
		cout << "\tQuantidade de emoticons Emoji: " << qtdEmoticonsEmoji[i] << endl;
		cout << "\tQuantidade de mensagens por bloco: " << (qtdMsg[i]/qtdBlocosMsg[i]) << endl << endl;
	}
}

string Conversa::getArquivo() {return arquivo;}

string Conversa::getInterlocutor(int index) {return interlocutor[index];}

string Conversa::getGenero(int index) {return genero[index];}

int Conversa::getQtdVezesIniciouConversa(int index) {return qtdVezesIniciouConversa[index];}

int Conversa::getQtdMsg(int index) {return qtdMsg[index];}

int Conversa::getQtdPalavras(int index) {return qtdPalavras[index];}

int Conversa::getQtdEmoticonsTexto(int index) {return qtdEmoticonsTexto[index];}

int Conversa::getQtdEmoticonsEmoji(int index) {return qtdEmoticonsEmoji[index];}

int Conversa::getQtdBlocosMsg(int index) {return qtdBlocosMsg[index];}

void Conversa::defineGenero() {

	// Foi dada uma pontuação por cada critério, que um ou outro interlocutor ganha por ser maior.
	// A maior pontuação indica o interlocutor de sexo feminino.
	// A variável qtdBlocosMsg é usada apenas no relatório, não importando aqui.

	const int PONTOS_MSG = 4;
	const int PONTOS_EMOJIS = 4;
	const int PONTOS_VEZES_INICIOU_CONVERSA = 3;
	const int PONTOS_EMOTICONS_TEXTO = -1;
	const int PONTOS_PALAVRAS = 1;


	int pontuacao[2] = {0, 0};

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
		genero[0] = "mulher";
		genero[1] = "homem";
	}
	else {
		genero[0] = "homem";
		genero[1] = "mulher";
	}
}

Registro::Registro() {}

void Registro::inserirRegistro (PerlInterpreter *my_perl) {
	
	string nomeArquivo;

	cout << "Insira o caminho e nome do arquivo da conversa: " << endl;
	cin >> nomeArquivo;

	Conversa *conversaTeste = new Conversa(nomeArquivo, my_perl);
	conversas.push_back(conversaTeste);

	cout << "Nomes e gênero dos interlocutores após análise:\n" << endl;
	cout << "\tInterlocutor 1: " << conversas.back()->getInterlocutor(0) << "\t\tGênero: " << conversas.back()->getGenero(0) << endl;
	cout << "\tInterlocutor 2: " << conversas.back()->getInterlocutor(1) << "\t\tGênero: " << conversas.back()->getGenero(1) << endl;
}

int Registro::pegaNumeroConversa() {

	int numeroConversa;

	exibirListaConversas();

	cout << "Digite o número da conversa: "<< endl;
	cout << "(entre com '0' para cancelar (sem aspas)\n" << endl;
	
	cin >> numeroConversa;

	return (numeroConversa - 1);
}

void Registro::excluir () {
	
	int numeroConversa = pegaNumeroConversa();
	
	try {

		if (numeroConversa != 0)
			conversas.erase(conversas.begin() + numeroConversa);

		cout << "Conversa apagada com sucesso." << endl;
	}
	catch (out_of_range &oor) {
		
		cout << "Erro: conversa não existente." << endl;
		return;
	}
}

void Registro::exibirListaConversas () {

	for (int i = 0; i < conversas.size(); i++) {

		cout << i + 1 << " : " << conversas.at(i)->getArquivo() << endl;
		cout << "\tInterlocutores: " << conversas.at(i)->getInterlocutor(0) << " e " << conversas.at(i)->getInterlocutor(1) << endl << endl;
	}
}

void Registro::exibirAnalise() {
	
	int numeroConversa = pegaNumeroConversa();
	conversas.at(numeroConversa)->analisarConversa();
}

void Registro::gerarRelatorio() {
	
	int numeroConversa = pegaNumeroConversa();

	Conversa convArq = *(conversas.at(numeroConversa));

	string nome = "Relatorio-" + convArq.getInterlocutor(0) + "-" + convArq.getInterlocutor(1);
	
	ofstream novoArquivo;
	novoArquivo.open(nome.c_str());

	novoArquivo << "* Linguagens de Programação" << endl;
	novoArquivo << "* Professor Miguel Campista" << endl;
	novoArquivo << "* Trabalho 3: Integração com Módulo do Perl" << endl;
	novoArquivo << "* Autores: Lucas Carvalho e Marcelo Soares\n" << endl;

	for (int i = 0; i < 2; i++) {

		novoArquivo << "Interlocutor " << (i + 1) << ": " << convArq.getInterlocutor(i) << endl;
		novoArquivo << "Quantidade vezes que iniciou conversa:" << convArq.getQtdVezesIniciouConversa(i) << endl;
		novoArquivo << "Quantidade de mensagens; " << convArq.getQtdMsg(i) << endl;
		novoArquivo << "Quantidade de palavras:" << convArq.getQtdPalavras(i) << endl;
		novoArquivo << "Quantidade de emoticos de texto:" << convArq.getQtdEmoticonsTexto(i) << endl;
		novoArquivo << "Quantidade de emoticons Emoji:" <<  convArq.getQtdEmoticonsEmoji(i) << endl;
		novoArquivo << "Quantidade de mensagens por bloco: " << (convArq.getQtdMsg(i)/convArq.getQtdBlocosMsg(i)) << endl << endl;
	}

	novoArquivo << "=========== Resultado ===========\n" << endl;
	novoArquivo << "O interlocutor 1 eh: " << convArq.getGenero(0) << endl;
	novoArquivo << "O interlocutor 2 eh: " << convArq.getGenero(1) << endl;
			
	novoArquivo.close();
}

void Registro::exibirMenu() {

	cout << "\nEscolha o que deseja fazer:" << endl;
	cout << "\n\t1: Inserir nova conversa" << endl;
	cout << "\t2: Exibir a lista de conversas" << endl;
	cout << "\t3: Exibir análise de uma conversa" << endl;
	cout << "\t4: Gerar relatório de uma conversa" << endl;
	cout << "\t5: Excluir uma conversa" << endl;
	cout << "\n\t9: Exibir esta tela de ajuda" << endl;
	cout << "\t0: Sair do programa" << endl;
}
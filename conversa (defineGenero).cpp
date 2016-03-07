#include <string>
#include <iostream>
#include <stdlib.h>
#include <vector>
#include "conversa.h"

Conversa::Conversa (){
	inserir(); 

}

// Compara em ordem de disparidade encontrada
void Conversa::defineGenero(interlocutor1, interlocutor2) {

	// Foi dada uma pontuação por cada critério, que um ou outro interlocutor ganha por ser maior, a ser:
	// qtdMsg vale 5
	// qtdEmojis vale 5
	// qtdVezesIniciouConversa vale 3
	// qtdEmoticonsTexto vale 1
	// qtd
	// A maior pontuação indica o interlocutor de sexo feminino.



	// As maiores disparidades de gênero ocorreram com quantidade de mensagens e de emojis enviados (feminino > masculino)
	if ((qtdMsg[0] > qtdMsg[1]) && (qtdEmoticonsEmoji[0] > qtdEmoticonsEmoji[1])) {
		
		interlocutora = interlocutor1;
		interlocutor = interlocutor2;
	}


	if (qtdVezesIniciouConversa[0] > qtdVezesIniciouConversa[1])




		int qtdVezesIniciouConversa[2];
		int qtdMsg[2];
		int qtdPalavras[2];
		int qtdEmoticonsTexto[2];
		int qtdEmoticonsEmoji[2];
		int qtdBlocosMsg[2];


}


void Conversa::analisarConversa() {

	cout<<"Numero de mensagens: "<< endl;

}

string Conversa::getInterlocutor () {return interlocutor;}

string Conversa::getInterlocutora () {return interlocutora;}

int Conversa::getQtdPalavras () {return qtdPalavras[1];}

int Registro::qtd(){return conversas.at(0)->getQtdPalavras();}

void Registro::inserirRegistro () {
	string sn;
	
	conversas.push_back (new Conversa);
	cout<<"qtdpalavras: "<<conversas.at(0)->getQtdPalavras()<<endl;
	cout<<"Deseja gerar um relatorio?\n S-sim	N-nao"<<endl;
	cin>> sn;
	if(sn=="sim" || sn=="Sim")
		gerarRelatorio(1);
}

void Registro::excluir () {
	int numeroConversa;

	cout << "Digite o numero da conversa a ser excluida\n"<< endl;
	exibirConversas();
	cin >> numeroConversa;
	if(numeroConversa!=-1)
		conversas.erase(conversas.begin() + numeroConversa -1);

}

void Registro::exibirConversas () {

	for (int i=0; i < conversas.size(); i++){
		cout << i +1<< " : " << conversas.at(i)->getInterlocutor() << " e " << conversas.at(i)->getInterlocutora() << "\n" << endl;
	}
	cout<< "-1 : cancelar"<< endl;
}

void Registro::exibirAnalise() {
	int numeroConversa;

	cout << "Digite o numero da conversa a ser analisada\n"<< endl;
	exibirConversas();
	cin >> numeroConversa;
	conversas.at(numeroConversa-1)->analisarConversa();
}

void Registro::gerarRelatorio(int op) {
	int numeroConversa;
	
	if (op==0){
		cout << "Digite o numero da conversa\n"<< endl;
		exibirConversas();
		cin >> numeroConversa;
	}


}

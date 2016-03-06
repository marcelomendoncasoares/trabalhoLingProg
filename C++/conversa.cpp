#include <string>
#include <iostream>
#include <stdlib.h>
#include <vector>
#include "conversa.h"


Conversa::Conversa (){
	inserir(); 
}

void Conversa::inserir (){
	string nomeArquivo;
	cout << "Insira o nome do arquivo da conversa: " << endl;
	cin >> nomeArquivo;

	cout << "Insira o nome do interlocutor: " << endl;
	cin >> interlocutor;

	cout << "Insira o nome da interlocutora: " << endl;
	cin >> interlocutora;
}


void Conversa::analisarConversa() {

	cout<<"Numero de mensagens: "<< endl;

}

string Conversa::getInterlocutor () {return interlocutor;}

string Conversa::getInterlocutora () {return interlocutora;}


void Registro::inserirRegistro () {
	string sn;
	
	conversas.push_back (new Conversa);
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

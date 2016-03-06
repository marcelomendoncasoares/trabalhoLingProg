#include <string>
#include <iostream>
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

string Conversa::getInterlocutor () {return interlocutor;}

string Conversa::getInterlocutora () {return interlocutora;}


void Registro::inserirRegistro () {

	conversas.push_back (new Conversa);
	cout<<"tam1:"<<conversas.size()<<endl;

}

void Registro::excluir () {
	int numeroConversa;
		cout<<"tam2:"<<conversas.size()<<endl;

	cout << "Digite o numero da conversa a ser excluida\n"<< endl;
	exibirConversas();
	cin >> numeroConversa;
	conversas.erase(conversas.begin() + numeroConversa);

}

void Registro::exibirConversas () {
	cout<<conversas.at(0)->getInterlocutor();	
	for (int i=0; i < conversas.size(); i++){
		cout<<"oi"<<endl;
		cout << i << " - " << conversas.at(i)->getInterlocutor() << "e" << conversas.at(i)->getInterlocutora() << "\n" << endl;
	}

}
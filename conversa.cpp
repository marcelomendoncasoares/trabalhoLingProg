#include <string>
#include <iostream>
#include <stdlib.h>
#include <vector>
#include "conversa.h"



Conversa::Conversa (string a) : arquivo(a) {};

void Conversa::inserir (){
	string nomeArquivo;
	cout << "Insira o nome do arquivo da conversa: " << endl;
	cin >> arquivo;
}


void Conversa::analisarConversa() {

	cout<<"Numero de mensagens: "<< endl;

}

string Conversa::getInterlocutor () {return interlocutor;}

string Conversa::getInterlocutora () {return interlocutora;}

int Conversa::getQtdPalavras () {return qtdPalavras[1];}

int Registro::qtd(){return conversas.at(0)->getQtdPalavras();}

void Registro::inserirRegistro () {
	
	string sn, nomeArquivo;
	cout << "Insira o nome do arquivo da conversa: " << endl;
	cin >> nomeArquivo;
	
	Conversa *conversaTeste = new Conversa(nomeArquivo);

	conversas.push_back (conversaTeste);
	teste(nomeArquivo, conversaTeste);

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

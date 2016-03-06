#include <iostream>
#include <string>
#include <vector>
#include "conversa.h"
using namespace std;

int main () {

int opcao;

	do
	{
			
		Registro registro;
		string name, profissao, nomeArquivo;
		

		cout << "Programa de analise de chat\n\n\nSelecione uma das opcoes abaixo\n\n1: inserir conversa 	2: excluir conversa	3: analisar" << endl;
		cin >> opcao;

	

		if(opcao== 1)
			{
			registro.inserirRegistro();
			registro.inserirRegistro();
			registro.inserirRegistro();	
		}
		
			
	
		if(opcao== 2){
			registro.excluir();
			
		}


	} while(opcao!=0);


	return 0;
}
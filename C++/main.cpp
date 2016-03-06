#include <iostream>
#include <string>
#include <vector>
#include "conversa.h"
using namespace std;

int main () {

int opcao;

	Registro registro;
	do
	{
			

		string name, profissao, nomeArquivo;
		
		cout << "Programa de analise de chat\n\nSelecione uma das opcoes abaixo\n"<<endl;
		cout<<"1: inserir conversa 	2: excluir conversa	 3: exibir analise  4: gerar relatorio " << endl;
		cin >> opcao;

		switch(opcao){

			case 1:
			registro.inserirRegistro();
			break;

			case 2:
			registro.excluir();
			break;

			case 3:
			registro.exibirAnalise();
			break;

			case 4:
			registro.gerarRelatorio(0);
			break;
		}




	} while(opcao!=0);


	return 0;
}
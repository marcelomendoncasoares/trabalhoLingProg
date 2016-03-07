#include <iostream>
#include <string>
#include <vector>
#include "conversa.h"
#include <EXTERN.h>
#include <perl.h>

using namespace std;

static PerlInterpreter *my_perl;

EXTERN_C void xs_init (pTHX);

EXTERN_C void boot_DynaLoader (pTHX_ CV* cv);

EXTERN_C void xs_init(pTHX)
{
	const char *file = __FILE__;
	dXSUB_SYS;

	/* DynaLoader is a special case */
	newXS("DynaLoader::boot_DynaLoader", boot_DynaLoader, file);
}

/*static void teste(string nomeArquivo) {

	dSP;																	// Inicializa o ponteiro da pilha
	ENTER;																	// Tudo criado à partir daqui...
	SAVETMPS;																// ...são variáveis temporárias
	PUSHMARK(SP);															// Lembra o ponteiro para a pilha
	XPUSHs(sv_2mortal(newSVpv(nomeArquivo.c_str(), nomeArquivo.length())));	// Coloca o nomeArquivo na pilha
	PUTBACK;																// Transforma o ponteiro local para a pilha em global
	int numberElemntsOfStack = perl_call_pv("analisaConversa", G_ARRAY);	// Chama a função em Perl
	SPAGAIN;																// Atualiza o ponteiro para a pilha

	// A partir daqui, os valores de retorno do código Perl são retirados da pilha para as váriáveis do código C++
	
	cout << "Existem " << numberElemntsOfStack << " elementos na pilha." << endl;

	string interlocutor1 = POPp;
	string interlocutor2 = POPp;
	
	// Os resultados são gravados no array segundo a seguinte ordem:
	// qtdVezesIniciouConversa, qtdMsg, qtdPalavras, qtdEmoticonsTexto, qtdEmoticonsEmoji, qtdBlocosMsg.
	//
	// Os resultados são gravados nesta ordem para um dos interlocutores primeiro, e depois para o outro.
	// Ou seja, os primeiros 6 são números do array são do interlocutor1, e os restantes são do interlocutor2.

	int resultArray[numberElemntsOfStack];
	for (numberElemntsOfStack -= 2; numberElemntsOfStack > 0; numberElemntsOfStack--) {
		resultArray[numberElemntsOfStack] = POPi;
		cout << "Resultado[" << numberElemntsOfStack << "] = " << resultArray[numberElemntsOfStack] << endl;
	}


	// Se for muito complicado colocar essa função dentro do construtor, pra facilitar, transforma ela em função membro da classe
	// conversa e chama ela dentro do construtor. Ou ainda tem a possibilidade de fazer dela uma função 'friend'. Digo isso porque
	// não sei se ela vai se comportar direito sem ser 'static void' (provavelmente vai sem problemas), e ela teria que retornar
	// muita coisa (duas strings e um array de 12 elementos, que foi declarado local).
	//
	// Pra isso, deixei pronto o trecho de código abaixo que pode substituir as quatro linhas de código acima de uma forma mais
	// organizada para ser utilizada na inicialização dos atributos do objeto 'Conversa'.
	// 
	// Minha sugestão é que o objeto 'Conversa' tenha o mesmo formato de atributos abaixo, com a adição das strings dos nomes dos
	// interlocutores colocadas acima, e com um um atributo adicional (array também) de gênero dos interlocutores, que deve ser
	// calculado com base nos indicadores daqui após inicialização destes atributos, em uma função à parte.

/*
	int qtdVezesIniciouConversa[2], qtdMsg[2], qtdPalavras[2], qtdEmoticonsTexto[2], qtdEmoticonsEmoji[2], qtdBlocosMsg[2];
	for (int index = 0; ((index < 2) && (numberElemntsOfStack > 0)); ++index) {

		qtdVezesIniciouConversa[index] = POPi;
		qtdMsg[index] = POPi;
		qtdPalavras[index] = POPi;
		qtdEmoticonsTexto[index] = POPi;
		qtdEmoticonsEmoji[index] = POPi;
		qtdBlocosMsg[index] = POPi;
		
	}
*/
/*
	PUTBACK;
	FREETMPS;		// Libera os valores de retorno da memória...
	LEAVE;			// ...e os argumentos "mortal XPUSHed"
}
*/



int main (int argc, char **argv, char **env) {

	// Inicialização
	char *my_argv[] = { (char *)"", (char *)"analisaConversa.pl" };
	PERL_SYS_INIT3(&argc, &argv, &env);

	// Criação de um interpretador
	my_perl = perl_alloc();
	perl_construct( my_perl );
	PL_exit_flags |= PERL_EXIT_DESTRUCT_END;

	// Invocação do código perl com argumentos
	perl_parse(my_perl, xs_init, 2, my_argv, (char **)NULL);
	perl_run(my_perl);

	
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
				nomeArquivo = "./conversas/conversaAilma.txt";
				teste(nomeArquivo);
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


	// Limpeza do programa
	perl_destruct(my_perl);
	perl_free(my_perl);

	// Término do programa
	PERL_SYS_TERM();

	cout << "Programa terminado com sucesso." << endl;

	return 0;
 }
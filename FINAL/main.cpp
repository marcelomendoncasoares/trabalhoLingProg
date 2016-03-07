/*
 *
 * Linguagens de Programação
 * Professor Miguel Campista
 *
 * Trabalho 3: Integração com Módulo do Perl
 * Autores: Lucas Carvalho e Marcelo Soares
 *
 * Este módulo é responsável por integrar o módulo perl e o módulo C++, chamando o processamento de um arquivo de texto:
 *
 */

#include <iostream>
#include <string>
#include <EXTERN.h>
#include <perl.h>
#include <vector>
#include "conversa.h"

using namespace std;

static PerlInterpreter *my_perl;

EXTERN_C void xs_init (pTHX);

EXTERN_C void boot_DynaLoader (pTHX_ CV* cv);

EXTERN_C void xs_init(pTHX) {

	const char *file = __FILE__;
	dXSUB_SYS;

	/* DynaLoader is a special case */
	newXS("DynaLoader::boot_DynaLoader", boot_DynaLoader, file);
}

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

// =========================  EXECUÇÃO DO CÓDIGO PRINCIPAL =========================
	
	int opcao;

	Registro registro;

	do {

		string name, profissao, nomeArquivo;
		
		cout << "Bem vindo ao programa de análise de chat." << endl;
		
		registro.exibirMenu();
		cin >> opcao;

		switch(opcao){

			case 1:
				registro.inserirRegistro(my_perl);
				break;

			case 2:
				registro.exibirListaConversas();
				break;

			case 3:
				registro.exibirAnalise();
				break;

			case 4:
				registro.gerarRelatorio();
				break;

			case 5:
				registro.excluir();
				break;

			case 9:
				registro.exibirMenu();
				break;
		}


	} while(opcao != 0);


// ======================  FIM DA EXECUÇÃO DO CÓDIGO PRINCIPAL =====================

	// Limpeza do programa
	perl_destruct(my_perl);
	perl_free(my_perl);

	// Término do programa
	PERL_SYS_TERM();
 }
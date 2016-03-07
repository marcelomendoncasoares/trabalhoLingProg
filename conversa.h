/*
 *
 * Linguagens de Programação
 * Professor Miguel Campista
 *
 * Trabalho 3: Classe Conversa (header)
 * Autores: Lucas Carvalho e Marcelo Soares
 *
 */


#include <string>
#include <vector>

using namespace std;

class Conversa {

	friend void teste(string);

	public:
		Conversa();
		void inserir();
		string getInterlocutora();
		string getInterlocutor();
		int getQtdPalavras();
		void analisarConversa();
		void defineGenero();

	private:
		string arquivo, interlocutor, interlocutora;
		int qtdVezesIniciouConversa[2];
		int qtdMsg[2];
		int qtdPalavras[2];
		int qtdEmoticonsTexto[2];
		int qtdEmoticonsEmoji[2];
		int qtdBlocosMsg[2];
};


class Registro {

	public:

		void inserirRegistro ();
		void excluir();
		void exibirConversas();
		void exibirAnalise();
		void gerarRelatorio( int );
		int qtd();

	private:

		vector < Conversa *> conversas;
};

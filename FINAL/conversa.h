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

	friend void teste(string, Conversa &);

	public:
		Conversa(string, PerlInterpreter *);
		string getArquivo();
		string getInterlocutor(int);
		string getGenero(int);
		int getQtdVezesIniciouConversa(int);
		int getQtdMsg(int);
		int getQtdPalavras(int);
		int getQtdEmoticonsTexto(int);
		int getQtdEmoticonsEmoji(int);
		int getQtdBlocosMsg(int);
		void analisarConversa();
		void defineGenero();

	private:
		string arquivo, interlocutor[2], genero[2];
		int qtdVezesIniciouConversa[2];
		int qtdMsg[2];
		int qtdPalavras[2];
		int qtdEmoticonsTexto[2];
		int qtdEmoticonsEmoji[2];
		int qtdBlocosMsg[2];
};


class Registro {

	public:
		Registro();
		void inserirRegistro (PerlInterpreter *);
		void exibirMenu();
		void excluir();
		void exibirListaConversas();
		void exibirAnalise();
		void gerarRelatorio();
		int pegaNumeroConversa();

	private:
		vector < Conversa *> conversas;
};

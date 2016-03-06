


#include <string>
#include <vector>

using namespace std;

class Conversa {

	public:
		Conversa();
		void inserir();
		string getInterlocutora ();
		string getInterlocutor ();

	private:
		string arquivo, interlocutor, interlocutora;

};


class Registro {

	public:


		void inserirRegistro ();
		void excluir();
		void exibirConversas();
	//	void analisarConversas();


	private:

		vector < Conversa *> conversas;
};
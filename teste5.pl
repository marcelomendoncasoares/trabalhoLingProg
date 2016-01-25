use warnings;
use Time::Local;

my $linha = "03/06/2015, 21:46 - Camilla Matias de Azevedo: Presidaa - o que acha : dessa zueira?";

# A adição do (.*) após o símbolo é para que seja capturado apenas o primeiro '-'
my ($dataMsgAtualTexto, $resto) = split(/[-](.*)/, $linha);
my ($interlocutorAtual, $msgAtual) = split(/[:](.*)/, $resto);

$interlocutorAtual =~ s/.//;
$msgAtual =~ s/.//;

print "\n", "Data: ", $dataMsgAtualTexto;
print "\n", "Resto: ", $resto;
print "\n", "Interlocutor: ", $interlocutorAtual;
print "\n", "Mensagem: ", $msgAtual, "\n";
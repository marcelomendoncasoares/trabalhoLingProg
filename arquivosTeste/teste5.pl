use warnings;

my $linha = "05/16/2015, 09:59 - Camilla Matias de Azevedo: Eu perdi 😊 hora de ir pro curso do IEG 😭😭😭 - com hífen e : dois pontos";

# A adição do (.*) após o símbolo é para que seja capturado apenas o primeiro '-'
my ($dataMsgAtualTexto, $resto) = split(/[-](.*)/, $linha);
my ($interlocutorAtual, $msgAtual) = split(/[:](.*)/, $resto);

$interlocutorAtual =~ s/.//;
$msgAtual =~ s/.//;

print "\n", $dataMsgAtualTexto, "\n";
print "\n", $resto, "\n";
print "\n", $interlocutorAtual, "\n";
print "\n", $msgAtual, "\n\n";
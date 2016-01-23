use warnings;
use Time::Local;

my $linha = "03/06/2015, 21:46 - Camilla Matias de Azevedo: Presidaa";

my ($dataMsgAtualTexto, $resto) = split(/[-]+/, $linha);
my ($interlocutorAtual, $msgAtual) = split(/[:]/, $resto);

# my $interlocutorAtual = substr($resto, 1, index($resto, ':') - 1);

# Remove o primeiro caracter (espaço) das strings
$interlocutorAtual =~ s/.//;
$msgAtual =~ s/.//;
print "\n", $resto, "\n", $interlocutorAtual, "\n", $msgAtual, "\n";


# Pega a data e hora da mensagem, separa cada pedaço da data e hora e os converte para 'timestamp'
my ($mday, $mon, $year, $hour, $min) = split(/[\s\/,:]+/, $dataMsgAtualTexto);
$dataMsgAtual = timelocal(0, $min, $hour, $mday, $mon-1, $year);
print "\n",scalar localtime $dataMsgAtual, "\n";

print $interlocutorAtual, "\n";
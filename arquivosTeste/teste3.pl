use warnings;
use 5.010;
use Time::Piece;


my $linha1 = "03/06/2015, 21:46 - Camilla Matias de Azevedo: Presidaa";
my $linha2 = "03/06/2015, 21:48 - Camilla Matias de Azevedo: Tenho uma dúvida sobre o talentos em ação";

my $format = '%d/%m/%Y, %H:%M ';

my ($dataMsgAnterior, $resto) = split(/[-]+/, $linha1);
my ($dataMsgAtual, $resto2) = split(/[-]+/, $linha2);

my $diff = Time::Piece->strptime($dataMsgAtual, $format) - Time::Piece->strptime($dataMsgAnterior, $format);

say Time::Piece->strptime($dataMsgAtual, $format);
say Time::Piece->strptime($dataMsgAnterior, $format);

print ("Diferença em horas é ", $diff/3600, "\n");


my ($interlocutorAtual, $msgAtual) = split(/[:]/, $resto2);
$msgAtual =~ s/.//;
@contador = split(/[\s]+/, $msgAtual);

print ($msgAtual, "\n");
print (@contador, "\n");
print (scalar(@contador), "\n");
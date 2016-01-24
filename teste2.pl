use warnings;
use Time::Local;

my $linha = "03/06/2015, 21:46 - Camilla Matias de Azevedo: Presidaa";
my ($dataMsgAtualTexto, $resto) = split(/[-]+/, $linha);

my ($mday, $mon, $year, $hour, $min) = split(/[\s\/,:]+/, $dataMsgAtualTexto);
$dataMsgAtual = timelocal(0, $min, $hour, $mday, $mon-1, $year);

$diferenca = $dataMsgAtual - timelocal(0, 0, 23, 1, 0, 0);

print $dataMsgAtual, "\n";
print (timelocal(0, 0, 23, 1, 0, 0), "\n");
print ("Diferença em segundos: ", $diferenca, "\n");
print (scalar localtime($diferenca), "\n");

($sec2, $min2, $hour2, $mday2) = localtime($dataMsgAtual - timelocal(0, 21, 22, $mday, $mon-1, $year));
print (scalar localtime($dataMsgAtual - timelocal(0, 21, 22, $mday, $mon-1, $year)), "\n");
print ("Diferença de hora apenas é ", (24*$mday2 + $hour2 + $min2/60), "\n");
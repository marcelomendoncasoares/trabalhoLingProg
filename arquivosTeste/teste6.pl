use warnings;

my $linha = "05/16/2015, 09:59 - Camilla Matias de Azevedo: Eu perdi 😊 hora de ir pro curso do IEG 😭😭😭 - com hífen e á à é ó ü : dois pontos";

# A adição do (.*) após o símbolo é para que seja capturado apenas o primeiro '-'
my ($dataMsgAtualTexto, $resto) = split(/[-](.*)/, $linha);
my ($interlocutorAtual, $msgAtual) = split(/[:](.*)/, $resto);

$interlocutorAtual =~ s/.//;
$msgAtual =~ s/.//;

# Muda caracteres como a '/', usado como exemplo funcional
# $linha =~ s/[^\w$msgAtual\x{0080}-\x{FFFF}]+/ ? /gu;

$msgAtual =~ s/[^\s\x{0080}-\x{FFFF}]+//gu;

my @arrayPalavras = split(/[\s]+/, $msgAtual);
##print scalar(@arrayPalavras), "\n";

print "\n";

for ($i = 0; $i < scalar(@arrayPalavras); $i++) {
	print $arrayPalavras[$i], "\n";
}

print "\n";
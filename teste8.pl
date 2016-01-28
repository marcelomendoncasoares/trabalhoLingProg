use warnings;
use POSIX; # Para usar a função 'ceil'

my $linha = "05/16/2015, 09:59 - Camilla Matias de Azevedo: ã 😵      😱 õ Á  À Í @ # 😁 ! ° / ? \\ - _ Ó É Ú Õ Ã ç ~ ^ Ç Eu perdi ª § º😊 hora de ir pro curso do IEG 😭😭😭 - \$ \% \* \& \@ \! com hífen e á à é ó óóóó ü : dois pontos";

# A adição do (.*) após o símbolo é para que seja capturado apenas o primeiro '-'
my ($dataMsgAtualTexto, $resto) = split(/[-](.*)/, $linha);
my ($interlocutorAtual, $msgAtual) = split(/[:](.*)/, $resto);

$interlocutorAtual =~ s/.//;
$msgAtual =~ s/.//;

#Remove todo caracter que não é emoticon
$msgAtual =~ s/[^\s\x{0080}-\x{00FF}]+//g;

@arrayOfCharacteresToRemove = ('à', 'á', 'é', 'í', 'ó', 'ú', 'ã', 'õ', 'ü', 'À', 'Á' , 'É', 'Í', 'Ó', 'Ú', 'Ã', 'Õ', 'Ü', 'ç', 'Ç', 'ª', 'º', '°', '§');
foreach (@arrayOfCharacteresToRemove) {
	$msgAtual =~ s/$_//g;
}

my @arrayPalavras = split(/[\s]+/, $msgAtual);

# A contagem deve ser manual para identificar emoticons colados um a um, e não como palavras.
# Cada emoticon normal, do tipo 😵, tem 4 bits, mas os emoticons do tipo  tem apenas 3 bits (vamos ignorar isso)
$contador = 0;
foreach(@arrayPalavras) {
	if ($_ ne "") {
		$contador += length($_)/4;
	}
}

#Arredonda para cima o contador, que fará com que a gente só tenha erro na contagem de emoticons de 1 pra cada 4 emoticons de 3 bits, que ainda são menos comuns
$contador = ceil($contador);

print ("\nQuantidade de emoticons = ", $contador, "\n");

for ($i = 0; $i < scalar(@arrayPalavras); $i++) {
	print $arrayPalavras[$i], "\n";
}

print "\n";
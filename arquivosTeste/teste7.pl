use warnings;

my $linha = "05/16/2015, 09:59 - Camilla Matias de Azevedo: ã 😵      😱 õ Á  À Í @ # 😁 ! ° / ? \\ - _ Ó É Ú Õ Ã ç ~ ^ Ç Eu perdi ª § º😊 hora de ir pro curso do IEG 😭😭😭 - \$ \% \* \& \@ \! com hífen e á à é ó óóóó ü : dois pontos";

# A adição do (.*) após o símbolo é para que seja capturado apenas o primeiro '-'
my ($dataMsgAtualTexto, $resto) = split(/[-](.*)/, $linha);
my ($interlocutorAtual, $msgAtual) = split(/[:](.*)/, $resto);

$interlocutorAtual =~ s/.//;
$msgAtual =~ s/.//;

# Regex use (http://www.comp.leeds.ac.uk/Perl/sandtr.html)

# Range de caracteres (http://www.fileformat.info/info/unicode/block/index.htm)
#
# - Latim: 0080 - 00FF (incluindo caracteres com acento) [http://www.fileformat.info/info/unicode/block/latin_supplement/list.htm]
# - Miscellaneous Symbols and Pictographs: 1F300 - 1F5FF [http://www.fileformat.info/info/unicode/block/miscellaneous_symbols_and_pictographs/index.htm]
# - Emoticons: 1F600 - 1F64F [http://www.fileformat.info/info/unicode/block/emoticons/index.htm]

# Consegue remover todos os caracteres de texto, deixando os emoticons, mas ainda deixando os caracteres com acento
# A expressão abaixo é quase como $msgAtual =~ s/[\w]+//g, exceto que também tira ':' e '-' 
$msgAtual =~ s/[^\s\x{0080}-\x{00FF}]+//g;
#$msgAtual =~ s/[\x{0080}-\x{008A}]+//;

@arrayOfCharacteresToRemove = ('à', 'á', 'é', 'í', 'ó', 'ú', 'ã', 'õ', 'ü', 'À', 'Á' , 'É', 'Í', 'Ó', 'Ú', 'Ã', 'Õ', 'Ü', 'ç', 'Ç', 'ª', 'º', '°', '§');

foreach (@arrayOfCharacteresToRemove) {
	$msgAtual =~ s/$_//g;
}


my @arrayPalavras = split(/[\s]+/, $msgAtual);
##print scalar(@arrayPalavras), "\n";

$contador = 0;
foreach(@arrayPalavras) {
	if ($_ ne "") {
		$contador += length($_)/4;
	}
}

print ("\nQuantidade de emoticons = ", $contador, "\n");

for ($i = 0; $i < scalar(@arrayPalavras); $i++) {
	print $arrayPalavras[$i], "\n";
}

print "\n";
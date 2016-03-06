#
# Linguagens de Programação
# Professor Miguel Campista
#
# Trabalho 3: Makefile
# Autores: Lucas Carvalho e Marcelo Soares
#
# $Author: marcelo.mendonca $
# $Date: 2013/07/10 15:46:00 $
# $Log: Makefile,v $
# 
#

CC = $(shell perl -V::cc:)
LD = $(shell perl -V::ld:)

CCFLAGS = $(shell perl -MExtUtils::Embed -e ccopts)
LDFLAGS = $(shell perl -MExtUtils::Embed -e ldopts)

PERLOBJS = perlIntegrer

PROGRAMM_NAME = programm

all: $(PERLOBJS)

$(PERLOBJS): 
	g++ -O2 -I/usr/local/include -I/usr/lib/perl/5.14/CORE -L/usr/lib/perl/5.14/CORE -o $(PROGRAMM_NAME) $(PERLOBJS).cpp -lperl -lm

#$(PERLOBJS).o: $(PERLOBJS).cpp
#	$(CC) $(CCFLAGS) -o $@ -c $<

#$(PERLOBJS): $(PERLOBJS).o
#	$(LD) -o $@ $? $(LDLAGS)

clean:
	rm -f $(PROGRAMM_NAME)

# $RCSfile: Makefile,v $

# Linha de comando que compila: g++ -O2 -I/usr/local/include -I/usr/lib/perl/5.14/CORE -L/usr/lib/perl/5.14/CORE -o programm perlIntegrer.cpp -lperl -lm
# Linha de comando usada para gerar o código de carregamento dinâmico: perl -MExtUtils::Embed -e xsinit -- -o perlxsi.c
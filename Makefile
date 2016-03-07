#
# Linguagens de Programação
# Professor Miguel Campista
#
# Trabalho 3: Makefile
# Autores: Lucas Carvalho e Marcelo Soares
#

CC = g++
LD = g++

CCFLAGS = $(shell perl -MExtUtils::Embed -e ccopts)
LDFLAGS = $(shell perl -MExtUtils::Embed -e ldopts)

PROGRAMM_NAME = programm

PERLOBJS = perlIntegrer


all:
	$(CC) -O2 $(CCFLAGS) -o $(PROGRAMM_NAME) $(PERLOBJS).cpp -lperl -lm

clean:
	rm -f $(PROGRAMM_NAME)

# $RCSfile: Makefile,v $
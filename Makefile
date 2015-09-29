LIBNAME = easing
LUADIR = /usr/local/include

COPT = -O2
# COPT = -DLPEG_DEBUG -g

CWARNS = -Wall -Wextra -pedantic \
	-Waggregate-return \
	-Wcast-align \
	-Wcast-qual \
	-Wdisabled-optimization \
	-Wpointer-arith \
	-Wshadow \
	-Wsign-compare \
	-Wundef \
	-Wwrite-strings \
	-Wbad-function-cast \
	-Wdeclaration-after-statement \
	-Wmissing-prototypes \
	-Wnested-externs \
	-Wstrict-prototypes \
# -Wunreachable-code \


CFLAGS = $(CWARNS) $(COPT) -std=c99 -I$(LUADIR) -fPIC
CC = gcc

FILES = easing.o leasing.o

# For Linux
linux:
	make easing.so "DLLFLAGS = -shared -fPIC"

# For Mac OS
macosx:
	make easing.so "DLLFLAGS = -bundle -undefined dynamic_lookup"

easing.so: $(FILES)
	env $(CC) $(DLLFLAGS) $(FILES) -o easing.so

$(FILES): makefile

clean:
	rm -f $(FILES) easing.so

easing.o: easing.h easing.c
leasing.o: easing.h easing.c leasing.c

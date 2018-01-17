include ../../include.mk

CC=gcc
SIMDFLAG=-msse4
CFLAGS=-Wall -Werror -O2 -g3 -I ../include -fPIC $(SIMDFLAG)
LD=$(CC)
LIBPATH=../../lib/

CFILES=$(wildcard *.c)
HFILES=$(wildcard *.h)
OFILES=$(patsubst %.c,%.o,$(CFILES))

.PHONY: all install clean prebuild

TARGET=libmul.so

all: prebuild $(TARGET) install

prebuild:
	mkdir -p ${LIBPATH}

%.o: %.c $(HFILES)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OFILES)
	$(CC) -shared -o $@ $^

install:
	mv ${TARGET} ${LIBPATH}

clean:
	rm -f ${LIBPATH}$(TARGET) 2>/dev/null
	rm -f  *.o 2>/dev/null

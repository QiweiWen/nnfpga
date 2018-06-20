CC=gcc
SIMDFLAG=-msse4
CFLAGS=-Wall -Werror -O2 -g3 -I ../include -fPIC $(SIMDFLAG)
LD=$(CC)

CFILES=$(wildcard *.c)
HFILES=$(wildcard *.h)
OFILES=$(patsubst %.c,%.o,$(CFILES))

.PHONY: all clean prebuild

TARGET=../libmul.so

all: $(TARGET)

%.o: %.c $(HFILES)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OFILES)
	$(CC) -shared -o $@ $^

clean:
	rm -f $(TARGET) 2>/dev/null
	rm -f  *.o 2>/dev/null

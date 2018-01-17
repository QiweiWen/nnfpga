.PHONY: all, clean

all:
	./configure.sh
	cd c && ./make.sh all

clean:
	cd c && ./make.sh clean

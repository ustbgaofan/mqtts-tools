CC=gcc
PACKAGE=mqtts-tools
VERSION=0.0.2
CFLAGS=-g -Wall -DVERSION=$(VERSION)
LDFLAGS=
TARGETS=mqtts-pub mqtts-sub


all: $(TARGETS)

mqtts-pub: mqtts.o mqtts-pub.o
	$(CC) $(LDFLAGS) -o mqtts-pub $^
  
mqtts-pub.o: mqtts-pub.c mqtts.h
	$(CC) $(CFLAGS) -c mqtts-pub.c

mqtts-sub: mqtts.o mqtts-sub.o
	$(CC) $(LDFLAGS) -o mqtts-sub $^
  
mqtts-sub.o: mqtts-sub.c mqtts.h
	$(CC) $(CFLAGS) -c mqtts-sub.c

mqtts.o: mqtts.c mqtts.h
	$(CC) $(CFLAGS) -c mqtts.c

clean:
	rm -f *.o $(TARGETS)

dist:
	distdir='$(PACKAGE)-$(VERSION)'; mkdir $$distdir || exit 1; \
	list=`git ls-files`; for file in $$list; do \
		cp -pR $$file $$distdir || exit 1; \
	done; \
	tar -zcf $$distdir.tar.gz $$distdir; \
	rm -fr $$distdir

.PHONY: all clean dist

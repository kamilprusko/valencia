PLUGIN = valencia
VERSION = 0.1.0

SOURCES = parser.vala program.vala scanner.vala valencia.vala util.vala
LIBS = --pkg gee-1.0 --pkg gedit-2.20 --pkg vte

DIST_FILES = $(SOURCES) \
             Makefile \
             gedit-2.20.deps gedit-2.20.vapi valencia.gedit-plugin \
             AUTHORS COPYING INSTALL NEWS README
DIST_TAR = $(PLUGIN)-$(VERSION).tar
DIST_TAR_BZ2 = $(DIST_TAR).bz2

libvalencia.so: $(SOURCES)
	pkg-config --exists gedit-2.20
	valac -X --shared -X -fPIC --vapidir=. $(LIBS) $^ -o $@

install:
	mkdir -p ~/.gnome2/gedit/plugins
	cp libvalencia.so valencia.gedit-plugin ~/.gnome2/gedit/plugins

parser: parser.vala program.vala scanner.vala
	valac --pkg gee-1.0 $^ -o $@

$(DIST_TAR_BZ2): $(DIST_FILES)
	tar -cv $(DIST_FILES) > $(DIST_TAR)
	bzip2 $(DIST_TAR)

dist: $(DIST_TAR_BZ2)

clean:
	rm -f $(SOURCES:.vala=.c) $(SOURCES:.vala=.h) *.so


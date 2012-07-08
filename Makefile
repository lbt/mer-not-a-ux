DATADIR=/usr/share/mer-not-a-ux
BINDIR=/usr/bin

default:
	@echo No make required

.PHONY : install
install:
	@mkdir -p $(DESTDIR)$(DATADIR)/qml
	@cp src/*.qml $(DESTDIR)$(DATADIR)/qml/
	@cp src/wallpaper.jpg $(DESTDIR)$(DATADIR)/qml/
	@install -m 755 src/minimer $(DESTDIR)$(BINDIR)/


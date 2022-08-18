DEST=_site

build:
	yarn tstl
	mkdir -p $(DEST)
	mv -f *.lua $(DEST)

dev:
	yarn tstl --watch

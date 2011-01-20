JS=lib/qwerly.js

all: $(JS)

clean:
	-rm -f $(JS)

%.js: %.coffee
	coffee -b -c $<

.PHONY: clean

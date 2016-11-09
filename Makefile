.PHONY: compile clean major minor patch

prefix ?= /usr/local
lispdir?= $(prefix)/share/emacs/site-lisp/company-emoji

emacs   ?= $(shell which emacs)
company ?= /usr/local/share/emacs/site-lisp/company

BASE_FILE = company-emoji.el
LISPS = $(BASE_FILE) company-emoji-list.el

default: compile

compile: $(LISPS)
	$(emacs) --batch -Q --directory $(company) -f batch-byte-compile $<

install: compile
	mkdir -p $(lispdir)
	install -m 644 $(LISPS) *.elc $(lispdir)

clean:
	rm *.elc

build/generate-list.rb:

company-emoji-list.el: build/generate-list.rb
	rm company-emoji-list.el || true
	ruby build/generate-list.rb > company-emoji-list.el

temp ?= $(uuid)

major:
	VERSION_SHIFT=major build/version.awk $(BASE_FILE) > $(temp).el
	rm $(BASE_FILE)
	mv $(temp).el $(BASE_FILE)

minor:
	VERSION_SHIFT=minor build/version.awk $(BASE_FILE) > $(temp).el
	rm $(BASE_FILE)
	mv $(temp).el $(BASE_FILE)

patch:
	VERSION_SHIFT=patch build/version.awk $(BASE_FILE) > $(temp).el
	rm $(BASE_FILE)
	mv $(temp).el $(BASE_FILE)

version=$(shell ack -o -m 1 "[0-9]+\.[0-9]+\.[0-9]+" $(BASE_FILE))
tag:
	git tag -a $(version) -m "v$(version)"

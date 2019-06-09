
ROOT        := ./debian

SHELL       := /bin/bash

ME          := cli-aptiX

BIN_DIR     := $(ROOT)/usr/local/bin
LOCALE_DIR  := $(ROOT)/usr/share/locale
MAN_DIR     := $(ROOT)/usr/share/man/man1
SHARE_DIR   := $(ROOT)/usr/local/share/$(ME)
DESKTOP_DIR := $(ROOT)/usr/share/applications/antix
CONF_DIR    := $(ROOT)/etc/apt/apt.conf.d/
ALL_DIRS    := $(BIN_DIR) $(LOCALE_DIR) $(MAN_DIR) $(SHARE_DIR) $(DESKTOP_DIR) $(CONF_DIR)

.PHONY: $(SCRIPTS) help all script man-page shared-files desktop-file locales apt-conf install clean

help:
	@echo "help            		show this usage"
	@echo "install         		install to ./debian"
	@echo "install ROOT=   	 	install to root directory"
	@echo "install ROOT=../xtra install to ../xtra directory"
	@echo "clean           		remove contents of debian/ directory"

install: script man-page shared-files desktop-file locales apt-conf

locales: | $(LOCALE_DIR)
	cp -r locale/* $(LOCALE_DIR)

script: $(ME) | $(BIN_DIR)
	cp $(ME) $(BIN_DIR)/

man-page: man/$(ME).1 | $(MAN_DIR)
	test -e $< && gzip -c $< > $(MAN_DIR)/$$(basename $<).gz || true

shared-files: | $(SHARE_DIR)
	cp -r share/* $(SHARE_DIR)/

desktop-file: | $(DESKTOP_DIR)
	cp desktop/*.desktop $(DESKTOP_DIR)

apt-conf: | $(CONF_DIR)
		cp apt.conf.d/* $(CONF_DIR)

clean:
	rm -rf ./debian/*
$(ALL_DIRS):
	test -d $(ROOT)/
	mkdir -p $@

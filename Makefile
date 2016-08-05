PROG    = zfs-space-check
PREFIX ?= /usr/local
BINDIR  = $(PREFIX)/bin
CONFDIR = $(PREFIX)/etc
DBDIR  ?= /var/db/zfs-space-check
OWNER   = nobody

.PHONY: all install uninstall

all:

install:
	install -d $(DESTDIR)$(BINDIR) $(DESTDIR)$(CONFDIR);
	install -d -o $(OWNER) -g $(OWNER) $(DESTDIR)$(DBDIR);
	install -m 0555 $(PROG) $(DESTDIR)$(BINDIR)/$(PROG);
	install -m 0644 $(PROG).conf.sample $(DESTDIR)$(CONFDIR)/$(PROG).conf.sample;

uninstall:
	-@rm $(DESTDIR)$(BINDIR)/$(PROG) \
		$(DESTDIR)$(CONFDIR)/$(PROG).conf.sample;
	@if [ -f $(DESTDIR)$(DBDIR)/notified.db ]; then \
		rm $(DESTDIR)$(DBDIR)/notified.db; \
	fi
	-@rmdir $(DESTDIR)$(DBDIR)

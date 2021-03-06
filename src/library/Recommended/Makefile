#
# ${R_HOME}/src/library/Recommended/Makefile


srcdir = .
top_srcdir = ../../..

top_builddir = ../../..
subdir = src/library/Recommended

include $(top_builddir)/Makeconf

distdir = $(top_builddir)/$(PACKAGE)-$(VERSION)/$(subdir)
DISTFILES = Makefile.in Makefile.win .cvsignore
# avoid user's startup files
R = R_LIBS= $(top_builddir)/bin/R --vanilla

## foo.ts is the timestamp for package foo;
## foo.tgz is a symlink to foo_x.y-z.tar.gz in the source dir.
## unfortunately package foo can be uninstalled and leave foo.ts

## For developers: A shell script, tools/rsync-recommended, updates
## packages from the CRAN master directory. 

OBJECTS = $(R_PKGS_RECOMMENDED:=.ts)

CLEANFILES = $(OBJECTS) Makedeps stamp-recommended
DISTCLEANFILES = Makefile

.SUFFIXES:
.SUFFIXES: .tgz .ts

all: Makefile R  recommended-packages

Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	@cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@

recommended-packages: Makefile
	@$(MAKE) stamp-recommended
stamp-recommended: $(OBJECTS)
	@touch $@

## need to allow parallel installs
INSTALL_OPTS = --pkglock --data-compress=xz
INSTALL_OPTS2 = --byte-compile

## On e.g. Solaris/FreeBSD if the top-level make is GNU make it will
## pass flags such as -j and -w down: so need to ensure that INSTALL
## uses the same make.
.tgz.ts:
	@$(ECHO) "begin installing recommended package" `basename $< .tgz`
	@rm -f $@.out
## Avoid user/site libraries, pass down MAKE
	@if test -n "$(R_NO_BASE_COMPILE)"; then \
	  MAKE="$(MAKE)" R_LIBS_USER= R_LIBS_SITE= \
	  _R_CHECK_INSTALL_DEPENDS_=no \
	  $(R) CMD INSTALL $(INSTALL_OPTS) --no-byte-compile -l "$(top_builddir)/library" $< > $@.out 2>&1 || (cat $@.out && exit 1); \
	else \
	  MAKE="$(MAKE)" R_LIBS_USER= R_LIBS_SITE= \
	  _R_CHECK_INSTALL_DEPENDS_=no \
	  $(R) CMD INSTALL $(INSTALL_OPTS) $(INSTALL_OPTS2) -l "$(top_builddir)/library" $< > $@.out 2>&1 || (cat $@.out && exit 1); \
	fi
	@cat $@.out; rm $@.out
	@touch $@

R docs:

install: installdirs
installdirs:
install-strip: install

uninstall:

install-tests:
	@(tmp=$${TMPDIR-/tmp}/R$$$$; mkdir "$${tmp}"; \
	 cd "$(top_srcdir)"; abs_top_srcdir=`pwd`; \
	 abs_MKINSTALLDIRS=`echo "$(MKINSTALLDIRS)" | sed "s:$(top_srcdir):$${abs_top_srcdir}:"` ; \
	 cd "$${tmp}"; \
	 for pkg in $(R_PKGS_RECOMMENDED); do \
	   gzip -dc "$(abs_top_srcdir)/src/library/Recommended/$${pkg}.tgz" | $(TAR) xf - ; \
	 done ; \
	 for pkg in $(R_PKGS_RECOMMENDED); do \
	  if test -d $${pkg}/tests; then \
	    $${abs_MKINSTALLDIRS} "$(DESTDIR)$(rhome)/library/$${pkg}/tests" ; \
	    cp -R $${pkg}/tests/* "$(DESTDIR)$(rhome)/library/$${pkg}/tests"; \
	  fi; \
	 done)

uninstall-tests:
	@for pkg in $(R_PKGS_RECOMMENDED); do \
	 rm -rf "$(DESTDIR)$(rhome)/library/$${pkg}/tests" ; \
	done


mostlyclean: clean
clean:
	-@test -z "$(CLEANFILES)" || rm -f $(CLEANFILES)
distclean: clean
	-@test -z "$(DISTCLEANFILES)" || rm -f $(DISTCLEANFILES)
maintainer-clean: distclean

## we need to check that the recommended packages have been downloaded.
distdir: $(DISTFILES)
	@if test `cd $(srcdir) && ls *.tar.gz | wc -l` -eq 0 ; then \
	  $(ECHO) "ERROR: no recommended packages" || exit 1 ; \
	fi
	@for f in $(DISTFILES) `cd $(srcdir) && ls *.tar.gz`; do \
	  test -f $(distdir)/$${f} \
	    || ln $(srcdir)/$${f} $(distdir)/$${f} 2>/dev/null \
	    || cp -p $(srcdir)/$${f} $(distdir)/$${f}; \
	done


## Hardcoded dependencies (see '../../../share/make/vars.mk')
Matrix.ts: lattice.ts
mgcv.ts: nlme.ts MASS.ts Matrix.ts
nlme.ts: lattice.ts
class.ts: MASS.ts
## and for static html links
boot.ts: MASS.ts survival.ts
cluster.ts: MASS.ts
## jea added for new Recommended packages that we vendor in.
RProtoBuf.ts: Rcpp.ts RCurl.ts
shiny.ts: httpuv.ts caTools.ts RJSONIO.ts xtable.ts digest.ts htmltools.ts testthat.ts knitr.ts markdown.ts rmarkdown.ts
RCurl.ts: bitops.ts
caTools.ts: bitops.ts
httpuv.ts: Rcpp.ts
bitops.ts: digest.ts
htmltools.ts: digest.ts
rmongodb.ts: plyr.ts jsonlite.ts
ff.ts: bit.ts
ffbase.ts: ff.ts fastmatch.ts
biglm.ts: DBI.ts
knitr.ts: evaluate.ts formatR.ts highr.ts markdown.ts stringr.ts
evaluate.ts: stringr.ts
markdown.ts: mime.ts
plyr.ts: Rcpp.ts
rmarkdown.ts: yaml.ts
devtools.ts:  httr.ts  memoise.ts  rstudioapi.ts  whisker.ts
ggplot2.ts: colorspace.ts dichromat.ts gtable.ts labeling.ts munsell.ts proto.ts RColorBrewer.ts reshape2.ts scales.ts
RJDBC.ts: rJava.ts
nanomsgardvark.ts: Rcpp.ts

nbuild:
	R CMD build nanomsgardvark && make && pushd ../../.. && make && make install && popd

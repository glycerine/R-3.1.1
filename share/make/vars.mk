## Static (i.e., not determined by configure) Make variables to be
## shared *and* grepped from m4/R.m4 and tools/*-recommended.

## There is also 'translations', but that is not Priority: base
## so it can be handled by update.packages() in due course.
R_PKGS_BASE = base tools utils grDevices graphics stats datasets methods grid splines stats4 tcltk compiler parallel
## Those which can be installed initially compiled (not base tools)
R_PKGS_BASE1 = utils grDevices graphics stats datasets methods grid splines stats4 tcltk parallel
## Those with standard R directories (not datasets, methods)
R_PKGS_BASE2 = base tools utils grDevices graphics stats grid splines stats4 tcltk compiler parallel

R_PKGS_RECOMMENDED =  MASS lattice Matrix nlme survival boot cluster codetools foreign KernSmooth rpart class nnet spatial mgcv Rserve bitops Rcpp RCurl RProtoBuf httpuv caTools RJSONIO xtable digest htmltools shiny rzmq plyr rmongodb jsonlite rredis bit ff ffbase biglm DBI RMySQL iterators knitr evaluate zoo mime testthat formatR markdown stringr highr fastmatch rmarkdown yaml devtools httr memoise  rstudioapi whisker colorspace dichromat ggplot2 gtable labeling munsell proto RColorBrewer reshape2 scales  rJava RJDBC RCassandra nanomsgardvark hash
# there are dependencies in src/library/Recommended/Makefile*
# which this order respects

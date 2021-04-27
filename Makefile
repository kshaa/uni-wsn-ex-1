# Sources are all project source files, excluding MansOS files
SOURCES = \
  src/main.c \
  src/lib.c \

# Module is the name of the main module buit by this makefile
APPMOD = PrintCounter

# Path to the root of the project
PROJDIR = $(CURDIR)

# Path to MansOS source code
ifndef MOSROOT
  MOSROOT = $(PROJDIR)/MansOS
  $(warning Warning - MOSROOT environment variable is not set, use nix develop to attain it automatically or define manually, currently assuming it's $(MOSROOT))
endif

# Include the main makefile
include ${MOSROOT}/mos/make/Makefile

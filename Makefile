CC     ?= cc
PREFIX ?= /usr/local

ifeq ($(OS),Windows_NT)
BINS    = user-create.exe
LDFLAGS = -L/usr/local/lib -lcurl
CP      = cp
RM      = rm -f
MKDIR_P = mkdir -p
else
BINS    = user-create
LDFLAGS = -lcurl
CP      = cp -f
RM      = rm -f
MKDIR_P = mkdir -p
endif

SRC  = $(wildcard src/*.c)
DEPS = $(wildcard deps/*/*.c)
OBJS = $(DEPS:.c=.o)

CFLAGS  = -std=c99 -Ideps -I/usr/local/include -Wall -Wno-unused-function -U__STRICT_ANSI__

all: $(BINS)

$(BINS): $(SRC) $(OBJS)
	$(CC) $(CFLAGS) -o $@ src/$(@:.exe=).c $(OBJS) $(LDFLAGS)

%.o: %.c
	$(CC) $< -c -o $@ $(CFLAGS)

clean:
	$(foreach c, $(BINS), $(RM) $(c);)
	$(RM) $(OBJS)

install: $(BINS)
	$(MKDIR_P) $(PREFIX)/bin
	$(foreach c, $(BINS), $(CP) $(c) $(PREFIX)/bin/$(c);)

uninstall:
	$(foreach c, $(BINS), $(RM) $(PREFIX)/bin/$(c);)

test:
	@./test.sh

.PHONY: test all clean install uninstall

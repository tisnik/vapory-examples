#
#  (C) Copyright 2018  Pavel Tisnovsky
#
#  All rights reserved. This program and the accompanying materials
#  are made available under the terms of the Eclipse Public License v1.0
#  which accompanies this distribution, and is available at
#  http://www.eclipse.org/legal/epl-v10.html
#
#  Contributors:
#      Pavel Tisnovsky
#

# seznam vsech zdrojovych v POV-Rayi
SOURCES := $(wildcard *.pov)

# seznam souboru, ktere se maji vygenerovat
GENERATED := $(patsubst %.pov,%.png,$(SOURCES))

all: ${GENERATED}

clean:
	rm *.png

%.png:	%.pov
	povray +W640 +H480 +B +FN +D +I$< +O$@

.PHONY: clean


# Minimal makefile for WDL documentation
#
# Put it first so that "make" without argument is like "make help".
#!/bin/bash

build-input:
	wdl-aid --strict -t template.md.j2 $(FILE) > src/develop/$(basename $(FILE))-inputs.md

build-all-inputs:
	for file in $(find .. -name '*.wdl'); do \
		wdl-aid --strict -t template.md.j2 $(file) > src/develop/$(basename $(file))-inputs.md;  \
	done

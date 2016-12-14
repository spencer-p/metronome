#!/bin/bash

VERSION="1.0"

CODE=(main.lua dial.lua conf.lua hump/vector.lua hump/class.lua)
ASSETS=(click.ogg)

BUILDPATH="build"

if [[ ! -d $BUILDPATH ]]; then
	mkdir $BUILDPATH
fi

zip $BUILDPATH/metronome-$VERSION.zip ${CODE[@]} ${ASSETS[@]}

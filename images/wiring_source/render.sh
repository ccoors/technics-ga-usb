#!/bin/sh
pdflatex wiring.tex
convert -density 400 -background white -alpha remove wiring.pdf ../wiring.png

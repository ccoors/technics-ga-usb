#!/bin/sh
pdflatex wiring.tex
convert -density 200 -background white -alpha remove wiring.pdf ../wiring.png

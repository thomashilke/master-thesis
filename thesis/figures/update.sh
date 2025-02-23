#!/bin/bash

rm *.pdf
rm *.tex
rm vector/*

find ../masterphysique/ -name "*.tex" -exec cp {} . \;;
find ../masterphysique/ -name "*.eps" -exec cp {} . \;;

#for file in *.eps; do
#    epstopdf $file;
#done

mv *.eps vector

for file in vector/*.eps; do
    convert -density 300 $file $(basename $file .eps).png
    echo "Converted $(basename $file) to png"
done

for file in *.png; do
    convert -compress jpeg $file $(basename $file .png).pdf
    echo "Converted $(basename $file) to pdf"
done

rm *.png


cd ..
./genfigurefile.sh > figures.tex
pdflatex figures.tex
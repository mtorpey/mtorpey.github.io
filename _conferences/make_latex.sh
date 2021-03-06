#!/bin/bash
if [ -e _out.tex ]
then
    rm _out.tex
fi

echo "% Generated by mtorpey.github.io/_conferences/make_latex.sh" >> _out.tex

files=$(grep --color=never date: *.md | sed 's/:date: //g' | sed 's/^\(.*\.md\)"\([-\/0-9 ]*\)"$/\2 \1/g' | sort -r | grep --color=never --only-matching -E "[^ ]*$")

for talk in $files
do
    echo "Processing $talk..."
    cat $talk | tail -n +2 | head -n -1 > _temp.yml
    echo "\\item" >> _out.tex
    echo "  $(cat _temp.yml | shyaml get-value date | ../_scripts/date.py)," >> _out.tex
    echo "  $(cat _temp.yml | shyaml get-value event)," >> _out.tex
    echo "  $(cat _temp.yml | shyaml get-value location)." >> _out.tex
    echo "" >> _out.tex
done
rm _temp.yml

echo "Output at _out.tex"

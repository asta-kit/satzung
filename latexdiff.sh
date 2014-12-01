#!/bin/bash
# Dieses Script macht ein Diff zwischen der Übergebenen Satzung in verschiedenen
# Versionen

help(){
	echo "Benutzung: $0 [<version-alt> [<version-neu>]] Ordnung"
	echo
	echo "Mache ein Diff für das angegebene Dokument."
	echo "Optional können ein oder zwei Versionen angegeben werden mit bzw."
	echo "zwischen denen verglichen wird. Standardmäßig wird mit HEAD verglichen."
}

case "$1" in
	-h|--help)
		help
		exit 0
		;;
esac

if [ $# -lt 1 ]
then
	echo "Fehler: Brauche mindestens ein Argument"
	echo
	help
	exit 1
fi

if [ $# -gt 3 ]
then
	echo "Fehler: Kann mit mehr als drei Argumenten nichts anfangen"
	echo
	help
	exit 1
fi

basedir="$(dirname "$0")"
ordnung="${!#%/}"

# Parse Versions-Strings
if [ $# -gt 1 -a "$1" ]
then
	alt="$1"
else
	alt="HEAD"
fi
versions=("-r" "$alt")

if [ $# -gt 2 -a \( "$1" -a "$2" \) ]
then
	neu="$2"
	versions+=("-r" "$neu")
fi

# Erzeuge ein Arbeitsverzeichnis in /tmp
tmpdir="$(mktemp -d --tmpdir "latexdiff.$ordnung.XXXXXXXXXX")"

# Kopiere das template ins Arbeitsverzeichnis
cp "$basedir/latexdiff_template.tex" "$tmpdir/$ordnung.diff.tex"

# Führe latexdiff-git aus
latexdiff-git --encoding=utf8 --packages=hyperref --exclude-safecmd='ref' --append-textcmd='stupadate,publishdate,jurchanges,jurparagraph,jursubparagraph,jursection' --dir="$tmpdir/" "${versions[@]}" "$basedir/$ordnung/document.core.tex"

# Wenn zwei Versionen verglichen werden hinterlässt latexdiff-git Müll
# => aufräumen
if [ "$neu" ]
then
	rm "$basedir/$ordnung/document.core-oldtmp-"*".tex"
fi

# Verschiebe das Diff und lösche Unterordner
mv "$tmpdir/$ordnung/document.core.tex" "$tmpdir/document.core.diff.tex"
rmdir "$tmpdir/$ordnung/"

# Baue das Diff-PDF
cd "$tmpdir"
rubber --pdf --warn misc "$tmpdir/$ordnung.diff.tex"

echo "Das Diff liegt in $tmpdir/"
xdg-open "$tmpdir/$ordnung.diff.pdf"

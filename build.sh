#!/bin/bash
# Dieses Script kompiliert ein Dokument

help(){
	echo "Benutzung: $0 [rubber-Optionen] Ordnung"
	echo "Kompiliere das angegebene Dokument."
	echo "Wenn man \"gesamt\" angibt wird die Gesamtfassung kompiliert."
	echo "Nimmt alle Optionen die rubber auch nimmt (z.B. --force, --warn all)."
}

case "$1" in
	-h|--help)
		help
		exit 0
		;;
esac

if [ $# -eq 0 ]
then
	echo "Fehler: Brauche mindestens ein Argument"
	echo
	help
	exit 1
fi

basedir="$(dirname "$0")"

ordnung="${!#%/}"

if [ "$ordnung" = "gesamt" ]
then
	dir="$basedir"
else
	dir="$basedir/$ordnung"
fi

cd "$dir"

args=("${@:1:$#-1}" "$ordnung.tex")
rubber --pdf "${args[@]}"

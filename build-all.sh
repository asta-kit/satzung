#!/bin/bash
# Dieses Script kompiliert alle Dokumente. Das kann praktisch sein wenn man 
# eines der Grundgerüste anpasst

case "$1" in
	-h|--help)
		echo "Kompiliere alle Dokumente"
		echo "Benutzung: $0 [rubber-Optionen]"
		echo "Nimmt alle Optionen die rubber auch nimmt (z.B. --force, --warn all)"
		exit 0
		;;
esac

basedir="$(dirname "$0")"

for direntry in "$basedir"/*
do
	if [ -d "$direntry" ]
	then
		args=("$@" "$direntry/$(basename "$direntry").tex")
		"$basedir/build.sh" "${args[@]}"
	fi
done

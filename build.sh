#!/bin/bash
# Dieses Script kompiliert ein Dokument

case "$1" in
	-h|--help)
		echo "Kompiliere das angegebene Dokument"
		echo "Benutzung: $0 [rubber-Optionen] Datei"
		echo "Nimmt alle Optionen die rubber auch nimmt (z.B. --force, --warn all)"
		exit 0
		;;
esac

cd "$(dirname "${!#}")"

args=("${@:1:$#-1}" "$(basename "${!#}")")
rubber --pdf "${args[@]}"

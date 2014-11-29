Organisationssatzung und ergänzende Ordnungen der Studierendenschaft am KIT
===========================================================================

Hier werden Satzungen und Ordnungen auf zentraler Ebene der Studierendenschaft am Karlsruher Institut für Technologie (KIT) gesammelt und Änderungen verfolgt.

http://www.asta-kit.de


Wie kompiliert man die Satzungen neu?
-------------------------------------
Dafür gibt es das build-all.sh-Skript. Unter Linux einfach ein Terminal starten, mit `cd <ordner>` in den Ordner wechseln wo diese Anleitung liegt und dann `./build-all.sh` ausführen.

Das Skript akzeptiert alle Parameter die rubber auch akzeptiert (siehe `man rubber`). Zum Beispiel `-W refs -W misc` um Warnungen zu nicht auflösbaren Referenzen und andere allgemeine Warnungen auszugeben oder `-W all` um alle Warnungen auszugeben.

Um nur eine einzelne Ordnung zu kompilieren kann man `./build.sh <ordnung>` ausführen.


Was ist wenn ich kein rubber installiert habe?
----------------------------------------------
Wenn du auf deinem System kein rubber installieren kannst oder möchtest, dann kannst du auch einfach xelatex oder pdflatex verwenden. Bei pdflatex sehen die Überschriften etwas hässlicher aus. Du kannst dann nicht das Build-Skript benutzen sondern musst jede Ordnung einzeln kompilieren.


Welche Dinge brauche ich um die Satzungen zu kompilieren?
---------------------------------------------------------
Außer rubber für das Build-Skript brauchst du noch folgende LaTeX-Pakete:
- koma-script midestens Version 0.7 (im texlive-latex-recommended Paket)


Was ist wenn meine KomaScript-Version zu alt ist?
-------------------------------------------------
Dann einfach von http://mirrors.ctan.org/install/macros/latex/contrib/koma-script.tds.zip herunterladen und im Home-Verzeichnis unter dem Ordner "texmf" entpacken (den muss man evtl. anlegen wenn er noch nicht vorhanden ist). Dann `texhash ~/texmf/` ausführen.


Wie lege ich ein neues Dokument an?
-----------------------------------
1. Neuen Unterordner anlegen, z.B. "sumpf-ordnung"
2. In einem Terminal mit `cd` in diesen Unterordner wechseln
```
cd /foo/bar/satzung/sumpf-ordnung
```
3. Das Rahmen-Dokument für das Einzeldokument anlegen
```
ln -s ../einzel.grundgeruest.tex sumpf-ordnung.tex
```
4. Das Dokument anlegen indem man das Template kopiert
```
cp ../document.core.tex ./
```
5. (Optional) Wenn das Dokument ein zentrale Satzung ist dann im gesamt.tex im Hauptordner noch das Unterdokument mit `\input{sumpf-ordnung/document.core.tex}` einbinden.

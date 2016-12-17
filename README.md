# Template zur Erzeugung einer Docker Umgebung mit TYPO3 7 CMS

**Requirements:**

* git
* docker >= 1.12.3
* docker-compose >= 1.8.1


**Usage:**

Das Tool doc muss einmalig installiert werden und dient der komfortablen Steuerung der Docker Container.
Der Installationsort sollte im Home-Verzeichnis liegen.
```
git clone https://github.com/mario-seidel/doc.git
sudo ln -s `pwd`/doc/scripts/doc /usr/local/bin/doc
```

Installation prüfen:
```
doc -h
```

Der Benutzer muss der Gruppe docker angehören:
```
sudo usermod -a -G docker userName
```

Jetzt clonen wir uns dieses Repo in das Verzeichnis "my_typo3_project" und führen alle weiteren "doc"-Commands in dem Verzeichnis aus:
```
git clone https://github.com/mario-seidel/doc-template-typo3.git my_typo3_project
cd my_typo3_project
doc initproject my-typo3-project
```

Danach wird automatisch ein composer install des Projektes ausgeführt. Den aktuellen Status kann man sich so ansehen:
([Strg] + [C] zum beenden :-)
```
doc logs web
```

#!/bin/sh

#java -jar /usr/local/Cellar/plantuml/8002/plantuml.8002.jar -tpng convert2uml.md
#open searchkit.png

java -jar /usr/local/Cellar/plantuml/8002/plantuml.8002.jar -tpng network.md
open network.png

@echo off
mvn -q -DskipTests package
java -jar target\grave-launcher-1.0.0.jar

#!/bin/bash

wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

java -jar jenkins.war

# java -jar jenkins.war --httpPort=8080
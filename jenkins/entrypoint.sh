#!/bin/sh

set -e

export JENKINS_HOME="/var/jenkins_home"

exec /usr/bin/java -jar /opt/jenkins/jenkins.war --httpPort=8600

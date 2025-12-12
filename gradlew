#!/usr/bin/env sh
##############################################################################
# Gradle start up script for UN*X
##############################################################################

set -e

PRG="$0"

# resolve symlinks
while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' >/dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`

# find java
if [ -n "$JAVA_HOME" ] ; then
  if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
    JAVACMD="$JAVA_HOME/jre/sh/java"
  else
    JAVACMD="$JAVA_HOME/bin/java"
  fi
else
  JAVACMD=`which java 2>/dev/null` || JAVACMD=java
fi

if [ -z "$JAVA_OPTS" ] ; then
  JAVA_OPTS=""
fi

exec "$JAVACMD" $JAVA_OPTS -cp "$PRGDIR/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain "$@"

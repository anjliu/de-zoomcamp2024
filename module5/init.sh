#!/bin/bash

# download and install packages

# download and install packages for Java
wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
tar xzfv openjdk-11.0.2_linux-x64_bin.tar.gz
rm openjdk-11.0.2_linux-x64_bin.tar.gz
# download and install packages for Spark
wget https://www.apache.org/dyn/closer.lua/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
tar xzfv spark-3.5.1-bin-hadoop3.tgz
rm spark-3.5.1-bin-hadoop3.tgz

# Set up environmental variables

# set up environmental variables to run Java
export JAVA_HOME="/workspaces/de-zoomcamp2024/module5/jdk-11.0.2"
export PATH="${JAVA_HOME}/bin:${PATH}"
# set up environmental variables to run Spark
export SPARK_HOME="/workspaces/de-zoomcamp2024/module5/spark-3.5.1-bin-hadoop3"
export PATH="${SPARK_HOME}/bin:${PATH}"
# set up environmental variables to run PySpark
export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH"

echo $PYTHONPATH
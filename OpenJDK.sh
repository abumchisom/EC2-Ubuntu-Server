#!/bin/bash

# OpenJDK installation script for Linux

# Update package index
sudo apt-get update

# Add its dependencies
sudo apt install apt-transport-https gnupg2 uuid-runtime pwgen curl dirmngr -y && sudo apt install openjdk-11-jre-headless -y

# Install OpenJDK (version 17)
apt install openjdk-17-jre-headless -y, you can do sudo apt install openjdk-17-jre-headless -y

# Verify installation
java -version

# output will be something like this

openjdk version "17.0.26" 2025-01-21
OpenJDK Runtime Environment (build 17.0.26+4-post-Ubuntu-1ubuntu124.04)
OpenJDK 64-Bit Server VM (build 17.0.26+4-post-Ubuntu-1ubuntu124.04, mixed mode, sharing)

# The reason for this is because MongoDB relies on OpenJDK.
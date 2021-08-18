#!/bin/bash
cd /opt
yum  update -y
#java installation
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
#start the java
rpm -ivh jdk-8u131-linux-x64.rpm
#install jenkins in linux os
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins -y
systemctl start jenkins
systemctl enable jenkins

#!/bin/bash
#install maven in /opt
cd /opt
yum install unzip -y
#download the zip
wget https://mirrors.estointernet.in/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
#extract 
unzip apache-maven-3.8.1-bin.zip
#rename
mv apache-maven-3.8.1 maven38
#change the permissions
chmod -R 700 maven38
#delte the zip
rm -f apache-maven-3.8.1-bin.zip

#docker 
yum install docker -y
#git
yum install git -y
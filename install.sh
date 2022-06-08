#!/bin/bash
sudo apt update -y
sudo apt install postgresql-11 -y
sudo apt install curl ca-certificates gnupg unzip wget -y
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt update -y
sudo apt install postgresql-11-pljava -y
sudo echo "
pljava.libjvm_location = '/usr/lib/jvm/java-11-openjdk-arm64/lib/server/libjvm.so'
#pljava.classpath = '/usr/share/postgresql/11/pljava/pljava-1.6.4.jar:i/usr/share/postgresql/11/pljava/pljava-api-1.6.4.jar'
pljava.module_path = '/usr/share/postgresql/11/pljava/pljava-1.6.4.jar:/usr/share/postgresql/11/pljava/pljava-api-1.6.4.jar'
" >> /etc/postgresql/11/main/postgresql.conf
sudo echo "
host all 	all  0.0.0.0/0 md5
" >> /etc/postgresql/11/main/pg_hba.conf
sudo echo '
grant {
  permission java.security.AllPermission;
};
' >> /etc/postgresql-common/pljava.policy
systemctl restart postgresql
systemctl enable postgresql
sudo mkdir -p /opt
sudo cd /opt
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz
sudo tar -zxvf apache-tomcat-9.0.63.tar.gz
sudo cd /opt/apache-tomcat-9.0.63/lib
sudo wget https://jdbc.postgresql.org/download/postgresql-42.3.6.jar


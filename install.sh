#!/bin/bash
#Author Sunil Sankar
#Date 9-Jun-2022
MEM=$(free -g |grep Mem |awk '{ print $2}')
tmpdir="$(dirname $0)"
echo ${tmpdir} | grep '^/' >/dev/null 2>&1
if [ $? -eq 0 ]; then
    export ROOTDIR="${tmpdir}"
else
    export ROOTDIR="$(pwd)"
fi

#Validate Root 
validate_user() {
  if [ "$(whoami)" != "root" ]; then
        echo "Script must be run as user: root"
        exit 255
  fi
}
#Check Architecture


arch() {
  architecture=""
  case $(uname -m) in
    i386)   architecture="386" ;;
    i686)   architecture="386" ;;
    x86_64) architecture="amd64" ;;
    aarch64) architecture="arm64" ;;
    arm)    dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
  esac
  echo $architecture
}


deb () {
    arch
    sudo apt update -y
    sudo apt install postgresql-11 -y
    sudo apt install curl ca-certificates gnupg unzip wget -y
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    sudo apt update -y
    sudo apt install postgresql-11-pljava -y
    javaver="java-11-openjdk-$architecture"

    sudo echo "
    pljava.libjvm_location = '/usr/lib/jvm/${javaver}/lib/server/libjvm.so'
    #pljava.classpath = '/usr/share/postgresql/11/pljava/pljava-1.6.4.jar:i/usr/share/postgresql/11/pljava/pljava-api-1.6.4.jar'
    pljava.module_path = '/usr/share/postgresql/11/pljava/pljava-1.6.4.jar:/usr/share/postgresql/11/pljava/pljava-api-1.6.4.jar'
    " >> /etc/postgresql/11/main/postgresql.conf

    sudo echo "
    host all 	all  0.0.0.0/0 md5
    " >> /etc/postgresql/11/main/pg_hba.conf

    sudo echo "
    grant {
    permission java.security.AllPermission;
    };
    " >> /etc/postgresql-common/pljava.policy
    sudo sed -i "s&^#listen_addresses = .*&listen_addresses =  '*' &g" /etc/postgresql/11/main/postgresql.conf 
    sudo systemctl enable postgresql
    sudo systemctl restart postgresql
  }
tomcat () {
    sudo mkdir -p /opt
    sudo cd /opt
    sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.14/bin/apache-tomcat-8.5.14.tar.gz -P /opt
    sudo cd /opt
    sudo tar -zxvf /opt/apache-tomcat-8.5.14.tar.gz -C /opt
    #sudo wget https://jdbc.postgresql.org/download/postgresql-42.3.6.jar -P ${ROOTDIR}
    sudo cp ${ROOTDIR}/postgresql-42.3.6.jar /opt/apache-tomcat-8.5.14/lib/
    sudo cp ${ROOTDIR}/conf/* /opt/apache-tomcat-8.5.14/conf/
    sudo cp ${ROOTDIR}/setenv.sh /opt/apache-tomcat-8.5.14/bin/
}
pljava() {
    su - postgres -c "psql -f /vagrant/installpljava.sql"

}
if [ "$MEM" -ge "4" ]; then
   validate_user
   deb
   tomcat
   pljava
else
    echo "RAM should be minimum 4GB, Recommended 8GB"
fi

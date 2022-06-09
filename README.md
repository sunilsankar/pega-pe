# Pega Personal Edition installation in Debian 

This has been tested in vagrant debian 10 os as well mac book running m1 processor running debian on parallels  as wel tested in rasperberry pi running dietpi

Once the vm is ready the following steps needs to be performed on the vm
## Step 1
if it is running on rasperberry pi or mac m1 . We need to edit install.sh 
to
```
pljava.libjvm_location = '/usr/lib/jvm/java-11-openjdk-arm64/lib/server/libjvm.so'
```
If it is x86 Architecture then this line needs to be
```
pljava.libjvm_location = '/usr/lib/jvm/java-11-openjdk-amd64/lib/server/libjvm.so'
```
## Step 2
Run install.sh

## Step 3
Copy the installsqljava.sql from repo directory to /var/lib/postgresql

Change permission to postgres and then switch user as postgres and this command

```
psql -f installsqljava.sql
```
## Step 4
Extract the PE Zip directory. You will see a folder called data and under this you will find two dump files. Copy them to /var/lib/postgresql and change the permission to postgres

Switch user as postgres and run the below commands

```
pg_restore -U postgres --disable-triggers -d postgres -O -j 2 -v sqlj.dump 
pg_restore -U postgres --disable-triggers -d postgres -O -j 2 -v pega.dump 

```
## Step 5
Currently postgres password is not set .Switch user as postgres and run the below command

```
ALTER USER postgres with password 'postgres';
```
## Step 6 
Test the db connectivity and see
```
psql -U postgres -h localhost -p 5432 -d postgres
```

## Step 7 - Configure Tomcat
copy the downloaded apache 8.5.14 to /opt
```
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.14/bin/apache-tomcat-8.5.14.tar.gz 
```
Extract tomcat
```
cd /opt
tar -zxvf apache-tomcat-8.5.14.tar.gz
```
## Step8 
Replace the content in conf directory in this gitrepo in apache-tomcat-8.5.14/conf

## Step 9
Copy the setenv.sh from repo to bin directory in apache-tomcat-8.5.14

## Step 10
Copy the postgresql-42.3.6.jar from repo to lib directory in apache-tomcat-8.5.14
## Step 11 copying the war files
The war files are present in pega-pe binary when you extract
PRPC_PE.jar and then you extract PersonalEdition.zip and then under resources tomcat webapps you will find prhelp.war and prweb.war

Copy them to /opt/apache-tomcat-8.5.14/webapps

## Step 11
 Check the server.xml file under apache-tomcat-8.5.14/conf folder path. The file contains a connector port. Make sure the port is configured to the required value, like 8080 or 8090. 

## Step 12
Start tomcat
```
cd /opt/apache-tomcat-8.5.14/bin
./startup.sh

```

### Step 13 

Hit the browser and check whether the server is up.

   From outside the Debian box : http://{IP address of the Debian VM}:8080/prweb/app 

   From inside Linux box : http://localhost:8080/prweb/app 
  
  
### Step 14
   The default credential to login to the portal is administrator@pega.com/ (password : install) 

### Step 15
 Stopping the tomcat , when the required work is done.
 
 ```
cd /opt/apache-tomcat-8.5.14/bin
./shutdown.sh

```
 

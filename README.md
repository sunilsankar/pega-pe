# Pega Personal Edition installation in Debian 

This has been tested in vagrant debian 10 os as well mac book running m1 processor running debian on parallels  as wel tested in rasperberry pi running dietpi

Once the vm is ready the following steps needs to be performed on the vm
## Step 1

Run install.sh

## Step 2
Extract the PE Zip directory. You will see a folder called data and under this you will find two dump files. Copy them to /var/lib/postgresql and change the permission to postgres

Switch user as postgres and run the below commands

```
pg_restore -U postgres --disable-triggers -d postgres -O -j 2 -v sqlj.dump 
pg_restore -U postgres --disable-triggers -d postgres -O -j 2 -v pega.dump 

```
> **_NOTE:_**  This will improve the performance of restart 
> ```
> reindex database postgres;
> ```

## Step 3
Test the db connectivity and see
```
psql -U postgres -h localhost -p 5432 -d postgres
```
## Step 4 copying the war files
The war files are present in pega-pe binary when you extract
PRPC_PE.jar and then you extract PersonalEdition.zip and then under  tomcat webapps folder you will find prhelp.war and prweb.war

Copy them to /opt/apache-tomcat-8.5.14/webapps

## Step 5
Start tomcat
```
cd /opt/apache-tomcat-8.5.14/bin
./startup.sh

```

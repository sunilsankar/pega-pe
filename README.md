```
psql -f installsqljava.sql
```

```
pg_restore -U postgres --disable-triggers -d postgres -O -j 2 -v sqlj.dump 
pg_restore -U postgres --disable-triggers -d postgres -O -j 2 -v pega.dump 

```

```
ALTER USER postgres with password 'postgres';
```

```
psql -U postgres -h localhost -p 5432 -d postgres
```
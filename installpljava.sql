CREATE EXTENSION pljava;
 CREATE FUNCTION getsysprop(VARCHAR)
 RETURNS VARCHAR
 AS 'java.lang.System.getProperty'
 LANGUAGE java;
 SELECT getsysprop('user.home');
-- MySQL read only user


CREATE USER 'classicmodels'@'%' IDENTIFIED BY 'classicmodels';
GRANT SELECT, SHOW VIEW on classicmodels.* TO 'classicmodels'@'%';
FLUSH PRIVILEGES;


-- SQL Server super user for DW database


create LOGIN DWSRVC WITH PASSWORD = 'DWSRVC'
GO

create database DW;
USE DW
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals where name = N'DWSRVC')
BEGIN
	CREATE USER DWSRVC FOR LOGIN DWSRVC
	EXEC sp_addrolemember N'db_owner',N'DWSRVC'
END;
GO

/*
After creating the user in SQL Server, enable SQL Server Authentication mode. Also enable login through TCP/IP mode.
Either of the changes require the SQL Server instance to be restarted.
*/

-- User for the logging database 
create LOGIN Logging WITH PASSWORD = 'Logging'
GO

create database pdi_logging;
USE pdi_logging
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals where name = N'Logging')
BEGIN
	CREATE USER Logging FOR LOGIN Logging
	EXEC sp_addrolemember N'db_owner',N'Logging'
END;
GO

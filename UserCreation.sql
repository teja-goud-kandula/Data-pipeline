-- MySQL read only user

CREATE USER 'classicmodels'@'%' IDENTIFIED BY 'classicmodels';
GRANT SELECT, SHOW VIEW on classicmodels.* TO 'classicmodels'@'%';
FLUSH PRIVILEGES;

-- SQL Server super user
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
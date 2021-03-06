USE [master]
GO
/****** Object:  Database [UserDictionaryDB]    Script Date: 6.2.2020. 12:13:40 ******/
CREATE DATABASE [UserDictionaryDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UserDictionaryDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.LOCAL\MSSQL\DATA\UserDictionaryDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UserDictionaryDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.LOCAL\MSSQL\DATA\UserDictionaryDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [UserDictionaryDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UserDictionaryDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UserDictionaryDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [UserDictionaryDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UserDictionaryDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UserDictionaryDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [UserDictionaryDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UserDictionaryDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [UserDictionaryDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UserDictionaryDB] SET  MULTI_USER 
GO
ALTER DATABASE [UserDictionaryDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UserDictionaryDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UserDictionaryDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UserDictionaryDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UserDictionaryDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UserDictionaryDB] SET QUERY_STORE = OFF
GO
USE [UserDictionaryDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 6.2.2020. 12:13:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6.2.2020. 12:13:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[PostNumber] [int] NOT NULL,
	[City] [nvarchar](max) NULL,
	[Telephone] [nvarchar](max) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_User_PostNumber]    Script Date: 6.2.2020. 12:13:40 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_User_PostNumber] ON [dbo].[User]
(
	[PostNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[InsertProc]    Script Date: 6.2.2020. 12:13:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProc] 
       @FirstName       NVARCHAR(50)  = NULL   , 
      @LastName          NVARCHAR(50)  = NULL   , 
	  @PostNumber      INT  = NULL   , 
	  @City           NVARCHAR(50)  = NULL   , 
	  @Telephone         NVARCHAR(50)  = NULL   
AS 
DECLARE @ErrorMessage NVARCHAR(255);
DECLARE @ErrorSeverity NVARCHAR(255);
DECLARE @ErrorState NVARCHAR(255);
BEGIN TRY
     SET NOCOUNT ON 

     INSERT INTO [UserDictionaryDB].dbo.[User]
          (                    
            FirstName,
            LastName,
            PostNumber,
            City,
			Telephone
          ) 
     VALUES 
          ( 
            @FirstName,
            @LastName,
            @PostNumber,
            @City,
			@Telephone
          ) 

END TRY
BEGIN CATCH
    SET @ErrorMessage  = ERROR_MESSAGE()
    SET @ErrorSeverity = ERROR_SEVERITY()
    SET @ErrorState    = ERROR_STATE()
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState) WITH LOG
END CATCH
GO
USE [master]
GO
ALTER DATABASE [UserDictionaryDB] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [RestAPIDapper2]    Script Date: 19/11/2021 10:13:58 AM ******/
CREATE DATABASE [RestAPIDapper2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RestAPIDapper2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\RestAPIDapper2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RestAPIDapper2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\RestAPIDapper2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [RestAPIDapper2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RestAPIDapper2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RestAPIDapper2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET ARITHABORT OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RestAPIDapper2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RestAPIDapper2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RestAPIDapper2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RestAPIDapper2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET RECOVERY FULL 
GO
ALTER DATABASE [RestAPIDapper2] SET  MULTI_USER 
GO
ALTER DATABASE [RestAPIDapper2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RestAPIDapper2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RestAPIDapper2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RestAPIDapper2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RestAPIDapper2] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RestAPIDapper2', N'ON'
GO
ALTER DATABASE [RestAPIDapper2] SET QUERY_STORE = OFF
GO
USE [RestAPIDapper2]
GO
/****** Object:  UserDefinedTableType [dbo].[Permission]    Script Date: 19/11/2021 10:13:58 AM ******/
CREATE TYPE [dbo].[Permission] AS TABLE(
	[RoleId] [uniqueidentifier] NULL,
	[FunctionId] [varchar](50) NOT NULL,
	[ActionId] [varchar](50) NOT NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_CSVToTable]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufn_CSVToTable] ( @StringInput NVARCHAR(max), @Delimiter nvarchar(1))
RETURNS @OutputTable TABLE ( [String] NVARCHAR(50) )
AS
BEGIN

    DECLARE @String   NVARCHAR(50)

    WHILE LEN(@StringInput) > 0
    BEGIN
        SET @String      = LEFT(@StringInput, 
                                ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput) - 1, -1),
                                LEN(@StringInput)))
        SET @StringInput = SUBSTRING(@StringInput,
                                     ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput), 0),
                                     LEN(@StringInput)) + 1, LEN(@StringInput))

        INSERT INTO @OutputTable ( [String] )
        VALUES ( @String )
    END

    RETURN
END
GO
/****** Object:  Table [dbo].[ActionInFunctions]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActionInFunctions](
	[FunctionId] [varchar](50) NOT NULL,
	[ActionId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ActionInFunctions] PRIMARY KEY CLUSTERED 
(
	[FunctionId] ASC,
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[Id] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[FullName] [nvarchar](250) NULL,
	[Address] [nvarchar](250) NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeOptions]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeOptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_AttributeOptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeOptionValues]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeOptionValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OptionId] [int] NULL,
	[Value] [nvarchar](255) NULL,
	[LanguageId] [varchar](5) NULL,
 CONSTRAINT [PK_AttributeOptionValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[SortOrder] [int] NULL,
	[BackendType] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueDatetimes]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueDatetimes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[Value] [datetime] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueDatetimes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueDecimals]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueDecimals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[Value] [decimal](18, 0) NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueDecimals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueInts]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueInts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[Value] [int] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueInts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueTexts]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueTexts](
	[Id] [int] NOT NULL,
	[AttributeId] [int] NULL,
	[Value] [ntext] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueVachars]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueVachars](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[Value] [varchar](255) NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueVachars] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[SeoAlias] [nvarchar](255) NULL,
	[SeoTitle] [nvarchar](255) NULL,
	[SeoKeyword] [nvarchar](255) NULL,
	[SeoDescription] [nvarchar](255) NULL,
	[ParentId] [int] NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Functions]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Functions](
	[Id] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Url] [nvarchar](50) NULL,
	[ParentId] [varchar](50) NULL,
	[SortOrder] [int] NULL,
	[CssClass] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Functions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDefault] [bit] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[ProductId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[CustomerAddress] [nvarchar](255) NOT NULL,
	[CustomerEmail] [nvarchar](50) NOT NULL,
	[CustomerPhone] [varchar](20) NOT NULL,
	[CustomerNote] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[FunctionId] [varchar](50) NOT NULL,
	[ActionId] [varchar](50) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[FunctionId] ASC,
	[ActionId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductInCategories]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductInCategories](
	[ProductId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_ProductInCategories] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sku] [varchar](50) NOT NULL,
	[Price] [float] NOT NULL,
	[DiscountPrice] [float] NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[ImageList] [nvarchar](max) NULL,
	[ViewCount] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[RateTotal] [int] NULL,
	[RateCount] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTranslations]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTranslations](
	[ProductId] [int] NOT NULL,
	[LanguageId] [varchar](50) NOT NULL,
	[Content] [ntext] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[SeoDescription] [nvarchar](255) NULL,
	[SeoAlias] [varchar](255) NULL,
	[SeoTitle] [nvarchar](255) NULL,
	[SeoKeyword] [nvarchar](255) NULL,
 CONSTRAINT [PK_ProductTranslations] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'CREATE')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'DELETE')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'IMPORT')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'UPDATE')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'VIEW')
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'APPROVE', N'Duyệt', 7, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'CREATE', N'Tạo mới', 1, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'DELETE', N'Xóa', 3, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'EXPORT', N'Xuất', 6, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'IMPORT', N'Nhập', 5, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'UPDATE', N'Cập nhật', 2, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'VIEW', N'Truy cập', 4, 1)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'c099e131-2cae-4c83-8535-3386118682c8', N'admin', N'ADMIN', NULL)
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [SeoAlias], [SeoTitle], [SeoKeyword], [SeoDescription], [ParentId], [SortOrder], [IsActive]) VALUES (1, N'Áo phông nam', N'ao-phong-nam', N'ao-phong', N'ao-phong-nam', N'áo phông nam 2021', 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT', N'Báo cáo', N'/admin/report', NULL, 3, N'icon-system', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT.INVENTORY', N'Tồn kho', N'/admin/report/inventory', N'REPORT', 2, N'icon-inventory', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT.REVENUE', N'Doanh thu', N'/admin/report/revenue', N'REPORT', 1, N'icon-revenue', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT.VISITOR', N'Truy cập', N'/admin/report/visitor', N'REPORT', 3, N'icon-visitor', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES', N'Kinh doanh', N'/admin/sales', NULL, 2, N'icon-sales', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.ATTRIBUTE', N'Thuộc tính', N'/admin/sales/attribute', N'SALES', 4, N'icon-attribute', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.CATALOG', N'Nhóm sản phẩm', N'/admin/sales/catalog', N'SALES', 1, N'icon-catalog', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.ORDER', N'Hóa đơn', N'/admin/sales/order', N'SALES', 3, N'icon-order', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.PRODUCT', N'Sản phẩm', N'/admin/sales/product', N'SALES', 2, N'icon-product', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM', N'Hệ thống', N'/admin/system', NULL, 1, N'icon-system', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM.ROLE', N'Nhóm người dùng', N'/admin/system/role', N'SYSTEM', 1, N'icon-role', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM.SETTING', N'Cấu hình', N'/admin/system/setting', N'SYSTEM', 3, N'icon-setting', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM.USER', N'Người dùng', N'/admin/system/user', N'SYSTEM', 2, N'icon-user', 1)
INSERT [dbo].[Languages] ([Id], [Name], [IsActive], [IsDefault], [SortOrder]) VALUES (N'en-US', N'Tiếng Anh', 1, 0, 2)
INSERT [dbo].[Languages] ([Id], [Name], [IsActive], [IsDefault], [SortOrder]) VALUES (N'vi-VN', N'Tiếng Việt', 1, 1, 1)
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'SYSTEM.USER', N'CREATE', N'c099e131-2cae-4c83-8535-3386118682c8')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'SYSTEM.USER', N'VIEW', N'c099e131-2cae-4c83-8535-3386118682c8')
INSERT [dbo].[ProductInCategories] ([ProductId], [CategoryId]) VALUES (4, 1)
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (2, N'AN-2018-01-0001', 120000, NULL, N'/images/ao-phong-nam-2018.jpg', NULL, NULL, CAST(N'2018-12-12T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (4, N'string', 0, NULL, N'string', NULL, 0, CAST(N'2021-11-17T11:10:12.927' AS DateTime), NULL, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (2, N'en-US', N'English content', N't-shirt', N'Description t-shirt', N'Description for t shirt', N't-shirt', N'T-Shirt', N't-shirt')
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (2, N'vi-VN', N'Nội dung tiếng việt', N'Áo phông', N'Áo phông mô tả', N'Mô tả áo phông', N'ao-phong', N'Áo phông', N'ao phong')
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (4, N'en-US', N'string', N'string', N'string', N'string', N'string', N'string', N'string')
ALTER TABLE [dbo].[ActionInFunctions]  WITH CHECK ADD  CONSTRAINT [FK_ActionInFunctions_Actions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
GO
ALTER TABLE [dbo].[ActionInFunctions] CHECK CONSTRAINT [FK_ActionInFunctions_Actions]
GO
ALTER TABLE [dbo].[ActionInFunctions]  WITH CHECK ADD  CONSTRAINT [FK_ActionInFunctions_Functions] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[Functions] ([Id])
GO
ALTER TABLE [dbo].[ActionInFunctions] CHECK CONSTRAINT [FK_ActionInFunctions_Functions]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AttributeOptions]  WITH CHECK ADD  CONSTRAINT [FK_AttributeOptions_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeOptions] CHECK CONSTRAINT [FK_AttributeOptions_Attributes]
GO
ALTER TABLE [dbo].[AttributeOptionValues]  WITH CHECK ADD  CONSTRAINT [FK_AttributeOptionValues_AttributeOptions] FOREIGN KEY([OptionId])
REFERENCES [dbo].[AttributeOptions] ([Id])
GO
ALTER TABLE [dbo].[AttributeOptionValues] CHECK CONSTRAINT [FK_AttributeOptionValues_AttributeOptions]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_AttributeValueDatetimes] FOREIGN KEY([Id])
REFERENCES [dbo].[AttributeValueDatetimes] ([Id])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_AttributeValueDatetimes]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_AttributeValueDecimals] FOREIGN KEY([Id])
REFERENCES [dbo].[AttributeValueDecimals] ([Id])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_AttributeValueDecimals]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_AttributeValueInts] FOREIGN KEY([Id])
REFERENCES [dbo].[AttributeValueInts] ([Id])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_AttributeValueInts]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_AttributeValueTexts] FOREIGN KEY([Id])
REFERENCES [dbo].[AttributeValueTexts] ([Id])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_AttributeValueTexts]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_AttributeValueVachars] FOREIGN KEY([Id])
REFERENCES [dbo].[AttributeValueVachars] ([Id])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_AttributeValueVachars]
GO
ALTER TABLE [dbo].[AttributeValueDatetimes]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueDatetimes_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueDatetimes] CHECK CONSTRAINT [FK_AttributeValueDatetimes_Products]
GO
ALTER TABLE [dbo].[AttributeValueDecimals]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueDecimals_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueDecimals] CHECK CONSTRAINT [FK_AttributeValueDecimals_Products]
GO
ALTER TABLE [dbo].[AttributeValueInts]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueInts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueInts] CHECK CONSTRAINT [FK_AttributeValueInts_Products]
GO
ALTER TABLE [dbo].[AttributeValueTexts]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueTexts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueTexts] CHECK CONSTRAINT [FK_AttributeValueTexts_Products]
GO
ALTER TABLE [dbo].[AttributeValueVachars]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueVachars_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueVachars] CHECK CONSTRAINT [FK_AttributeValueVachars_Products]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Actions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Actions]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_AspNetRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_AspNetRoles]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Functions] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[Functions] ([Id])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Functions]
GO
ALTER TABLE [dbo].[ProductInCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProductInCategories_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[ProductInCategories] CHECK CONSTRAINT [FK_ProductInCategories_Categories]
GO
ALTER TABLE [dbo].[ProductInCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProductInCategories_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductInCategories] CHECK CONSTRAINT [FK_ProductInCategories_Products]
GO
ALTER TABLE [dbo].[ProductTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductTranslations_Languages] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[ProductTranslations] CHECK CONSTRAINT [FK_ProductTranslations_Languages]
GO
ALTER TABLE [dbo].[ProductTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductTranslations_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductTranslations] CHECK CONSTRAINT [FK_ProductTranslations_Products]
GO
/****** Object:  StoredProcedure [dbo].[Create_Attribute]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Create_Attribute]
	@code varchar(255),
	@name nvarchar(255),
	@sortOrder int,
	@backendType varchar(50),
	@isActive bit,
	@hasOption bit,
	@language varchar(5),
	@values nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	  if not exists(select 1 from Attributes where Code = @code)
	  begin
		--Insert attribute
		insert into Attributes(Code,Name,SortOrder,BackendType,IsActive)
		values(@code,@name,@sortOrder,@backendType,@isActive)
		--Insert options
		declare @attributeId int
		select @attributeId = SCOPE_IDENTITY()
		if @hasOption = 1
		begin
			insert into AttributeOptions(AttributeId,SortOrder) values(@attributeId,1)
			declare @optionId int
			select @optionId = SCOPE_IDENTITY()
			--Insert option values
			declare @valueTbl table(Data nvarchar(255))
			insert into @valueTbl(Data)
			select * from dbo.ufn_CSVToTable(@values,',')

			insert into AttributeOptionValues(OptionId,Value,LanguageId)
			select @optionId,*,@language from @valueTbl
		end
		
	  end
	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch

END
GO
/****** Object:  StoredProcedure [dbo].[Create_Function]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Create_Function]
	-- Add the parameters for the stored procedure here	
	@id varchar(50),
	@name nvarchar(50),
	@url nvarchar(50),
	@parentId varchar(50),
	@sortOrder int,
	@cssClass nvarchar(50),
	@isActive bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;

    -- Insert statements for procedure here

	begin tran
		begin try
			insert into Functions(Id,Name,Url,ParentId,SortOrder,CssClass,IsActive)
			values(@id,@name,@url,@parentId,@sortOrder,@cssClass,@isActive)


	commit
	end try
	begin catch
		rollback
		Declare @ErrorMessage varchar(2000)
		Select @ErrorMessage = 'Lỗi' + ERROR_MESSAGE()
		Raiserror(@ErrorMessage,16,1)
	end catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Create_Permission]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Create_Permission]
	@roleId uniqueidentifier,
	@permissions dbo.Permission readonly
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	   delete from Permissions where RoleId = @roleId

	   insert into Permissions (RoleId,FunctionId,ActionId)
	   select RoleId,FunctionId,ActionId from @permissions

	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch



  
END
GO
/****** Object:  StoredProcedure [dbo].[Create_Product]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Create_Product]
	-- Add the parameters for the stored procedure here	
	@name nvarchar(255),
	@description nvarchar(255),
	@content ntext,
	@seoDescription nvarchar(255),
	@seoAlias nvarchar(255),
	@seoTitle nvarchar(255),
	@seoKeyword nvarchar(255),
	@sku varchar(50),
	@price float,
	@isActive bit,
	@imageUrl nvarchar(255),
	@language varchar(5),
	@categoryIds varchar(50),
	@id int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;

    -- Insert statements for procedure here

	begin tran
		begin try
			insert into Products(Sku,Price, IsActive, ImageUrl, CreatedAt, ViewCount,RateTotal,RateCount)
			values(@sku,@price,@isActive,@imageUrl,getdate(),0,0,0)
			set @id = SCOPE_IDENTITY() --lay ra id moi nhat vua duoc tao

			insert into ProductTranslations(ProductId,LanguageId,Content,Name,Description,SeoDescription,SeoAlias,SeoTitle,SeoKeyword)
			values(@id,@language,@content,@name,@description,@seoDescription,@seoAlias,@seoTitle,@seoKeyword)

			delete from ProductInCategories where ProductId=@id

			insert into ProductInCategories
				select @id as ProductId , cast(String as int) as CategoryId from ufn_CSVToTable(@categoryIds,',')
	commit
	end try
	begin catch
		rollback
		Declare @ErrorMessage varchar(2000)
		Select @ErrorMessage = 'Lỗi' + ERROR_MESSAGE()
		Raiserror(@ErrorMessage,16,1)
	end catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Attribute]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Delete_Attribute]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	  delete from AttributeOptionValues where OptionId
	  in (select Id from AttributeOptions where AttributeId = @id)

	  delete from AttributeOptions where AttributeId = @id

	  delete from AttributeValueDateTimes where AttributeId = @id
	  delete from AttributeValueDecimals where AttributeId = @id

	  delete from AttributeValueInts where AttributeId = @id
	  delete from AttributeValueText where AttributeId = @id
	  delete from AttributeValueVarchars where AttributeId = @id

	  delete from Attributes where Id = @id
	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch



  
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Function_ById]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Delete_Function_ById]
	-- Add the parameters for the stored procedure here	
	@id int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on; --mặc định là off, lỗi vẫn chạy tiếp
    -- Insert statements for procedure here
	-- Add them Begin tran va commit de tao transaction dam bao neu xoa loi se rollback
	Begin tran
		begin try
			delete from Functions
			where Id=@id
	commit
	end try
		begin catch
			rollback
			Declare @ErrorMessage varchar(2000)
			Select @ErrorMessage = 'Lỗi' + ERROR_MESSAGE()
			Raiserror(@ErrorMessage,16,1)
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Product_ById]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Delete_Product_ById]
	-- Add the parameters for the stored procedure here	
	@id int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on; --mặc định là off, lỗi vẫn chạy tiếp
    -- Insert statements for procedure here
	-- Add them Begin tran va commit de tao transaction dam bao neu xoa loi se rollback
	Begin tran
		begin try
			delete from Products
			where Id=@id
			delete from ProductTranslations
			where ProductId=@id
	commit
	end try
		begin catch
			rollback
			Declare @ErrorMessage varchar(2000)
			Select @ErrorMessage = 'Lỗi' + ERROR_MESSAGE()
			Raiserror(@ErrorMessage,16,1)
		end catch
END
GO
/****** Object:  StoredProcedure [dbo].[Get_All_Role]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_All_Role] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id, Name, NormalizedName from dbo.AspNetRoles
END
GO
/****** Object:  StoredProcedure [dbo].[Get_All_User]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_All_User] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id, UserName, Email, PhoneNumber, FullName, Address from dbo.AspNetUsers
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_All]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Function_All] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[Name]
      ,[Url]
      ,[ParentId]
      ,[SortOrder]
      ,[CssClass]
      ,[IsActive]
  FROM [dbo].[Functions]
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_AllPaging]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Function_AllPaging] 
	-- Add the parameters for the stored procedure here
	@keyword nvarchar(50),
	@pageIndex int,
	@pageSize int,
	@totalRow int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--offset bỏ qua bao nhieu rows ko lấy
	-- fetch next --chỉ lấy số lượng dòng @pageSize tiếp theo 
	select @totalRow = count(*) from dbo.Functions f 
	where (@keyword is null or f.Name like @keyword +'%')

	SELECT [Id]
      ,[Name]
      ,[Url]
      ,[ParentId]
      ,[SortOrder]
      ,[CssClass]
      ,[IsActive]
	FROM [dbo].[Functions] f
	where (@keyword is null or f.Name like @keyword +'%')
	order by f.Name
	OFFSET (@pageIndex - 1) * @pageSize rows 
	fetch next @pageSize row only 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_ById]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Get_Function_ById]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[Name]
      ,[Url]
      ,[ParentId]
      ,[SortOrder]
      ,[CssClass]
      ,[IsActive]
	FROM [dbo].[Functions]
	where Id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_ByPermission]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Get_Function_ByPermission]
	@userId varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select 
		f.Id,
		f.Name,
		f.Url,
		f.ParentId,
		f.IsActive,
		f.SortOrder,
		f.CssClass
	 from Functions f
	join Permissions p on f.Id = p.FunctionId
	join AspNetRoles r on p.RoleId = r.Id
	join Actions a on p.ActionId = a.Id
	join AspNetUserRoles ur on r.Id = ur.RoleId
	where ur.UserId = @userId and a.Id ='VIEW'
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_WithActions]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Get_Function_WithActions]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
			f.Id,
			f.Name,
			f.ParentId,
			case when sum(case when a.Id='CREATE' then 1 else 0 end)>0 then 1 else 0 end as HasCreated,
			case when sum(case when a.Id='UPDATE' then 1 else 0 end)>0 then 1 else 0 end as HasUpdate,
			case when sum(case when a.Id='DELETE' then 1 else 0 end)>0 then 1 else 0 end as HasDelete,
			case when sum(case when a.Id='VIEW' then 1 else 0 end)>0 then 1 else 0 end as HasView,
			case when sum(case when a.Id='IMPORT' then 1 else 0 end)>0 then 1 else 0 end as HasImport,
			case when sum(case when a.Id='EXPORT' then 1 else 0 end)>0 then 1 else 0 end as HasExport,
			case when sum(case when a.Id='APPROVE' then 1 else 0 end)>0 then 1 else 0 end as HasApprove
		from Functions f
			left join ActionInFunctions aif on f.Id = aif.FunctionId
			left join Actions a on aif.ActionId = a.Id
	    group by f.Id,f.Name,f.ParentId
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Permission_ByRoleId]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Get_Permission_ByRoleId]
	@roleId uniqueidentifier null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select 
		p.FunctionId,
		p.ActionId,
		p.RoleId
	from Permissions p inner join Actions a
		on p.ActionId = a.Id 
	where p.RoleId = @roleId
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Permission_ByUserId]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Get_Permission_ByUserId]
	@userId varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select distinct 
		f.Id + '_' + a.Id
	from Permissions p 
	join Functions f on f.Id = p.FunctionId
	join AspNetRoles r on p.RoleId = r.Id
	join Actions a on p.ActionId = a.Id
	join AspNetUserRoles ur on r.Id = ur.RoleId
	where ur.UserId = @userId 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Product_All]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Get_Product_All]
	-- Add the parameters for the stored procedure here
	@language varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
		p.Id,
		p.Sku,
		p.Price,
		p.DiscountPrice,
		p.ImageUrl,
		p.CreatedAt,
		p.IsActive,
		p.ViewCount,
		pt.Name,
		pt.Content,
		pt.Description,
		pt.SeoDescription,
		pt.SeoAlias,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId
	from Products p
	inner join ProductTranslations pt 
	on p.Id = pt.ProductId
	where pt.LanguageId = @language
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Product_AllPaging]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Product_AllPaging] 
	-- Add the parameters for the stored procedure here
	@keyword nvarchar(50),
	@categoryId int,
	@pageIndex int,
	@pageSize int,
	@language varchar(5),
	@totalRow int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--offset bỏ qua bao nhieu rows ko lấy
	-- fetch next --chỉ lấy số lượng dòng @pageSize tiếp theo 
	select @totalRow = count(*) from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on pic.CategoryId = c.Id
	where (@keyword is null or p.Sku like @keyword +'%') and p.IsActive = 1 and pt.LanguageId=@language and pic.CategoryId=@categoryId

	select 
		p.Id,
		p.Sku,
		p.Price,
		p.DiscountPrice,
		p.ImageUrl,
		p.CreatedAt,
		p.IsActive,
		p.ViewCount,
		pt.Name,
		pt.Content,
		pt.Description,
		pt.SeoDescription,
		pt.SeoAlias,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId,
		c.Name as CategoryName --de cung ten voi CategoryName tren model Product
	from Products p inner join ProductTranslations pt on p.Id = pt.ProductId
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on pic.CategoryId = c.Id
	where (@keyword is null or p.Sku like @keyword +'%')
	and p.IsActive = 1 and pt.LanguageId=@language and pic.CategoryId=@categoryId
	order by p.CreatedAt desc
	OFFSET (@pageIndex - 1) * @pageSize rows 
	fetch next @pageSize row only 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Product_Attributes]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Get_Product_Attributes] 
	@id int,
	@language varchar(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select
		a.Id,
		a.[Name],
		convert(nvarchar(200),case 
			when a.BackendType= 'int' then convert(nvarchar(200),ai.Value)
			when a.BackendType= 'text' then convert(nvarchar(200),ai.Value) 
			when a.BackendType= 'datetime' then convert(nvarchar(200),adt.Value) 
			when a.BackendType= 'decimal' then convert(nvarchar(200),ad.Value) 
			when a.BackendType= 'varchar' then convert(varchar(200),avc.Value) 
		 end) as [Value]
		 from Attributes a
		 left join AttributeValueInts ai on a.Id = ai.AttributeId and ai.LanguageId=@language and ai.ProductId = @id
		 left join AttributeValueText avt on a.Id = avt.AttributeId and avt.LanguageId=@language and avt.ProductId = @id
		 left join AttributeValueDateTimes adt on a.Id = adt.AttributeId and adt.LanguageId=@language and adt.ProductId = @id
		 left join AttributeValueDecimals ad on a.Id = ad.AttributeId and ad.LanguageId=@language and ad.ProductId = @id
		 left join AttributeValueVarchars avc on a.Id = avc.AttributeId and avc.LanguageId=@language and avc.ProductId =@id 

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Product_ById]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Get_Product_ById]
	-- Add the parameters for the stored procedure here
	@id int,
	@language varchar(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
		p.Id,
		p.Sku,
		p.Price,
		p.DiscountPrice,
		p.ImageUrl,
		p.CreatedAt,
		p.IsActive,
		p.ViewCount,
		pt.Name,
		pt.Content,
		pt.Description,
		pt.SeoDescription,
		pt.SeoAlias,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId
	from Products p inner join ProductTranslations pt on p.Id=pt.ProductId
	where Id=@id and pt.LanguageId=@language
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Roll_AllPaging]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Roll_AllPaging] 
	-- Add the parameters for the stored procedure here
	@keyword nvarchar(50),
	@pageIndex int,
	@pageSize int,
	@totalRow int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--offset bỏ qua bao nhieu rows ko lấy
	-- fetch next --chỉ lấy số lượng dòng @pageSize tiếp theo 
	select @totalRow = count(*) from AspNetRoles r 
	where (@keyword is null or r.Name like @keyword +'%')

	select 
		Id,
		Name,
		NormalizedName
	from AspNetRoles r 
	where (@keyword is null or r.Name like @keyword +'%')
	order by r.Name
	OFFSET (@pageIndex - 1) * @pageSize rows 
	fetch next @pageSize row only 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_User_AllPaging]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_User_AllPaging] 
	-- Add the parameters for the stored procedure here
	@keyword nvarchar(50),
	@pageIndex int,
	@pageSize int,
	@totalRow int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--offset bỏ qua bao nhieu rows ko lấy
	-- fetch next --chỉ lấy số lượng dòng @pageSize tiếp theo 
	select @totalRow = count(*) from AspNetUsers r 
	where (@keyword is null or r.FullName like @keyword +'%' or r.UserName like @keyword +'%')

	select 
		Id,
		UserName,
		Email,
		PhoneNumber,
		FullName,
		Address
	from AspNetUsers r 
	where (@keyword is null or r.FullName like @keyword +'%' or r.UserName like @keyword +'%')
	order by r.FullName
	OFFSET (@pageIndex - 1) * @pageSize rows 
	fetch next @pageSize row only 
END
GO
/****** Object:  StoredProcedure [dbo].[Search_Product_ByAttributes]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Search_Product_ByAttributes] 
	@keyword nvarchar(50),
	@categoryId int,
	@pageIndex int,
	@pageSize int,
	@language varchar(5),
	@size varchar(10),
	@totalRow int output

AS
BEGIN
	SET NOCOUNT ON;
	declare @tblProductIds  table(Id int)

	insert into @tblProductIds
	select avv.ProductId from Attributes a inner join AttributeValueVarchars avv
	on a.Id = avv.AttributeId and a.Code ='kich-thuoc'
	where avv.Value = @size
 
	
	select @totalRow = count(*) from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId 
	inner join @tblProductIds tpi on p.Id = tpi.Id
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on c.Id = pic.CategoryId
	where (@keyword is null or p.Sku like @keyword +'%')
	and pt.LanguageId = @language
	and p.IsActive = 1
	and (@categoryId is null or @categoryId = 0 or pic.CategoryId = @categoryId)

	select p.Id,
		p.Sku,
		p.Price,
		p.DiscountPrice,
		p.ImageUrl,
		p.CreatedAt,
		p.IsActive,
		p.ViewCount,
		pt.Name,
		pt.Content,
		pt.Description,
		pt.SeoAlias,
		pt.SeoDescription,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId,
		c.Name as CategoryName
	from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId 
	inner join @tblProductIds tpi on p.Id = tpi.Id
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on c.Id = pic.CategoryId
	where (@keyword is null or p.Sku like @keyword +'%')
	and pt.LanguageId = @language
	and p.IsActive = 1
	and (@categoryId is null or @categoryId = 0 or pic.CategoryId = @categoryId)
	order by p.CreatedAt desc
	offset (@pageIndex - 1) * @pageSize rows
	fetch next @pageSize row only
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[Update_Attribute]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Update_Attribute]
	@id int,
	@name nvarchar(255),
	@sortOrder int,
	@backendType varchar(50),
	@isActive bit,
	@hasOption bit,
	@language varchar(5),
	@values nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	  --Insert attribute
		update Attributes set 
			Name = @name,
			SortOrder = @sortOrder,
			BackendType = BackendType,
			@isActive = @isActive
		where Id = @id
		--Insert options
		if @hasOption = 1
			begin
				declare @optionId int
				if not exists (select 1 from AttributeOptions where AttributeId=@id)
					begin
						insert into AttributeOptions(AttributeId,SortOrder) values(@id,1)
						select @optionId = SCOPE_IDENTITY()
					end
				else
					begin
						select @optionId = Id from AttributeOptions where AttributeId = @id
					end
				--delete old option values
				delete from AttributeOptionValues where OptionId = @optionId
				--Insert option values
				declare @valueTbl table(Data nvarchar(255))
				insert into @valueTbl(Data)
				select * from dbo.ufn_CSVToTable(@values,',')

				insert into AttributeOptionValues(OptionId,Value,LanguageId)
				select @optionId,*,@language from @valueTbl
			end
		else
			begin
				delete from AttributeOptionValues where OptionId 
							in (select Id from AttributeOptions where AttributeId = @id) 
				delete from AttributeOptions where AttributeId = @id

			end

	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch



  
END
GO
/****** Object:  StoredProcedure [dbo].[Update_Function]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Update_Function]
	-- Add the parameters for the stored procedure here	
	@id varchar(50),
	@name nvarchar(50),
	@url nvarchar(50),
	@parentId varchar(50),
	@sortOrder int,
	@cssClass nvarchar(50),
	@isActive bit
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;

    -- Insert statements for procedure here
	begin tran
		begin try
			update Functions set Name=@name, Url=@url, ParentId=@parentId, SortOrder=@sortOrder, CssClass=@cssClass, IsActive=@isActive
			where Id=@id
			
	commit
	end try
	begin catch
		rollback
		Declare @ErrorMessage varchar(2000)
		Select @ErrorMessage = 'Lỗi' + ERROR_MESSAGE()
		Raiserror(@ErrorMessage,16,1)
	end catch
	
END
GO
/****** Object:  StoredProcedure [dbo].[Update_Product]    Script Date: 19/11/2021 10:13:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
CREATE PROCEDURE [dbo].[Update_Product]
	-- Add the parameters for the stored procedure here	
	@id int,
	@name nvarchar(255),
	@description nvarchar(255),
	@content ntext,
	@seoDescription nvarchar(255),
	@seoAlias nvarchar(255),
	@seoTitle nvarchar(255),
	@seoKeyword nvarchar(255),
	@sku varchar(50),
	@price float,
	@isActive bit,
	@imageUrl nvarchar(255),
	@language varchar(5),
	@categoryIds varchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;

    -- Insert statements for procedure here
	begin tran
		begin try
			update Products set Sku=@sku, Price=@price, IsActive = @isActive,ImageUrl=@imageUrl
			where Id=@id
			update ProductTranslations set Content=@content, Name=@name, Description=@description, SeoDescription=@seoDescription,
			SeoAlias=@seoAlias, SeoTitle=@seoTitle, SeoKeyword=@seoKeyword
			where ProductId=@id and LanguageId=@language
			insert into ProductInCategories
				select @id as ProductId , cast(String as int) as CategoryId from ufn_CSVToTable(@categoryIds,',')
	commit
	end try
	begin catch
		rollback
		Declare @ErrorMessage varchar(2000)
		Select @ErrorMessage = 'Lỗi' + ERROR_MESSAGE()
		Raiserror(@ErrorMessage,16,1)
	end catch
	
END
GO
USE [master]
GO
ALTER DATABASE [RestAPIDapper2] SET  READ_WRITE 
GO

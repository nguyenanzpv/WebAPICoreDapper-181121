USE [master]
GO
/****** Object:  Database [RestAPIDapper2]    Script Date: 15/11/2021 3:11:41 PM ******/
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
/****** Object:  Table [dbo].[Attributes]    Script Date: 15/11/2021 3:11:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[SortOrder] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValues]    Script Date: 15/11/2021 3:11:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NOT NULL,
	[Value] [nvarchar](250) NULL,
 CONSTRAINT [PK_AttributeValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 15/11/2021 3:11:41 PM ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 15/11/2021 3:11:41 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 15/11/2021 3:11:41 PM ******/
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
/****** Object:  Table [dbo].[ProductAttibutes]    Script Date: 15/11/2021 3:11:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttibutes](
	[ProductId] [int] NOT NULL,
	[AttributeValueId] [int] NOT NULL,
 CONSTRAINT [PK_ProductAttibutes] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[AttributeValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductInCategories]    Script Date: 15/11/2021 3:11:41 PM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 15/11/2021 3:11:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Content] [ntext] NULL,
	[Sku] [varchar](50) NOT NULL,
	[Price] [float] NOT NULL,
	[DiscountPrice] [float] NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[ImageList] [nvarchar](max) NULL,
	[ViewCount] [int] NULL,
	[SeoAlias] [varchar](255) NULL,
	[SeoTitle] [nvarchar](255) NULL,
	[SeoKeyword] [nvarchar](255) NULL,
	[SeoDescription] [nvarchar](255) NULL,
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
SET IDENTITY_INSERT [dbo].[Attributes] ON 

INSERT [dbo].[Attributes] ([Id], [Code], [Name], [SortOrder], [IsActive]) VALUES (1, N'chatlieu', N'Chất liệu', 1, 1)
SET IDENTITY_INSERT [dbo].[Attributes] OFF
SET IDENTITY_INSERT [dbo].[AttributeValues] ON 

INSERT [dbo].[AttributeValues] ([Id], [AttributeId], [Value]) VALUES (1, 1, N'Cotton')
INSERT [dbo].[AttributeValues] ([Id], [AttributeId], [Value]) VALUES (2, 1, N'Thun')
INSERT [dbo].[AttributeValues] ([Id], [AttributeId], [Value]) VALUES (3, 1, N'Lụa')
SET IDENTITY_INSERT [dbo].[AttributeValues] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [SeoAlias], [SeoTitle], [SeoKeyword], [SeoDescription], [ParentId], [SortOrder], [IsActive]) VALUES (1, N'Áo phông nam', N'ao-phong-nam', N'ao-phong', N'ao-phong-nam', N'áo phông nam 2021', 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[ProductAttibutes] ([ProductId], [AttributeValueId]) VALUES (1, 1)
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Description], [Content], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [SeoAlias], [SeoTitle], [SeoKeyword], [SeoDescription], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (1, N'Áo phông cá sấu', N'Áo phông cá sấu mô tả', N'nội dung mô tả', N'AN-2018-01-0001', 120000, NULL, N'/images/aophong.jpg', NULL, NULL, N'ao-phong-ca-sau', N'Áo phông cá sấu cho nam', N'áo phông', N'Áo phông cá sấu cho nam', CAST(N'2018-12-12T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[AttributeValues]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValues_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeValues] CHECK CONSTRAINT [FK_AttributeValues_Attributes]
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
ALTER TABLE [dbo].[ProductAttibutes]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttibutes_AttributeValues] FOREIGN KEY([AttributeValueId])
REFERENCES [dbo].[AttributeValues] ([Id])
GO
ALTER TABLE [dbo].[ProductAttibutes] CHECK CONSTRAINT [FK_ProductAttibutes_AttributeValues]
GO
ALTER TABLE [dbo].[ProductAttibutes]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttibutes_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductAttibutes] CHECK CONSTRAINT [FK_ProductAttibutes_Products]
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
USE [master]
GO
ALTER DATABASE [RestAPIDapper2] SET  READ_WRITE 
GO

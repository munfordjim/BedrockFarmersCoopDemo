/****** Object:  Table [dbo].[bfc_Address]    Script Date: 10/19/2022 1:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bfc_Address](
	[AddrID] [int] NOT NULL,
	[AddressLine1] [varchar](100) NULL,
	[City] [varchar](100) NULL,
	[State] [varchar](100) NULL,
	[Zip] [varchar](100) NULL,
 CONSTRAINT [PK_bfc_Address] PRIMARY KEY CLUSTERED 
(
	[AddrID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bfc_Farmer]    Script Date: 10/19/2022 1:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bfc_Farmer](
	[FarmerID] [int] NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[EmailAddress] [varchar](100) NULL,
	[PhoneNumber] [varchar](100) NULL,
 CONSTRAINT [PK_bfc_Farmer] PRIMARY KEY CLUSTERED 
(
	[FarmerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bfc_Farmer_Address_Map]    Script Date: 10/19/2022 1:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bfc_Farmer_Address_Map](
	[FarmerID] [int] NOT NULL,
	[AddrID] [int] NOT NULL,
 CONSTRAINT [PK_bfc_Farmer_Address_Map] PRIMARY KEY CLUSTERED 
(
	[FarmerID] ASC,
	[AddrID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

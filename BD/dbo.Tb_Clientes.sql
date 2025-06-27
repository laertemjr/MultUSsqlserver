USE [dbMultUS]
GO

/****** Object:  Table [dbo].[Tb_Clientes]    Script Date: 15/05/2025 20:35:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tb_Clientes](
	[Cliente_ID] [int] IDENTITY(1,1) NOT NULL,
	[Cliente_NomeCompleto] [nchar](40) NOT NULL,
	[Cliente_Email] [nchar](40) NULL,
	[Cliente_Celular] [nchar](11) NULL,
 CONSTRAINT [PK_TbClientes] PRIMARY KEY CLUSTERED 
(
	[Cliente_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


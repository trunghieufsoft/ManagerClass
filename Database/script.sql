USE [StudentDataEF]
GO
/****** Object:  Trigger [TG_Update_Students]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TRIGGER [dbo].[TG_Update_Students]
GO
/****** Object:  Trigger [TG_Update_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TRIGGER [dbo].[TG_Update_StudentClass]
GO
/****** Object:  Trigger [TG_Insert_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TRIGGER [dbo].[TG_Insert_StudentClass]
GO
/****** Object:  Trigger [TG_Delete_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TRIGGER [dbo].[TG_Delete_StudentClass]
GO
/****** Object:  Trigger [TG_Update_Classes]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TRIGGER [dbo].[TG_Update_Classes]
GO
/****** Object:  StoredProcedure [dbo].[MP_User_Login]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP PROCEDURE [dbo].[MP_User_Login]
GO
/****** Object:  StoredProcedure [dbo].[MP_GetNot_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP PROCEDURE [dbo].[MP_GetNot_StudentClass]
GO
/****** Object:  StoredProcedure [dbo].[MP_GetNot_ClassStudent]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP PROCEDURE [dbo].[MP_GetNot_ClassStudent]
GO
ALTER TABLE [dbo].[StudentClass] DROP CONSTRAINT [FK_StudentClass_Students]
GO
ALTER TABLE [dbo].[StudentClass] DROP CONSTRAINT [FK_StudentClass_Classes]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF_Users_isActive]
GO
ALTER TABLE [dbo].[Students] DROP CONSTRAINT [DF__Students__Update__403A8C7D]
GO
ALTER TABLE [dbo].[Students] DROP CONSTRAINT [DF__Students__Create__3F466844]
GO
ALTER TABLE [dbo].[Students] DROP CONSTRAINT [DF_Students_Phone]
GO
ALTER TABLE [dbo].[Students] DROP CONSTRAINT [DF_Students_BirthDay]
GO
ALTER TABLE [dbo].[Students] DROP CONSTRAINT [DF_Students_Gender]
GO
ALTER TABLE [dbo].[StudentClass] DROP CONSTRAINT [DF__StudentCl__Updat__3E52440B]
GO
ALTER TABLE [dbo].[StudentClass] DROP CONSTRAINT [DF__StudentCl__Creat__3D5E1FD2]
GO
ALTER TABLE [dbo].[Classes] DROP CONSTRAINT [DF__Classes__UpdateA__4222D4EF]
GO
ALTER TABLE [dbo].[Classes] DROP CONSTRAINT [DF__Classes__CreateA__412EB0B6]
GO
ALTER TABLE [dbo].[Classes] DROP CONSTRAINT [DF__Classes__StudTot__48CFD27E]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TABLE [dbo].[Students]
GO
/****** Object:  Table [dbo].[StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TABLE [dbo].[StudentClass]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 8/28/2018 12:36:09 PM ******/
DROP TABLE [dbo].[Classes]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassId] [varchar](20) NOT NULL,
	[ClassName] [nvarchar](50) NOT NULL,
	[StudTotal] [int] NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[UpdateAt] [datetime] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentClass](
	[ClassId] [varchar](20) NOT NULL,
	[StudId] [varchar](20) NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[UpdateAt] [datetime] NOT NULL,
 CONSTRAINT [PK_StudentClass] PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC,
	[StudId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Students]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Students](
	[StudId] [varchar](20) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Gender] [bit] NOT NULL,
	[BirthDay] [date] NOT NULL,
	[Address] [ntext] NULL,
	[Phone] [varchar](12) NULL,
	[CreateAt] [datetime] NOT NULL,
	[UpdateAt] [datetime] NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[StudId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [nvarchar](150) NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [StudTotal], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'Advance SQL', 7, CAST(N'2018-08-17T16:10:04.057' AS DateTime), CAST(N'2018-08-28T11:14:30.123' AS DateTime))
INSERT [dbo].[Classes] ([ClassId], [ClassName], [StudTotal], [CreateAt], [UpdateAt]) VALUES (N'ATNB', N'ASP .NET MVC', 1, CAST(N'2018-08-17T16:10:04.057' AS DateTime), CAST(N'2018-08-28T00:08:09.270' AS DateTime))
INSERT [dbo].[Classes] ([ClassId], [ClassName], [StudTotal], [CreateAt], [UpdateAt]) VALUES (N'BTNB', N'Lập trình C# .NET Base ', 3, CAST(N'2018-08-17T16:10:04.057' AS DateTime), CAST(N'2018-08-27T14:01:36.583' AS DateTime))
INSERT [dbo].[Classes] ([ClassId], [ClassName], [StudTotal], [CreateAt], [UpdateAt]) VALUES (N'EF', N'Entity Framework', 2, CAST(N'2018-08-17T16:10:04.057' AS DateTime), CAST(N'2018-08-28T10:16:14.360' AS DateTime))
INSERT [dbo].[Classes] ([ClassId], [ClassName], [StudTotal], [CreateAt], [UpdateAt]) VALUES (N'Linq', N'Query Linq Lambda', 4, CAST(N'2018-08-17T16:10:04.057' AS DateTime), CAST(N'2018-08-28T12:06:18.507' AS DateTime))
INSERT [dbo].[Classes] ([ClassId], [ClassName], [StudTotal], [CreateAt], [UpdateAt]) VALUES (N'SQL', N'MS SQL Syntax', 1, CAST(N'2018-08-24T16:48:19.597' AS DateTime), CAST(N'2018-08-27T14:01:49.760' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'AnNQH', CAST(N'2018-08-27T23:02:05.957' AS DateTime), CAST(N'2018-08-27T23:02:05.957' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'BacND', CAST(N'2018-08-28T00:09:12.860' AS DateTime), CAST(N'2018-08-28T00:09:12.860' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'BaoLQ', CAST(N'2018-08-28T00:09:15.290' AS DateTime), CAST(N'2018-08-28T00:09:15.290' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'ChienTV', CAST(N'2018-08-28T00:09:17.813' AS DateTime), CAST(N'2018-08-28T00:09:17.813' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'CuongLQ', CAST(N'2018-08-28T00:08:38.443' AS DateTime), CAST(N'2018-08-28T00:08:38.443' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'DanhDX', CAST(N'2018-08-28T00:09:37.280' AS DateTime), CAST(N'2018-08-28T00:09:37.280' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ASQL', N'HieuLT22', CAST(N'2018-08-27T14:00:25.187' AS DateTime), CAST(N'2018-08-27T14:00:25.187' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'ATNB', N'AnNQH', CAST(N'2018-08-28T00:08:09.110' AS DateTime), CAST(N'2018-08-28T00:08:09.110' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'BTNB', N'BacND', CAST(N'2018-08-27T14:01:26.373' AS DateTime), CAST(N'2018-08-27T14:01:26.373' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'BTNB', N'CuongLQ', CAST(N'2018-08-27T14:01:16.407' AS DateTime), CAST(N'2018-08-27T14:01:16.407' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'BTNB', N'DungLTH', CAST(N'2018-08-27T14:01:36.583' AS DateTime), CAST(N'2018-08-27T14:01:36.583' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'EF', N'ChungHTM', CAST(N'2018-08-28T00:09:00.057' AS DateTime), CAST(N'2018-08-28T10:16:13.647' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'EF', N'HieuLT22', CAST(N'2018-08-27T14:00:16.187' AS DateTime), CAST(N'2018-08-27T14:00:16.187' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'Linq', N'AnNQH', CAST(N'2018-08-28T12:06:18.313' AS DateTime), CAST(N'2018-08-28T12:06:18.313' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'Linq', N'BacND', CAST(N'2018-08-27T14:00:39.943' AS DateTime), CAST(N'2018-08-27T14:00:39.943' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'Linq', N'DungLTH', CAST(N'2018-08-27T14:00:50.370' AS DateTime), CAST(N'2018-08-27T14:00:50.370' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'Linq', N'HieuLT22', CAST(N'2018-08-27T14:00:57.227' AS DateTime), CAST(N'2018-08-27T14:00:57.227' AS DateTime))
INSERT [dbo].[StudentClass] ([ClassId], [StudId], [CreateAt], [UpdateAt]) VALUES (N'SQL', N'DuyenTTK', CAST(N'2018-08-27T14:01:49.760' AS DateTime), CAST(N'2018-08-27T14:01:49.760' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'AnNQH', N'Nguyễn Quốc Hồng Ân', 1, CAST(N'1997-03-20' AS Date), N'Tiền Giang', N'09xxx', CAST(N'2018-08-23T08:43:44.187' AS DateTime), CAST(N'2018-08-23T08:43:44.187' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'BacND', N'Nguyễn Đình Bắc', 1, CAST(N'1995-09-27' AS Date), N'Nghệ An', N'09xxx', CAST(N'2018-08-23T08:45:22.793' AS DateTime), CAST(N'2018-08-23T08:45:22.793' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'BaoLQ', N'Lưu Bảo Bảo', 1, CAST(N'1997-12-15' AS Date), N'Tây Ninh', N'09xxx', CAST(N'2018-08-23T08:44:28.523' AS DateTime), CAST(N'2018-08-23T08:44:28.523' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'ChienTV', N'
Trình Văn Chiến', 1, CAST(N'1997-09-12' AS Date), N'Quảng Bình', N'09xxx', CAST(N'2018-08-23T08:46:18.703' AS DateTime), CAST(N'2018-08-23T08:46:18.703' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'ChungHTM', N'Huỳnh Thị Mộng Chung', 0, CAST(N'1997-03-20' AS Date), N'Bình Định', N'09xxx', CAST(N'2018-08-23T08:50:22.577' AS DateTime), CAST(N'2018-08-23T08:50:22.577' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'CuongLQ', N'Lê Quốc Cường', 1, CAST(N'1997-07-31' AS Date), N'TP.Hồ Chí Minh', N'09xxx', CAST(N'2018-08-23T08:46:59.690' AS DateTime), CAST(N'2018-08-23T08:48:36.790' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'DanhDX', N'Đào Xuân Danh', 1, CAST(N'1997-04-16' AS Date), N'Lâm Đồng', N'09xxx', CAST(N'2018-08-23T08:47:36.833' AS DateTime), CAST(N'2018-08-23T08:47:36.833' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'DungLTH', N'Lê Đoàn Hữu Dũng', 1, CAST(N'1997-07-03' AS Date), N'TP.Hồ Chí Minh', N'09xxx', CAST(N'2018-08-23T08:48:30.480' AS DateTime), CAST(N'2018-08-23T08:48:30.480' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'DungQTH', N'Quách Thị Hoàng Dung', 0, CAST(N'1997-07-02' AS Date), N'Bình Định', N'09xxx', CAST(N'2018-08-23T08:49:44.073' AS DateTime), CAST(N'2018-08-23T08:49:44.073' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'DuyenTTK', N'Trần Thị Kiều Duyên', 0, CAST(N'1997-06-16' AS Date), N'Ninh Thuận', N'09xxx', CAST(N'2018-08-23T08:51:05.033' AS DateTime), CAST(N'2018-08-23T08:51:05.033' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'HanhNTX', N'Nguyễn Thị Xuân Hạnh', 0, CAST(N'1996-06-02' AS Date), N'Đồng Tháp', N'09xxx', CAST(N'2018-08-23T08:51:58.253' AS DateTime), CAST(N'2018-08-23T08:51:58.253' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'HieuLT22', N'Lương Trung Hiếu', 1, CAST(N'1996-07-26' AS Date), N'Ninh Bình', N'01644158136', CAST(N'2018-08-17T16:09:49.730' AS DateTime), CAST(N'2018-08-23T08:44:36.807' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'PhatNT10', N'Nguyễn Tấn Phát', 1, CAST(N'1996-01-16' AS Date), NULL, N'09xxx', CAST(N'2018-08-28T00:16:08.637' AS DateTime), CAST(N'2018-08-28T00:16:08.637' AS DateTime))
INSERT [dbo].[Students] ([StudId], [FullName], [Gender], [BirthDay], [Address], [Phone], [CreateAt], [UpdateAt]) VALUES (N'VuongPB', N'Phan Bá Vương', 1, CAST(N'1997-06-16' AS Date), N'Ninh Thuận', N'09xxx', CAST(N'2018-08-23T08:52:48.790' AS DateTime), CAST(N'2018-08-23T08:52:48.790' AS DateTime))
INSERT [dbo].[Users] ([UserName], [Password], [Email], [isActive]) VALUES (N'admin', N'qUQ7wmi+mxs0eqwIf5wtlA==', N'trunghieu.student.it@gmail.com', 1)
INSERT [dbo].[Users] ([UserName], [Password], [Email], [isActive]) VALUES (N'HieuLT22', N'Ft/bn4ldjos=', N'HieuLT22@fsoft.com', 0)
ALTER TABLE [dbo].[Classes] ADD  DEFAULT ((0)) FOR [StudTotal]
GO
ALTER TABLE [dbo].[Classes] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[Classes] ADD  DEFAULT (getdate()) FOR [UpdateAt]
GO
ALTER TABLE [dbo].[StudentClass] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[StudentClass] ADD  DEFAULT (getdate()) FOR [UpdateAt]
GO
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [DF_Students_Gender]  DEFAULT ((1)) FOR [Gender]
GO
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [DF_Students_BirthDay]  DEFAULT (getdate()) FOR [BirthDay]
GO
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [DF_Students_Phone]  DEFAULT ('09xxx') FOR [Phone]
GO
ALTER TABLE [dbo].[Students] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[Students] ADD  DEFAULT (getdate()) FOR [UpdateAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[StudentClass]  WITH CHECK ADD  CONSTRAINT [FK_StudentClass_Classes] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([ClassId])
GO
ALTER TABLE [dbo].[StudentClass] CHECK CONSTRAINT [FK_StudentClass_Classes]
GO
ALTER TABLE [dbo].[StudentClass]  WITH CHECK ADD  CONSTRAINT [FK_StudentClass_Students] FOREIGN KEY([StudId])
REFERENCES [dbo].[Students] ([StudId])
GO
ALTER TABLE [dbo].[StudentClass] CHECK CONSTRAINT [FK_StudentClass_Students]
GO
/****** Object:  StoredProcedure [dbo].[MP_GetNot_ClassStudent]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[MP_GetNot_ClassStudent]
	-- Add the parameters for the stored procedure here
	@studId varchar(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * From Classes
	Where ClassId Not In 
		(Select ClassId From StudentClass
		Where StudId = @studId)
END



GO
/****** Object:  StoredProcedure [dbo].[MP_GetNot_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MP_GetNot_StudentClass]
	-- Add the parameters for the stored procedure here
	@classId varchar(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * From Students
	Where StudId Not In 
		(Select StudId From StudentClass
		Where ClassId = @classId)
END


GO
/****** Object:  StoredProcedure [dbo].[MP_User_Login]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MP_User_Login] 
	-- Add the parameters for the stored procedure here
	@uname varchar(50),
	@passwd varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @count int
	declare @res bit
	select @count = count(*) from Users u where u.UserName = @uname and u.Password = @passwd
	if @count > 0
		set @res = 1
	else set @res = 0
	select @res
END




GO
/****** Object:  Trigger [dbo].[TG_Update_Classes]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TG_Update_Classes]
   ON [dbo].[Classes]
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	
	DECLARE @classId VARCHAR(20)
	SET @classId = (SELECT ClassId FROM inserted)
	
	UPDATE Classes SET UpdateAt = GETDATE() WHERE ClassId = @classId;
END

GO
ALTER TABLE [dbo].[Classes] ENABLE TRIGGER [TG_Update_Classes]
GO
/****** Object:  Trigger [dbo].[TG_Delete_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TG_Delete_StudentClass]
   ON [dbo].[StudentClass]
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @classId VARCHAR(20), @totalStud TINYINT
	SET @classId = (SELECT ClassId FROM deleted)
	SET @totalStud = (SELECT StudTotal FROM Classes WHERE ClassId = @classId)

	UPDATE Classes SET StudTotal = @totalStud - 1 WHERE ClassId = @classId;

END

GO
ALTER TABLE [dbo].[StudentClass] ENABLE TRIGGER [TG_Delete_StudentClass]
GO
/****** Object:  Trigger [dbo].[TG_Insert_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lương Trung Hiếu
-- Create date: 17/8/2018
-- Description:	
-- =============================================

CREATE TRIGGER [dbo].[TG_Insert_StudentClass]
   ON [dbo].[StudentClass]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @classId VARCHAR(20), @totalStud TINYINT
	SET @classId = (SELECT ClassId FROM inserted)
	SET @totalStud = (SELECT StudTotal FROM Classes WHERE ClassId = @classId)

	UPDATE Classes SET StudTotal = @totalStud + 1 WHERE ClassId = @classId;

END

GO
ALTER TABLE [dbo].[StudentClass] ENABLE TRIGGER [TG_Insert_StudentClass]
GO
/****** Object:  Trigger [dbo].[TG_Update_StudentClass]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TG_Update_StudentClass]
   ON [dbo].[StudentClass]
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	
	DECLARE @new_classId VARCHAR(20)
	SET @new_classId = (SELECT ClassId FROM inserted)
	
	UPDATE StudentClass SET UpdateAt = GETDATE() WHERE ClassId = @new_classId;

	IF UPDATE(ClassId)
	BEGIN
		DECLARE @old_classId VARCHAR(20), @new_totalStud TINYINT, @old_totalStud TINYINT
		SET @old_classId = (SELECT ClassId FROM deleted)
		
		SET @old_totalStud = (SELECT StudTotal FROM Classes WHERE ClassId = @old_classId)
		SET @new_totalStud = (SELECT StudTotal FROM Classes WHERE ClassId = @new_classId)

		UPDATE Classes SET StudTotal = @new_totalStud + 1 WHERE ClassId = @new_classId;
		UPDATE Classes SET StudTotal = @old_totalStud - 1 WHERE ClassId = @old_classId;

		UPDATE Classes SET UpdateAt = GETDATE() WHERE ClassId = @new_classId;
	END
END

GO
ALTER TABLE [dbo].[StudentClass] ENABLE TRIGGER [TG_Update_StudentClass]
GO
/****** Object:  Trigger [dbo].[TG_Update_Students]    Script Date: 8/28/2018 12:36:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TG_Update_Students]
   ON [dbo].[Students]
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	
	DECLARE @studId VARCHAR(20)
	SET @studId = (SELECT StudId FROM inserted)
	
	UPDATE Students SET UpdateAt = GETDATE() WHERE StudId = @studId;
END

GO
ALTER TABLE [dbo].[Students] ENABLE TRIGGER [TG_Update_Students]
GO

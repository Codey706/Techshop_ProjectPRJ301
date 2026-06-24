/*******************************************************************************
   MIRAI STORE DATABASE SYSTEM - VERSION 1.0 (CORE & CLEAN EDITION)
   Script: MiraiStore_SqlServer_Core_v1.sql
   Project Manager: Huynh Nhu Y
********************************************************************************/

-- Check if the old database exists; if so, disconnect instantly and drop it to re-initialize
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'MiraiStoreDB')
BEGIN
    ALTER DATABASE [MiraiStoreDB] SET OFFLINE WITH ROLLBACK IMMEDIATE;
    ALTER DATABASE [MiraiStoreDB] SET ONLINE;
    DROP DATABASE [MiraiStoreDB];
END
GO

CREATE DATABASE [MiraiStoreDB];
GO

USE [MiraiStoreDB];
GO

/*******************************************************************************
   1. SYSTEM, USER MANAGEMENT & AUDITING TABLES
********************************************************************************/

CREATE TABLE [dbo].[Roles]
(
    [RoleId] INT NOT NULL IDENTITY(1,1),
    [RoleName] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleId]),
    CONSTRAINT [UQ_Roles_RoleName] UNIQUE ([RoleName])
);
GO

CREATE TABLE [dbo].[Users]
(
    [UserId] INT NOT NULL IDENTITY(1,1),
    [RoleId] INT NOT NULL,
    [Username] VARCHAR(50) NOT NULL,
    [Password] VARCHAR(500) NOT NULL,
    [PasswordSalt] VARCHAR(100) NULL,
    [FullName] NVARCHAR(100) NOT NULL,
    [Email] VARCHAR(100) NOT NULL,
    [Phone] VARCHAR(15) NULL,
    [Gender] NVARCHAR(10) NULL,
    [DateOfBirth] DATE NULL,
    [Avatar] NVARCHAR(255) NULL DEFAULT 'default-avatar.png',
    [EmailVerified] BIT NOT NULL DEFAULT 0,
    [VerifyToken] VARCHAR(100) NULL,
    [ResetToken] VARCHAR(100) NULL,
    [ResetTokenExpiry] DATETIME NULL,
    [FailedLoginAttempts] INT NOT NULL DEFAULT 0,
    [LockedUntil] DATETIME NULL,
    [Status] BIT NOT NULL DEFAULT 1,
    [LastLogin] DATETIME NULL,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [RememberMeToken] VARCHAR(255) NULL,

    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId]),
    CONSTRAINT [UQ_Users_Username] UNIQUE ([Username]),
    CONSTRAINT [UQ_Users_Email] UNIQUE ([Email]),
    CONSTRAINT [CK_Users_Gender] CHECK ([Gender] IN (N'Nam', N'Nữ', N'Khác'))
);
GO

CREATE TABLE [dbo].[LoginHistory]
(
    [LoginId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,
    [IPAddress] VARCHAR(45) NULL,
    [Browser] NVARCHAR(255) NULL,
    [IsSuccess] BIT NOT NULL DEFAULT 1,
    [LoginTime] DATETIME NOT NULL DEFAULT GETDATE(),
    [LogoutTime] DATETIME NULL,
    CONSTRAINT [PK_LoginHistory] PRIMARY KEY CLUSTERED ([LoginId])
);
GO

CREATE TABLE [dbo].[AuditLogs]
(
    [LogId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NULL,
    [Action] NVARCHAR(50) NOT NULL,
    [TableName] VARCHAR(100) NOT NULL,
    [RecordId] INT NOT NULL,
    [OldValue] NVARCHAR(MAX) NULL,
    [NewValue] NVARCHAR(MAX) NULL,
    [IPAddress] VARCHAR(45) NULL,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED ([LogId])
);
GO

CREATE TABLE [dbo].[Addresses]
(
    [AddressId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,
    [ReceiverName] NVARCHAR(100) NOT NULL,
    [Phone] VARCHAR(15) NOT NULL,
    [Province] NVARCHAR(100) NOT NULL,
    [District] NVARCHAR(100) NOT NULL,
    [Ward] NVARCHAR(100) NOT NULL,
    [Street] NVARCHAR(255) NOT NULL,
    [AddressType] NVARCHAR(50) NULL DEFAULT N'Home',
    [IsDefault] BIT NOT NULL DEFAULT 0,
    [Deleted] BIT NOT NULL DEFAULT 0,
    CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED ([AddressId]),
    CONSTRAINT [CK_Addresses_Type] CHECK ([AddressType] IN (N'Home', N'Office'))
);
GO

/*******************************************************************************
   2. PRODUCT CATALOG & VARIANT ARCHITECTURE
********************************************************************************/

CREATE TABLE [dbo].[Categories]
(
    [CategoryId] INT NOT NULL IDENTITY(1,1),
    [CategoryName] NVARCHAR(100) NOT NULL,
    [ImageURL] NVARCHAR(255) NULL,
    [Description] NVARCHAR(255) NULL,
    [Deleted] BIT NOT NULL DEFAULT 0,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryId]),
    CONSTRAINT [UQ_Categories_CategoryName] UNIQUE ([CategoryName])
);
GO

CREATE TABLE [dbo].[Brands]
(
    [BrandId] INT NOT NULL IDENTITY(1,1),
    [BrandName] NVARCHAR(100) NOT NULL,
    [Logo] NVARCHAR(255) NULL,
    [Country] NVARCHAR(50) NULL,
    [Description] NVARCHAR(MAX) NULL,
    [Status] BIT NOT NULL DEFAULT 1,
    [Deleted] BIT NOT NULL DEFAULT 0,
    CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED ([BrandId]),
    CONSTRAINT [UQ_Brands_BrandName] UNIQUE ([BrandName])
);
GO

CREATE TABLE [dbo].[SpecificationDefinitions]
(
    [SpecDefId] INT NOT NULL IDENTITY(1,1),
    [CategoryId] INT NOT NULL,
    [SpecName] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_SpecificationDefinitions] PRIMARY KEY CLUSTERED ([SpecDefId]),
    CONSTRAINT [UQ_Category_SpecDefName] UNIQUE ([CategoryId], [SpecName])
);
GO

CREATE TABLE [dbo].[Products]
(
    [ProductId] INT NOT NULL IDENTITY(1,1),
    [CategoryId] INT NOT NULL,
    [BrandId] INT NOT NULL,
    [BaseSKU] VARCHAR(50) NOT NULL,
    [ProductName] NVARCHAR(255) NOT NULL,
    [Slug] VARCHAR(255) NOT NULL,
    [Views] INT NOT NULL DEFAULT 0,
    [Sold] INT NOT NULL DEFAULT 0,
    [IsFeatured] BIT NOT NULL DEFAULT 0,
    [IsNew] BIT NOT NULL DEFAULT 1,
    [Deleted] BIT NOT NULL DEFAULT 0,
    [Status] INT NOT NULL DEFAULT 1,
    [Description] NVARCHAR(MAX) NULL,
    [CreatedBy] INT NULL,
    [PublishedAt] DATETIME NULL,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductId]),
    CONSTRAINT [UQ_Products_BaseSKU] UNIQUE ([BaseSKU]),
    CONSTRAINT [UQ_Products_Slug] UNIQUE ([Slug])
);
GO

CREATE TABLE [dbo].[ProductVariants]
(
    [VariantId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL,
    [VariantSKU] VARCHAR(50) NOT NULL,
    [VariantName] NVARCHAR(255) NOT NULL,
    [OriginalPrice] DECIMAL(18,2) NOT NULL,
    [Price] DECIMAL(18,2) NOT NULL,
    [DiscountPercent] INT NULL DEFAULT 0,
    [Stock] INT NOT NULL DEFAULT 0,
    [ImageUrl] NVARCHAR(255) NULL,
    [Status] NVARCHAR(20) NOT NULL DEFAULT N'Active',
    CONSTRAINT [PK_ProductVariants] PRIMARY KEY CLUSTERED ([VariantId]),
    CONSTRAINT [UQ_Variants_SKU] UNIQUE ([VariantSKU]),
    CONSTRAINT [CK_Variants_OriginalPrice] CHECK ([OriginalPrice] >= 0),
    CONSTRAINT [CK_Variants_Price] CHECK ([Price] >= 0),
    CONSTRAINT [CK_Variants_Stock] CHECK ([Stock] >= 0)
);
GO

CREATE TABLE [dbo].[InventoryHistory]
(
    [InventoryLogId] INT NOT NULL IDENTITY(1,1),
    [VariantId] INT NOT NULL,
    [Type] NVARCHAR(20) NOT NULL,
    [QuantityChanged] INT NOT NULL,
    [OldStock] INT NOT NULL,
    [NewStock] INT NOT NULL,
    [Reason] NVARCHAR(255) NULL,
    [CreatedBy] INT NULL,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_InventoryHistory] PRIMARY KEY CLUSTERED ([InventoryLogId])
);
GO

CREATE TABLE [dbo].[ProductSpecifications]
(
    [SpecId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL,
    [SpecDefId] INT NOT NULL,
    [SpecValue] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_ProductSpecifications] PRIMARY KEY CLUSTERED ([SpecId]),
    CONSTRAINT [UQ_Product_SpecDefId] UNIQUE ([ProductId], [SpecDefId])
);
GO

CREATE TABLE [dbo].[ProductImages]
(
    [ImageId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL,
    [ImageUrl] NVARCHAR(255) NOT NULL,
    [AltText] NVARCHAR(255) NULL,
    [DisplayOrder] INT NOT NULL DEFAULT 1,
    [IsThumbnail] BIT NOT NULL DEFAULT 0,
    [Deleted] BIT NOT NULL DEFAULT 0,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED ([ImageId])
);
GO

/*******************************************************************************
   3. CART, LOGISTICS & MARKETING SYSTEMS
********************************************************************************/

CREATE TABLE [dbo].[Cart]
(
    [CartId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(), 
    CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED ([CartId]),
    CONSTRAINT [UQ_Cart_UserId] UNIQUE ([UserId])
);
GO

CREATE TABLE [dbo].[CartItems]
(
    [CartItemId] INT NOT NULL IDENTITY(1,1),
    [CartId] INT NOT NULL,
    [VariantId] INT NOT NULL,
    [Quantity] INT NOT NULL DEFAULT 1,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(), 
    CONSTRAINT [PK_CartItems] PRIMARY KEY CLUSTERED ([CartItemId]),
    CONSTRAINT [UQ_CartItems_CartVariant] UNIQUE ([CartId], [VariantId])
);
GO

CREATE TABLE [dbo].[Vouchers]
(
    [VoucherId] INT NOT NULL IDENTITY(1,1),
    [Code] VARCHAR(50) NOT NULL,
    [DiscountPercent] DECIMAL(5,2) NOT NULL,
    [MinimumOrder] DECIMAL(18,2) NOT NULL DEFAULT 0,
    [StartDate] DATETIME NOT NULL DEFAULT GETDATE(),
    [ExpireDate] DATETIME NOT NULL,
    [Quantity] INT NOT NULL,
    [UsedQuantity] INT NOT NULL DEFAULT 0,
    [Status] INT NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Vouchers] PRIMARY KEY CLUSTERED ([VoucherId]),
    CONSTRAINT [UQ_Vouchers_Code] UNIQUE ([Code])
);
GO

CREATE TABLE [dbo].[UserVoucher]
(
    [UserVoucherId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,
    [VoucherId] INT NOT NULL,
    [UsedCount] INT NOT NULL DEFAULT 1,
    [LastUsedDate] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_UserVoucher] PRIMARY KEY CLUSTERED ([UserVoucherId]),
    CONSTRAINT [UQ_User_Voucher_Track] UNIQUE ([UserId], [VoucherId])
);
GO

CREATE TABLE [dbo].[ShippingProviders]
(
    [ProviderId] INT NOT NULL IDENTITY(1,1),
    [ProviderName] NVARCHAR(100) NOT NULL,
    [Phone] VARCHAR(15) NULL,
    [Status] BIT NOT NULL DEFAULT 1,
    [Deleted] BIT NOT NULL DEFAULT 0,
    CONSTRAINT [PK_ShippingProviders] PRIMARY KEY CLUSTERED ([ProviderId])
);
GO

CREATE TABLE [dbo].[Banners]
(
    [BannerId] INT NOT NULL IDENTITY(1,1),
    [Title] NVARCHAR(150) NOT NULL,
    [ImageURL] NVARCHAR(255) NOT NULL,
    [LinkURL] NVARCHAR(255) NULL,
    [DisplayOrder] INT NOT NULL DEFAULT 1,
    [Status] BIT NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Banners] PRIMARY KEY CLUSTERED ([BannerId])
);
GO

/*******************************************************************************
   4. SALES, ORDERS & PAYMENTS
********************************************************************************/

CREATE TABLE [dbo].[Orders]
(
    [OrderId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,
    [VoucherId] INT NULL,
    [ProviderId] INT NULL,
    [AddressId] INT NULL,
    [OrderDate] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [Subtotal] DECIMAL(18,2) NOT NULL DEFAULT 0,
    [ShippingFee] DECIMAL(18,2) NOT NULL DEFAULT 0,
    [DiscountAmount] DECIMAL(18,2) NOT NULL DEFAULT 0,
    [TotalAmount] DECIMAL(18, 2) NOT NULL,
    [ReceiverName] NVARCHAR(100) NOT NULL,
    [Phone] VARCHAR(15) NOT NULL,
    [ShippingAddress] NVARCHAR(500) NOT NULL,
    [Note] NVARCHAR(300) NULL,
    [Status] TINYINT NOT NULL DEFAULT 0, 
    [PaymentStatus] TINYINT NOT NULL DEFAULT 0, 
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderId])
);
GO

CREATE TABLE [dbo].[OrderDetails]
(
    [OrderDetailId] INT NOT NULL IDENTITY(1,1),
    [OrderId] INT NOT NULL,
    [VariantId] INT NOT NULL,
    [Quantity] INT NOT NULL,
    [UnitPrice] DECIMAL(18, 2) NOT NULL,
    [SnapProductName] NVARCHAR(255) NOT NULL,
    [SnapVariantName] NVARCHAR(255) NOT NULL,
    [SnapVariantSKU] VARCHAR(50) NOT NULL,
    [SnapImageUrl] NVARCHAR(255) NULL,
    [SnapBrandName] NVARCHAR(100) NULL,
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED ([OrderDetailId])
);
GO

CREATE TABLE [dbo].[Payments]
(
    [PaymentId] INT NOT NULL IDENTITY(1,1),
    [OrderId] INT NOT NULL,
    [PaymentMethod] NVARCHAR(50) NOT NULL,
    [Amount] DECIMAL(18, 2) NOT NULL,
    [Currency] VARCHAR(10) NOT NULL DEFAULT 'VND',
    [TransactionCode] VARCHAR(100) NULL,
    [GatewayTransactionId] VARCHAR(100) NULL,
    [BankCode] VARCHAR(20) NULL,
    [GatewayResponseCode] VARCHAR(10) NULL,
    [PaymentUrl] NVARCHAR(1000) NULL,
    [CallbackData] NVARCHAR(MAX) NULL,
    [SecureHash] VARCHAR(256) NULL,
    [PaidDate] DATETIME NULL,
    [ExpiredTime] DATETIME NULL,
    [Status] TINYINT NOT NULL DEFAULT 0,
    CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED ([PaymentId])
);
GO

/*******************************************************************************
   5. ENGAGEMENT, SEPARATED NOTIFICATIONS & BLOG TABLES
********************************************************************************/

CREATE TABLE [dbo].[NotificationTypes]
(
    [TypeId] INT NOT NULL IDENTITY(1,1),
    [TypeName] VARCHAR(50) NOT NULL,
    [Description] NVARCHAR(255) NULL,
    [Deleted] BIT NOT NULL DEFAULT 0,
    CONSTRAINT [PK_NotificationTypes] PRIMARY KEY CLUSTERED ([TypeId]),
    CONSTRAINT [UQ_NotificationTypes_Name] UNIQUE ([TypeName])
);
GO

CREATE TABLE [dbo].[Reviews]
(
    [ReviewId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [Title] NVARCHAR(100) NULL,
    [Rating] INT NOT NULL,
    [Comment] NVARCHAR(MAX) NULL,
    [VerifiedPurchase] BIT NOT NULL DEFAULT 0,
    [Status] BIT NOT NULL DEFAULT 1,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(), 
    CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED ([ReviewId]),
    CONSTRAINT [UQ_User_ProductReview] UNIQUE ([UserId], [ProductId])
);
GO

CREATE TABLE [dbo].[Wishlist]
(
    [WishlistId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,
    [ProductId] INT NOT NULL,
    CONSTRAINT [PK_Wishlist] PRIMARY KEY CLUSTERED ([WishlistId]),
    CONSTRAINT [UQ_Wishlist_UserProduct] UNIQUE ([UserId], [ProductId])
);
GO

CREATE TABLE [dbo].[Notifications]
(
    [NotificationId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,
    [NotificationTypeId] INT NOT NULL,
    [Title] NVARCHAR(150) NOT NULL,
    [Content] NVARCHAR(500) NOT NULL,
    [Link] NVARCHAR(255) NULL,
    [IsRead] BIT NOT NULL DEFAULT 0,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED ([NotificationId])
);
GO

/*******************************************************************************
   6. FOREIGN KEY CONSTRAINTS
********************************************************************************/
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_Users_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]);
ALTER TABLE [dbo].[LoginHistory] ADD CONSTRAINT [FK_LoginHistory_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[AuditLogs] ADD CONSTRAINT [FK_AuditLogs_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE SET NULL;
ALTER TABLE [dbo].[Addresses] ADD CONSTRAINT [FK_Addresses_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[SpecificationDefinitions] ADD CONSTRAINT [FK_SpecDef_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]);
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_Products_Brands] FOREIGN KEY ([BrandId]) REFERENCES [dbo].[Brands] ([BrandId]);
ALTER TABLE [dbo].[ProductVariants] ADD CONSTRAINT [FK_Variants_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[InventoryHistory] ADD CONSTRAINT [FK_Inventory_Variants] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[ProductVariants] ([VariantId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[ProductSpecifications] ADD CONSTRAINT [FK_ProductSpecs_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[ProductSpecifications] ADD CONSTRAINT [FK_ProductSpecs_Definitions] FOREIGN KEY ([SpecDefId]) REFERENCES [dbo].[SpecificationDefinitions] ([SpecDefId]);
ALTER TABLE [dbo].[ProductImages] ADD CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Cart] ADD CONSTRAINT [FK_Cart_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[CartItems] ADD CONSTRAINT [FK_CartItems_Cart] FOREIGN KEY ([CartId]) REFERENCES [dbo].[Cart] ([CartId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[CartItems] ADD CONSTRAINT [FK_CartItems_Variants] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[ProductVariants] ([VariantId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[UserVoucher] ADD CONSTRAINT [FK_UserVoucher_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[UserVoucher] ADD CONSTRAINT [FK_UserVoucher_Vouchers] FOREIGN KEY ([VoucherId]) REFERENCES [dbo].[Vouchers] ([VoucherId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Vouchers] FOREIGN KEY ([VoucherId]) REFERENCES [dbo].[Vouchers] ([VoucherId]);
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Providers] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[ShippingProviders] ([ProviderId]);
ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([OrderId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Variants] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[ProductVariants] ([VariantId]);
ALTER TABLE [dbo].[Payments] ADD CONSTRAINT [FK_Payments_Orders] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([OrderId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Reviews] ADD CONSTRAINT [FK_Reviews_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);
ALTER TABLE [dbo].[Reviews] ADD CONSTRAINT [FK_Reviews_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Wishlist] ADD CONSTRAINT [FK_Wishlist_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Wishlist] ADD CONSTRAINT [FK_Wishlist_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Notifications] ADD CONSTRAINT [FK_Notifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Notifications] ADD CONSTRAINT [FK_Notifications_Types] FOREIGN KEY ([NotificationTypeId]) REFERENCES [dbo].[NotificationTypes] ([TypeId]);
GO

/*******************************************************************************
   7. PERFORMANCE OPTIMIZATION INDEXES
********************************************************************************/
CREATE INDEX [IX_Product_Name_Slug] ON [dbo].[Products] ([ProductName], [Slug]);
CREATE INDEX [IX_ProductVariants_SKU_Price] ON [dbo].[ProductVariants] ([VariantSKU], [Price]);
CREATE INDEX [IX_Orders_User_Status] ON [dbo].[Orders] ([UserId], [Status]);
CREATE INDEX [IX_OrderDetails_OrderId] ON [dbo].[OrderDetails] ([OrderId]);
GO

/*******************************************************************************
   8. AUTOMATED SYNCHRONIZATION TRIGGER (Đã vá lỗi cú pháp đoạn cuối)
********************************************************************************/
CREATE TRIGGER [dbo].[TRG_ProductVariants_Update]
ON [dbo].[ProductVariants]
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE P
    SET P.[UpdatedAt] = GETDATE()
    FROM [dbo].[Products] P
    WHERE P.[ProductId] IN (
        SELECT [ProductId] FROM inserted
        UNION
        SELECT [ProductId] FROM deleted
    );
END;
GO


/*******************************************************************************
   9. MOCK DATA - CHÈN DỮ LIỆU ĐỂ HIỂN THỊ TRÊN DASHBOARD
********************************************************************************/
-- 1. Thêm Roles mẫu
INSERT INTO [dbo].[Roles] ([RoleName]) VALUES (N'Admin'), (N'Customer');

-- 2. Thêm Users mẫu (Tài khoản để đăng nhập: admin / 123)
INSERT INTO [dbo].[Users] ([RoleId], [Username], [Password], [FullName], [Email], [Status])
VALUES (1, 'admin', '123', N'Huỳnh Như Ý', 'nhuy@gmail.com', 1);

INSERT INTO [dbo].[Users] ([RoleId], [Username], [Password], [FullName], [Email], [Status])
VALUES (2, 'customer1', '123', N'Nguyễn Văn A', 'customer1@gmail.com', 1),
       (2, 'customer2', '123', N'Trần Thị B', 'customer2@gmail.com', 1);

-- 3. Thêm Categories & Brands mẫu
INSERT INTO [dbo].[Categories] ([CategoryName]) VALUES (N'Điện thoại'), (N'Bàn phím');
INSERT INTO [dbo].[Brands] ([BrandName]) VALUES (N'Apple'), (N'Logitech');

-- 4. Thêm Products mẫu (Cập nhật trường [Sold] tích lũy để hiển thị Top Products)
INSERT INTO [dbo].[Products] ([CategoryId], [BrandId], [BaseSKU], [ProductName], [Slug], [Sold], [Status])
VALUES (1, 1, 'APL-IP16PM-BASE', N'iPhone 16 Pro Max', 'iphone-16-pro-max', 1240, 1),
       (2, 2, 'LOG-G213-BASE', N'Bàn phím cơ Logitech G213', 'logitech-g213', 850, 1);

-- 5. Thêm Đơn hàng mẫu (Orders - Trạng thái Status = 3 là Completed mới được cộng doanh thu)
-- Giả lập các đơn hàng hoàn thành trong năm 2026 cho trang /revenue
INSERT INTO [dbo].[Orders] ([UserId], [OrderDate], [Subtotal], [ShippingFee], [DiscountAmount], [TotalAmount], [ReceiverName], [Phone], [ShippingAddress], [Status])
VALUES 
(2, '2026-01-15 10:00:00', 45000000.00, 30000.00, 0.00, 45030000.00, N'Nguyễn Văn A', '0901234567', N'Cần Thơ', 3),
(3, '2026-01-20 14:30:00', 2900000.00, 20000.00, 0.00, 2920000.00, N'Trần Thị B', '0907654321', N'Vĩnh Long', 3),
(2, '2026-02-10 09:15:00', 39000000.00, 30000.00, 500000.00, 38530000.00, N'Nguyễn Văn A', '0901234567', N'Cần Thơ', 3);

-- Đơn hàng mới (Status = 0: Pending) để hiển thị đếm ở trang chủ Dashboard Overview
INSERT INTO [dbo].[Orders] ([UserId], [OrderDate], [Subtotal], [ShippingFee], [DiscountAmount], [TotalAmount], [ReceiverName], [Phone], [ShippingAddress], [Status])
VALUES 
(3, GETDATE(), 1500000.00, 15000.00, 0.00, 1515000.00, N'Trần Thị B', '0907654321', N'Vĩnh Long', 0);
GO

USE [MiraiStoreDB];
GO

/*******************************************************************************
   BỔ SUNG THÊM DATA MẪU CHO SẢN PHẨM (ĐỂ XẾP HẠNG TOP PRODUCTS KỲ DIỆU HƠN)
********************************************************************************/
-- Thêm một vài sản phẩm công nghệ hot khác cho Mirai Store
INSERT INTO [dbo].[Products] ([CategoryId], [BrandId], [BaseSKU], [ProductName], [Slug], [Sold], [Status])
VALUES 
(1, 1, 'APL-MACAIR-M3', N'MacBook Air M3 13 inch', 'macbook-air-m3', 540, 1),
(1, 1, 'APL-IP15PM-BASE', N'iPhone 15 Pro Max Natural', 'iphone-15-pro-max', 980, 1),
(2, 2, 'LOG-MXKEYS-01', N'Bàn phím không dây Logitech MX Keys S', 'logitech-mx-keys-s', 420, 1),
(1, 2, 'LOG-SUPERLIGHT2', N'Chuột chơi game Logitech G Pro X Superlight 2', 'logitech-superlight-2', 1100, 1);

-- Cập nhật lại số liệu Sold ngẫu nhiên cho đa dạng
UPDATE [dbo].[Products] SET [Sold] = 1450 WHERE [BaseSKU] = 'APL-IP16PM-BASE';
UPDATE [dbo].[Products] SET [Sold] = 890  WHERE [BaseSKU] = 'LOG-G213-BASE';


/*******************************************************************************
   BỔ SUNG HÀNG LOẠT ĐƠN HÀNG (ORDERS) TRẢI DÀI CÁC THÁNG NĂM 2025 & 2026
********************************************************************************/

-- ====== DỮ LIỆU DOANH THU NĂM 2025 ======
INSERT INTO [dbo].[Orders] ([UserId], [OrderDate], [Subtotal], [ShippingFee], [DiscountAmount], [TotalAmount], [ReceiverName], [Phone], [ShippingAddress], [Status])
VALUES 
(2, '2025-01-10', 12000000, 30000, 0, 12030000, N'Lê Hoàng Long', '0912345678', N'Ninh Kiều, Cần Thơ', 3),
(3, '2025-02-14', 8500000,  25000, 100000, 8425000, N'Phạm Minh Thư', '0987654321', N'Cái Răng, Cần Thơ', 3),
(2, '2025-03-20', 25000000, 40000, 500000, 24540000, N'Trần Tiến Đạt', '0939123456', N'Bình Thủy, Cần Thơ', 3),
(3, '2025-04-30', 3200000,  15000, 0, 3215000, N'Nguyễn Hồng Hạnh', '0944556677', N'Ô Môn, Cần Thơ', 3),
(2, '2025-05-05', 45000000, 30000, 1000000, 44030000, N'Huỳnh Như Ý', '0900112233', N'Xuân Khánh, Cần Thơ', 3),
(3, '2025-06-18', 1500000,  15000, 0, 1515000, N'Vương Đình Khang', '0977889900', N'Vĩnh Long', 3),
(2, '2025-07-22', 19000000, 35000, 200000, 18835000, N'Đặng Minh Triết', '0911223344', N'Hậu Giang', 3),
(3, '2025-08-08', 2850000,  20000, 0, 2870000, N'Lý Mỹ Tiên', '0955667788', N'An Giang', 3),
(2, '2025-09-09', 52000000, 50000, 1500000, 50550000, N'Đỗ Cao Thắng', '0966778899', N'Kiên Giang', 3),
(3, '2025-10-10', 6400000,  20000, 50000, 6370000, N'Bùi Bích Phương', '0922334455', N'Cà Mau', 3),
(2, '2025-11-20', 11500000, 30000, 0, 11530000, N'Tạ Minh Tâm', '0988990011', N'Sóc Trăng', 3),
(3, '2025-12-25', 78000000, 60000, 2000000, 76060000, N'Nguyễn An Khang', '0911992288', N'Ninh Kiều, Cần Thơ', 3);


-- ====== DỮ LIỆU DOANH THU NĂM 2026 (TỪ THÁNG 1 ĐẾN THÁNG 6 HIỆN TẠI) ======
INSERT INTO [dbo].[Orders] ([UserId], [OrderDate], [Subtotal], [ShippingFee], [DiscountAmount], [TotalAmount], [ReceiverName], [Phone], [ShippingAddress], [Status])
VALUES 
(2, '2026-01-05', 35000000, 30000, 500000, 34530000, N'Trần Văn Cường', '0901112223', N'Ninh Kiều, Cần Thơ', 3),
(3, '2026-02-14', 18500000, 25000, 200000, 18325000, N'Đỗ Thùy Linh', '0903334445', N'Bình Thủy, Cần Thơ', 3),
(2, '2026-03-03', 42000000, 40000, 1000000, 41040000, N'Nguyễn Hoàng Nam', '0905556667', N'Cái Răng, Cần Thơ', 3),
(3, '2026-03-28', 2300000,  15000, 0, 2315000, N'Phan Thanh Bình', '0907778889', N'Thốt Nốt, Cần Thơ', 3),
(2, '2026-04-12', 12500000, 30000, 0, 12530000, N'Trịnh Công Sơn', '0909990001', N'Ô Môn, Cần Thơ', 3),
(3, '2026-04-25', 6800000,  20000, 100000, 6720000, N'Vũ Thu Phương', '0902223334', N'Ninh Kiều, Cần Thơ', 3),
(2, '2026-05-19', 29000000, 35000, 300000, 28735000, N'Mai Phương Thúy', '0904445556', N'Hậu Giang', 3),
(3, '2026-06-01', 54000000, 50000, 1500000, 52550000, N'Ngô Tiến Đạt', '0906667778', N'Phong Điền, Cần Thơ', 3),
(2, '2026-06-15', 3100000,  15000, 0, 3115000, N'Phạm Thành Long', '0908889990', N'Cái Răng, Cần Thơ', 3);


/*******************************************************************************
   BỔ SUNG THÊM ĐƠN HÀNG CHỜ XỬ LÝ (PENDING) VÀ ĐƠN HỦY (CANCELLED)
********************************************************************************/
-- Đơn hàng Đang chờ (Status = 0) -> Để trang chủ Overview đếm tăng lên
INSERT INTO [dbo].[Orders] ([UserId], [OrderDate], [Subtotal], [ShippingFee], [DiscountAmount], [TotalAmount], [ReceiverName], [Phone], [ShippingAddress], [Status])
VALUES 
(2, GETDATE(), 34990000, 40000, 0, 35030000, N'Hồ Ngọc Hà', '0912113114', N'Bình Thủy, Cần Thơ', 0),
(3, GETDATE(), 1350000,  15000, 0, 1365000,  N'Sơn Tùng M-TP', '0915116117', N'Ninh Kiều, Cần Thơ', 0),
(2, GETDATE(), 4500000,  20000, 50000, 4470000, N'Đen Vâu', '0918119119', N'Cái Răng, Cần Thơ', 0);

<<<<<<< HEAD
-- Define initial specification key parameters mapping specifications metrics options
INSERT INTO [dbo].[SpecificationDefinitions] ([CategoryId], [SpecName]) VALUES
(1, N'Chipset CPU'), (1, N'Dung lượng RAM'), (1, N'Kích thước màn hình'), (1, N'Dung lượng Pin'),
(2, N'Bộ vi xử lý'), (2, N'Card đồ họa (VGA)');
GO

-- Seed parameters registering base catalogue master products items index points
INSERT INTO [dbo].[Products] ([CategoryId], [BrandId], [BaseSKU], [ProductName], [Slug], [Views], [Sold], [IsFeatured], [IsNew], [Deleted], [Status], [Description], [CreatedBy], [PublishedAt]) VALUES
(1, 1, 'APL-IP16PM-BASE', N'iPhone 16 Pro Max', 'iphone-16-pro-max', 1540, 48, 1, 1, 0, 1, N'Smartphone cao cấp hàng đầu năm 2026.', 1, '2026-01-10'),
(1, 2, 'SAM-S26U-BASE', N'Samsung Galaxy S26 Ultra', 'samsung-galaxy-s26-ultra', 980, 22, 1, 1, 0, 1, N'Siêu phẩm tích hợp trí tuệ nhân tạo Galaxy AI mới.', 1, '2026-02-05');
GO

-- Seed parameters configuring price scales and stock levels across product variants configurations
INSERT INTO [dbo].[ProductVariants] ([ProductId], [VariantSKU], [VariantName], [OriginalPrice], [Price], [DiscountPercent], [Stock], [ImageUrl], [Status]) VALUES
(1, 'APL-IP16PM-256-BLK', N'iPhone 16 Pro Max 256GB Đen Titan', 34990000.00, 31990000.00, 9, 25, 'iphone-16-pm-black.png', N'Active'),
(1, 'APL-IP16PM-512-GLD', N'iPhone 16 Pro Max 512GB Vàng Sa Mạc', 40990000.00, 38990000.00, 5, 12, 'iphone-16-pm-gold.png', N'Active');
GO
-- 1. Vouchers
INSERT INTO Vouchers
(Code, DiscountPercent, MinimumOrder, StartDate, ExpireDate, Quantity, UsedQuantity, Status)
VALUES
('WELCOME5',5.00,200000,'2026-01-01','2027-12-31',100,0,1),
('WELCOME10',10.00,300000,'2026-01-01','2027-12-31',100,2,1),
('WELCOME15',15.00,500000,'2026-01-01','2027-12-31',80,5,1),
('WELCOME20',20.00,700000,'2026-01-01','2027-12-31',60,8,1),

('SUMMER5',5.00,200000,'2026-06-01','2026-08-31',150,10,1),
('SUMMER10',10.00,300000,'2026-06-01','2026-08-31',120,15,1),
('SUMMER15',15.00,500000,'2026-06-01','2026-08-31',100,20,1),
('SUMMER20',20.00,800000,'2026-06-01','2026-08-31',80,25,1),

('TECH5',5.00,300000,'2026-01-01','2027-06-30',200,30,1),
('TECH10',10.00,500000,'2026-01-01','2027-06-30',150,25,1),
('TECH15',15.00,800000,'2026-01-01','2027-06-30',100,18,1),
('TECH20',20.00,1000000,'2026-01-01','2027-06-30',80,12,1),

('VIP5',5.00,1000000,'2026-01-01','2027-12-31',40,5,1),
('VIP10',10.00,1500000,'2026-01-01','2027-12-31',35,4,1),
('VIP15',15.00,2000000,'2026-01-01','2027-12-31',30,3,1),
('VIP20',20.00,3000000,'2026-01-01','2027-12-31',20,2,1),

('BLACK5',5.00,300000,'2026-11-01','2026-11-30',100,0,1),
('BLACK10',10.00,500000,'2026-11-01','2026-11-30',80,0,1),
('BLACK15',15.00,700000,'2026-11-01','2026-11-30',60,0,1),
('BLACK20',20.00,1000000,'2026-11-01','2026-11-30',50,0,1);
GO

-- 2. Cart
INSERT INTO Cart(UserId)
VALUES
(5),
(6),
(7);
GO

-- 3. CartItems
INSERT INTO CartItems
(CartId, VariantId, Quantity)
VALUES
(1,1,2),
(1,2,1),
(2,1,1),
(2,2,2),
(3,1,1);
GO
-- 4. UserVoucher
INSERT INTO UserVoucher
(UserId, VoucherId, UsedCount, LastUsedDate)
VALUES
(5,1,1,'2026-06-01'),
(5,2,0,'2026-06-02'),
(5,3,1,'2026-06-03'),

(6,4,1,'2026-06-04'),
(6,5,2,'2026-06-05'),
(6,6,1,'2026-06-06'),

(7,7,1,'2026-06-07'),
(7,8,0,'2026-06-08'),
(7,9,2,'2026-06-09'),
(7,10,1,'2026-06-10');
=======
-- Đơn hàng Đã hủy (Status = 4) -> Kiểm tra xem bộ lọc doanh thu có bỏ qua chính xác không
INSERT INTO [dbo].[Orders] ([UserId], [OrderDate], [Subtotal], [ShippingFee], [DiscountAmount], [TotalAmount], [ReceiverName], [Phone], [ShippingAddress], [Status])
VALUES 
(2, '2026-05-20', 16000000, 30000, 0, 16030000, N'Khách hàng Boom Hàng', '0999999999', N'Trái Đất', 4);
>>>>>>> b5a60a5 (Update database and dashboard)
GO
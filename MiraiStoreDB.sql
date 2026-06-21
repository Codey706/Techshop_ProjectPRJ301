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

-- Table for system roles and permissions (Admin, Staff, Customer...)
CREATE TABLE [dbo].[Roles]
(
    [RoleId] INT NOT NULL IDENTITY(1,1),
    [RoleName] NVARCHAR(50) NOT NULL, -- Name of the role (e.g., N'Admin', N'Customer')
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleId]),
    CONSTRAINT [UQ_Roles_RoleName] UNIQUE ([RoleName])
);
GO

-- Table for user account credentials, profile details, and security states
CREATE TABLE [dbo].[Users]
(
    [UserId] INT NOT NULL IDENTITY(1,1),
    [RoleId] INT NOT NULL, -- Foreign key referencing the Roles table
    [Username] VARCHAR(50) NOT NULL, -- Unique username for login
    [Password] VARCHAR(500) NOT NULL, -- Hashed password string
    [PasswordSalt] VARCHAR(100) NULL, -- Password salt for cryptographic hashing
    [FullName] NVARCHAR(100) NOT NULL, -- Display name of the user
    [Email] VARCHAR(100) NOT NULL, -- Unique email address
    [Phone] VARCHAR(15) NULL, -- Contact phone number
    [Gender] NVARCHAR(10) NULL, -- Gender
    [DateOfBirth] DATE NULL, -- Date of birth
    [Avatar] NVARCHAR(255) NULL DEFAULT 'default-avatar.png', -- Path to profile avatar image
    [EmailVerified] BIT NOT NULL DEFAULT 0, -- Verification status of email (1: Verified, 0: Unverified)
    [VerifyToken] VARCHAR(100) NULL, -- Token used for account activation via email
    [ResetToken] VARCHAR(100) NULL, -- Token used for "Forgot Password" verification
    [ResetTokenExpiry] DATETIME NULL, -- Expiration time of the password reset token
    [FailedLoginAttempts] INT NOT NULL DEFAULT 0, -- Consecutive failed login attempts (Brute force protection)
    [LockedUntil] DATETIME NULL, -- Timestamp indicating how long the account is locked
    [Status] BIT NOT NULL DEFAULT 1, -- Account status (1: Active, 0: Locked)
    [LastLogin] DATETIME NULL, -- Last recorded login timestamp
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(), -- Account creation timestamp
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId]),
    CONSTRAINT [UQ_Users_Username] UNIQUE ([Username]),
    CONSTRAINT [UQ_Users_Email] UNIQUE ([Email]),
    CONSTRAINT [CK_Users_Gender] CHECK ([Gender] IN (N'Nam', N'Nữ', N'Khác'))
);
GO

-- Table for auditing user authentication history (Login/Logout logs)
CREATE TABLE [dbo].[LoginHistory]
(
    [LoginId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL, -- Foreign key referencing the Users table
    [IPAddress] VARCHAR(45) NULL, -- IP address of the client device
    [Browser] NVARCHAR(255) NULL, -- User-Agent string containing browser and OS details
    [IsSuccess] BIT NOT NULL DEFAULT 1, -- Status of login attempt (1: Success, 0: Failed)
    [LoginTime] DATETIME NOT NULL DEFAULT GETDATE(), -- Login timestamp
    [LogoutTime] DATETIME NULL, -- Actual logout timestamp
    CONSTRAINT [PK_LoginHistory] PRIMARY KEY CLUSTERED ([LoginId])
);
GO

-- Audit Logs Table: Monitors sensitive data mutations (Insert, Update, Delete)
CREATE TABLE [dbo].[AuditLogs]
(
    [LogId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NULL, -- User who performed the action (NULL if automated or anonymous guest)
    [Action] NVARCHAR(50) NOT NULL, -- Type of action (e.g., INSERT, UPDATE, DELETE)
    [TableName] VARCHAR(100) NOT NULL, -- Affected database table name
    [RecordId] INT NOT NULL, -- Primary Key ID of the affected record
    [OldValue] NVARCHAR(MAX) NULL, -- State of data before modification (JSON or Text format)
    [NewValue] NVARCHAR(MAX) NULL, -- State of data after modification
    [IPAddress] VARCHAR(45) NULL, -- Client IP performing the action
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(), -- Log creation timestamp
    CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED ([LogId])
);
GO

-- User Shipping Address Book (One user can store multiple shipping addresses)
CREATE TABLE [dbo].[Addresses]
(
    [AddressId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL, -- Foreign key referencing the Users table
    [ReceiverName] NVARCHAR(100) NOT NULL, -- Name of the package recipient
    [Phone] VARCHAR(15) NOT NULL, -- Recipient's phone number
    [Province] NVARCHAR(100) NOT NULL, -- Province / City
    [District] NVARCHAR(100) NOT NULL, -- District / Town
    [Ward] NVARCHAR(100) NOT NULL, -- Ward / Commune
    [Street] NVARCHAR(255) NOT NULL, -- Detailed street address/house number
    [AddressType] NVARCHAR(50) NULL DEFAULT N'Home', -- Label: N'Home' or N'Office'
    [IsDefault] BIT NOT NULL DEFAULT 0, -- Set default checkout address (1: Yes, 0: No)
    [Deleted] BIT NOT NULL DEFAULT 0, -- Soft delete flag to protect historical order records
    CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED ([AddressId]),
    CONSTRAINT [CK_Addresses_Type] CHECK ([AddressType] IN (N'Home', N'Office'))
);
GO


/*******************************************************************************
   2. PRODUCT CATALOG & VARIANT ARCHITECTURE
********************************************************************************/

-- Table for general product categories (e.g., Phones, Laptops, Keyboards...)
CREATE TABLE [dbo].[Categories]
(
    [CategoryId] INT NOT NULL IDENTITY(1,1),
    [CategoryName] NVARCHAR(100) NOT NULL, -- Category name
    [ImageURL] NVARCHAR(255) NULL, -- Category cover image
    [Description] NVARCHAR(255) NULL, -- Category description text
    [Deleted] BIT NOT NULL DEFAULT 0, -- Soft delete/Hidden category flag
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryId]),
    CONSTRAINT [UQ_Categories_CategoryName] UNIQUE ([CategoryName])
);
GO

-- Table for product brands (e.g., Apple, Samsung, ASUS, Logitech...)
CREATE TABLE [dbo].[Brands]
(
    [BrandId] INT NOT NULL IDENTITY(1,1),
    [BrandName] NVARCHAR(100) NOT NULL, -- Brand name
    [Logo] NVARCHAR(255) NULL, -- Brand logo image path
    [Country] NVARCHAR(50) NULL, -- Country of origin
    [Description] NVARCHAR(MAX) NULL, -- Brand bio and introduction text
    [Status] BIT NOT NULL DEFAULT 1, -- Active status of the brand
    [Deleted] BIT NOT NULL DEFAULT 0, -- Soft delete flag
    CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED ([BrandId]),
    CONSTRAINT [UQ_Brands_BrandName] UNIQUE ([BrandName])
);
GO

-- Table defining specification keys per category (e.g., Laptops category defines 'RAM', 'CPU')
CREATE TABLE [dbo].[SpecificationDefinitions]
(
    [SpecDefId] INT NOT NULL IDENTITY(1,1),
    [CategoryId] INT NOT NULL, -- Linked category ID
    [SpecName] NVARCHAR(100) NOT NULL, -- Name of specification (e.g., N'RAM Capacity')
    CONSTRAINT [PK_SpecificationDefinitions] PRIMARY KEY CLUSTERED ([SpecDefId]),
    CONSTRAINT [UQ_Category_SpecDefName] UNIQUE ([CategoryId], [SpecName])
);
GO

-- Master Product Table (Holds shared product data; pricing and stock belong to variants)
CREATE TABLE [dbo].[Products]
(
    [ProductId] INT NOT NULL IDENTITY(1,1),
    [CategoryId] INT NOT NULL, -- Foreign key referencing Categories
    [BrandId] INT NOT NULL, -- Foreign key referencing Brands
    [BaseSKU] VARCHAR(50) NOT NULL, -- Base Stock Keeping Unit identifier (e.g., APL-IP16PM-BASE)
    [ProductName] NVARCHAR(255) NOT NULL, -- Main product name
    [Slug] VARCHAR(255) NOT NULL, -- URL-friendly SEO string (e.g., iphone-16-pro-max)
    [Views] INT NOT NULL DEFAULT 0, -- Page view counter
    [Sold] INT NOT NULL DEFAULT 0, -- Total aggregated units sold
    [IsFeatured] BIT NOT NULL DEFAULT 0, -- Featured flag for homepage display (1: Yes, 0: No)
    [IsNew] BIT NOT NULL DEFAULT 1, -- New arrival badge flag
    [Deleted] BIT NOT NULL DEFAULT 0, -- Soft delete flag
    [Status] INT NOT NULL DEFAULT 1, -- Business status (1: On Sale, 0: Discontinued)
    [Description] NVARCHAR(MAX) NULL, -- Rich-text HTML full product details
    [CreatedBy] INT NULL, -- Staff/Admin ID who added the product
    [PublishedAt] DATETIME NULL, -- Official public launch date
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductId]),
    CONSTRAINT [UQ_Products_BaseSKU] UNIQUE ([BaseSKU]),
    CONSTRAINT [UQ_Products_Slug] UNIQUE ([Slug])
);
GO

-- Product Variants Table (Stores prices, configurations, and physical inventory stock)
CREATE TABLE [dbo].[ProductVariants]
(
    [VariantId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL, -- Foreign key referencing parent master Product
    [VariantSKU] VARCHAR(50) NOT NULL, -- Inventory SKU for this specific setup (e.g., APL-IP16PM-256GB-BLK)
    [VariantName] NVARCHAR(255) NOT NULL, -- Specific configuration title (e.g., N'iPhone 16 Pro Max 256GB Black')
    [OriginalPrice] DECIMAL(18,2) NOT NULL, -- Retail recommended price (MSRP)
    [Price] DECIMAL(18,2) NOT NULL, -- Actual selling price after flat discounts
    [DiscountPercent] INT NULL DEFAULT 0, -- Calculated discount percentage shown on UI
    [Stock] INT NOT NULL DEFAULT 0, -- Current physical stock quantity for this setup
    [ImageUrl] NVARCHAR(255) NULL, -- Color-specific variant image
    [Status] NVARCHAR(20) NOT NULL DEFAULT N'Active', -- Operational status (Active, OutOfStock, Suspended)
    CONSTRAINT [PK_ProductVariants] PRIMARY KEY CLUSTERED ([VariantId]),
    CONSTRAINT [UQ_Variants_SKU] UNIQUE ([VariantSKU]),
    CONSTRAINT [CK_Variants_OriginalPrice] CHECK ([OriginalPrice] >= 0),
    CONSTRAINT [CK_Variants_Price] CHECK ([Price] >= 0),
    CONSTRAINT [CK_Variants_Stock] CHECK ([Stock] >= 0)
);
GO

-- Inventory History Logs Table (Tracks stock adjustments for warehouse management)
CREATE TABLE [dbo].[InventoryHistory]
(
    [InventoryLogId] INT NOT NULL IDENTITY(1,1),
    [VariantId] INT NOT NULL, -- Targeted product variant
    [Type] NVARCHAR(20) NOT NULL, -- Event type: IMPORT (Restock), EXPORT (Sales deduction), ADJUST (Manual stock count)
    [QuantityChanged] INT NOT NULL, -- Quantity delta (e.g., +50 or -2)
    [OldStock] INT NOT NULL, -- Inventory level before event
    [NewStock] INT NOT NULL, -- New inventory level post-event
    [Reason] NVARCHAR(255) NULL, -- Dynamic logging text (e.g., N'Auto deduction from order #10')
    [CreatedBy] INT NULL, -- System operator ID
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_InventoryHistory] PRIMARY KEY CLUSTERED ([InventoryLogId])
);
GO

-- Table mapping spec values to product definitions (e.g., iPhone 16 Pro Max -> CPU = 'Apple A18 Pro')
CREATE TABLE [dbo].[ProductSpecifications]
(
    [SpecId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL, -- Parent product ID
    [SpecDefId] INT NOT NULL, -- Linked attribute key ID
    [SpecValue] NVARCHAR(255) NOT NULL, -- Specific structural values (e.g., N'Apple A18 Pro')
    CONSTRAINT [PK_ProductSpecifications] PRIMARY KEY CLUSTERED ([SpecId]),
    CONSTRAINT [UQ_Product_SpecDefId] UNIQUE ([ProductId], [SpecDefId])
);
GO

-- Product Secondary Media Gallery (Handles detailed slideshow images on Detail Pages)
CREATE TABLE [dbo].[ProductImages]
(
    [ImageId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL, -- Parent product ID
    [ImageUrl] NVARCHAR(255) NOT NULL, -- Relative path to media asset file
    [AltText] NVARCHAR(255) NULL, -- Image alternative description text for SEO/Accessibility
    [DisplayOrder] INT NOT NULL DEFAULT 1, -- Carousel sort ordering indicator
    [IsThumbnail] BIT NOT NULL DEFAULT 0, -- Flags primary thumbnail image (1: Yes, 0: No)
    [Deleted] BIT NOT NULL DEFAULT 0, -- Soft delete tracking
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED ([ImageId])
);
GO


/*******************************************************************************
   3. CART, LOGISTICS & MARKETING SYSTEMS
********************************************************************************/

-- Master Shopping Cart Table (Each registered user owns exactly one unique cart shell)
CREATE TABLE [dbo].[Cart]
(
    [CartId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL, -- Cart master owner ID
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(), 
    CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED ([CartId]),
    CONSTRAINT [UQ_Cart_UserId] UNIQUE ([UserId])
);
GO

-- Cart Items Detail Breakdown Table (Tracks variant choices and counts in user carts)
CREATE TABLE [dbo].[CartItems]
(
    [CartItemId] INT NOT NULL IDENTITY(1,1),
    [CartId] INT NOT NULL, -- Connected cart shell ID
    [VariantId] INT NOT NULL, -- Specific product variant SKU ID chosen
    [Quantity] INT NOT NULL DEFAULT 1, -- Quantities added
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(), 
    CONSTRAINT [PK_CartItems] PRIMARY KEY CLUSTERED ([CartItemId]),
    CONSTRAINT [UQ_CartItems_CartVariant] UNIQUE ([CartId], [VariantId])
);
GO

-- Marketing Campaign Vouchers / Coupons Management Table
CREATE TABLE [dbo].[Vouchers]
(
    [VoucherId] INT NOT NULL IDENTITY(1,1),
    [Code] VARCHAR(50) NOT NULL, -- Unique coupon code identifier text (e.g., COGIAYMAI20)
    [DiscountPercent] DECIMAL(5,2) NOT NULL, -- Percentage markdown value (e.g., 10.00 means 10% off)
    [MinimumOrder] DECIMAL(18,2) NOT NULL DEFAULT 0, -- Basket spend criteria to activate coupon code
    [StartDate] DATETIME NOT NULL DEFAULT GETDATE(), -- Coupon starting validity window
    [ExpireDate] DATETIME NOT NULL, -- Coupon expiration window
    [Quantity] INT NOT NULL, -- Issued quantity allocation
    [UsedQuantity] INT NOT NULL DEFAULT 0, -- Successfully finalized usage tracker
    [Status] INT NOT NULL DEFAULT 1, -- Operational toggles (1: Available, 0: Disabled/Exhausted)
    CONSTRAINT [PK_Vouchers] PRIMARY KEY CLUSTERED ([VoucherId]),
    CONSTRAINT [UQ_Vouchers_Code] UNIQUE ([Code])
);
GO

-- Intermediary Tracking Table for Voucher Usage (Enforces "One Use Per Customer" rules)
CREATE TABLE [dbo].[UserVoucher]
(
    [UserVoucherId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL, -- Customer User ID
    [VoucherId] INT NOT NULL, -- Referenced Voucher ID
    [UsedCount] INT NOT NULL DEFAULT 1, -- Total times this user used this code
    [LastUsedDate] DATETIME NOT NULL DEFAULT GETDATE(), -- Last validation timestamp
    CONSTRAINT [PK_UserVoucher] PRIMARY KEY CLUSTERED ([UserVoucherId]),
    CONSTRAINT [UQ_User_Voucher_Track] UNIQUE ([UserId], [VoucherId])
);
GO

-- Third-Party Integrated Logistics Carriers Table (e.g., Giao Hàng Nhanh, Viettel Post...)
CREATE TABLE [dbo].[ShippingProviders]
(
    [ProviderId] INT NOT NULL IDENTITY(1,1),
    [ProviderName] NVARCHAR(100) NOT NULL, -- Shipping agency name
    [Phone] VARCHAR(15) NULL, -- Logistics support hotline
    [Status] BIT NOT NULL DEFAULT 1, -- Carrier operational state (1: Activated, 0: Suspended)
    [Deleted] BIT NOT NULL DEFAULT 0, -- Soft delete flag
    CONSTRAINT [PK_ShippingProviders] PRIMARY KEY CLUSTERED ([ProviderId])
);
GO

-- Promotional Marketing Banners Graphics Table (Handles homepage graphic carousels)
CREATE TABLE [dbo].[Banners]
(
    [BannerId] INT NOT NULL IDENTITY(1,1),
    [Title] NVARCHAR(150) NOT NULL, -- Marketing campaign name tag
    [ImageURL] NVARCHAR(255) NOT NULL, -- Resolution-specific source path to asset graphic
    [LinkURL] NVARCHAR(255) NULL, -- Redirection path target when clicked by visitors
    [DisplayOrder] INT NOT NULL DEFAULT 1, -- Visual layout prioritization weights
    [Status] BIT NOT NULL DEFAULT 1, -- Display toggle (1: Displaying, 0: Hidden)
    CONSTRAINT [PK_Banners] PRIMARY KEY CLUSTERED ([BannerId])
);
GO


/*******************************************************************************
   4. SALES, ORDERS & PAYMENTS
****************************************************************dc********/

-- Master Customer Sales Order Placement Processing Table
CREATE TABLE [dbo].[Orders]
(
    [OrderId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL, -- Buying Customer ID
    [VoucherId] INT NULL, -- Active Voucher ID applied (NULL if none)
    [ProviderId] INT NULL, -- Handled Shipping Carrier ID
    [AddressId] INT NULL, -- Historical Address ID anchor point
    [OrderDate] DATETIME NOT NULL DEFAULT GETDATE(), -- Sales inception timestamp
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(), -- State machine change tracking timestamp
    [Subtotal] DECIMAL(18,2) NOT NULL DEFAULT 0, -- Cart gross value before coupons
    [ShippingFee] DECIMAL(18,2) NOT NULL DEFAULT 0, -- Cargo handling costs
    [DiscountAmount] DECIMAL(18,2) NOT NULL DEFAULT 0, -- Markdown cash discount value from vouchers
    [TotalAmount] DECIMAL(18, 2) NOT NULL, -- Final net checkout cost (= Subtotal + ShippingFee - DiscountAmount)
    [ReceiverName] NVARCHAR(100) NOT NULL, -- Snapshot recipient name copy (Protects history against user edits)
    [Phone] VARCHAR(15) NOT NULL, -- Snapshot recipient contact phone
    [ShippingAddress] NVARCHAR(500) NOT NULL, -- Snapshot explicit logistics destination text string
    [Note] NVARCHAR(300) NULL, -- Client delivery request notes (e.g., N'Deliver during office hours')
    [Status] TINYINT NOT NULL DEFAULT 0, -- Processing State Machine: 0: Pending, 1: Confirmed, 2: Shipping, 3: Completed, 4: Cancelled
    [PaymentStatus] TINYINT NOT NULL DEFAULT 0, -- Transaction State Machine: 0: Unpaid, 1: Paid, 2: Refunded (For cancelled items)
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderId])
);
GO

-- Invoice Line Items Detail breakdown Table (Implements Historical Snapshot Architecture)
CREATE TABLE [dbo].[OrderDetails]
(
    [OrderDetailId] INT NOT NULL IDENTITY(1,1),
    [OrderId] INT NOT NULL, -- Parent Order identifier
    [VariantId] INT NOT NULL, -- Purchased variant configuration ID
    [Quantity] INT NOT NULL, -- Final unit items count bought
    [UnitPrice] DECIMAL(18, 2) NOT NULL, -- Price point locked at checkout
    
    -- DATA SNAPSHOT FIELDS: Duplicates master catalog text metadata at point-of-sale.
    -- Ensures historical invoice text remains unchanged even if catalogs are updated or deleted by Admins.
    [SnapProductName] NVARCHAR(255) NOT NULL, -- Copied product name
    [SnapVariantName] NVARCHAR(255) NOT NULL, -- Copied specific configuration name
    [SnapVariantSKU] VARCHAR(50) NOT NULL, -- Copied Stock Keeping Unit text
    [SnapImageUrl] NVARCHAR(255) NULL, -- Copied item icon path
    [SnapBrandName] NVARCHAR(100) NULL, -- Copied product line manufacturer label
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED ([OrderDetailId])
);
GO

-- Gateway Logs Processing & Ledger Reconciliation Synced Accounting Table (MoMo, VNPay, COD...)
CREATE TABLE [dbo].[Payments]
(
    [PaymentId] INT NOT NULL IDENTITY(1,1),
    [OrderId] INT NOT NULL, -- Parent target Order ID mapping link
    [PaymentMethod] NVARCHAR(50) NOT NULL, -- Gateway Type: COD, MoMo, VNPay, BankTransfer
    [Amount] DECIMAL(18, 2) NOT NULL, -- Absolute numerical balance value processed
    [Currency] VARCHAR(10) NOT NULL DEFAULT 'VND', -- Global currency code tracker
    [TransactionCode] VARCHAR(100) NULL, -- Internal platform tracking code generated via Java Web (TxnRef)
    [GatewayTransactionId] VARCHAR(100) NULL, -- External clearing index number returned by MoMo/VNPay bank networks
    [BankCode] VARCHAR(20) NULL, -- Settlement clearance institute channel indicator (e.g., NCB, VCB...)
    [GatewayResponseCode] VARCHAR(10) NULL, -- Status code feedback payload (e.g., '00' indicates full settlement success)
    [PaymentUrl] NVARCHAR(1000) NULL, -- Generated gateway checkout redirect string / QR payload string
    [CallbackData] NVARCHAR(MAX) NULL, -- Raw unstructured webhook IPN JSON payloads logged for auditing
    [SecureHash] VARCHAR(256) NULL, -- Security signature hash verification string validating integrity
    [PaidDate] DATETIME NULL, -- Exact timestamp indicating when money was cleared from the user account
    [ExpiredTime] DATETIME NULL, -- Gateway session window timeline limit (Session closes upon expiry, cancelling order)
    [Status] TINYINT NOT NULL DEFAULT 0, -- Internal ledger state: 0: Pending, 1: Completed, 2: Failed/Cancelled
    CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED ([PaymentId])
);
GO


/*******************************************************************************
   5. ENGAGEMENT, SEPARATED NOTIFICATIONS & BLOG TABLES
********************************************************************************/

-- Classification Table for Notification Alerts (e.g., ORDER, PROMOTION, SYSTEM...)
CREATE TABLE [dbo].[NotificationTypes]
(
    [TypeId] INT NOT NULL IDENTITY(1,1),
    [TypeName] VARCHAR(50) NOT NULL, -- Notification category name
    [Description] NVARCHAR(255) NULL, -- Category purpose explanation
    [Deleted] BIT NOT NULL DEFAULT 0,
    CONSTRAINT [PK_NotificationTypes] PRIMARY KEY CLUSTERED ([TypeId]),
    CONSTRAINT [UQ_NotificationTypes_Name] UNIQUE ([TypeName])
);
GO

-- Product Performance Reviews & Customer Feedbacks Validation Management Table
CREATE TABLE [dbo].[Reviews]
(
    [ReviewId] INT NOT NULL IDENTITY(1,1),
    [ProductId] INT NOT NULL, -- Evaluated base master product item
    [UserId] INT NOT NULL, -- Reviewing customer author account
    [Title] NVARCHAR(100) NULL, -- Subject heading overview summary
    [Rating] INT NOT NULL, -- Awarded star rating score values ranging [1 - 5 Stars]
    [Comment] NVARCHAR(MAX) NULL, -- Editorial textual description evaluation
    [VerifiedPurchase] BIT NOT NULL DEFAULT 0, -- Validation badge indicator (1: Verified buyer, 0: Regular user)
    [Status] BIT NOT NULL DEFAULT 1, -- Moderation display status (1: Authorized, 0: Hidden due to violation)
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(), 
    CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED ([ReviewId]),
    CONSTRAINT [UQ_User_ProductReview] UNIQUE ([UserId], [ProductId]) -- Enforces a rule where one user can only review a product once
);
GO

-- Saved Items Wishlists Intermediary Ledger Mapping Table
CREATE TABLE [dbo].[Wishlist]
(
    [WishlistId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL, -- Account holder master owner ID
    [ProductId] INT NOT NULL, -- Favorited target master item
    CONSTRAINT [PK_Wishlist] PRIMARY KEY CLUSTERED ([WishlistId]),
    CONSTRAINT [UQ_Wishlist_UserProduct] UNIQUE ([UserId], [ProductId])
);
GO

-- User Dashboard Inbox Real-time System Message Log Notification Center Table
CREATE TABLE [dbo].[Notifications]
(
    [NotificationId] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL, -- Target recipient user account
    [NotificationTypeId] INT NOT NULL, -- Linked notification category (ORDER, PROMOTION...)
    [Title] NVARCHAR(150) NOT NULL, -- Alert header banner title
    [Content] NVARCHAR(500) NOT NULL, -- Body text message details
    [Link] NVARCHAR(255) NULL, -- Redirection link path triggered upon click (e.g., /order/detail?id=1)
    [IsRead] BIT NOT NULL DEFAULT 0, -- Read verification state (1: Read, 0: Unread shows badge alert)
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(), -- Dispatched issuance timestamp
    CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED ([NotificationId])
);
GO


/*******************************************************************************
   6. FOREIGN KEY CONSTRAINTS (Data Referential Integrity)
********************************************************************************/
-- Users table references Roles mapping permissions
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_Users_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]);

-- LoginHistory links to Users (If a user is dropped, cascade delete logs)
ALTER TABLE [dbo].[LoginHistory] ADD CONSTRAINT [FK_LoginHistory_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;

-- AuditLogs link back to Users (On user deletion, set log attribution author column back to NULL)
ALTER TABLE [dbo].[AuditLogs] ADD CONSTRAINT [FK_AuditLogs_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE SET NULL;

-- Addresses book links back to Users (On user deletion, wipe related address books)
ALTER TABLE [dbo].[Addresses] ADD CONSTRAINT [FK_Addresses_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;

-- Specification specifications reference master Category rules configurations
ALTER TABLE [dbo].[SpecificationDefinitions] ADD CONSTRAINT [FK_SpecDef_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]) ON DELETE CASCADE;

-- Master catalog references targeting related Categories & Brands links
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]);
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_Products_Brands] FOREIGN KEY ([BrandId]) REFERENCES [dbo].[Brands] ([BrandId]);

-- Product child configurations variant structures lock mapping back to parent item
ALTER TABLE [dbo].[ProductVariants] ADD CONSTRAINT [FK_Variants_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;

-- Stock history modifications logs track targeted child variant configs
ALTER TABLE [dbo].[InventoryHistory] ADD CONSTRAINT [FK_Inventory_Variants] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[ProductVariants] ([VariantId]) ON DELETE CASCADE;

-- Product characteristics mapping specifications targets parent components & labels definitions
ALTER TABLE [dbo].[ProductSpecifications] ADD CONSTRAINT [FK_ProductSpecs_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[ProductSpecifications] ADD CONSTRAINT [FK_ProductSpecs_Definitions] FOREIGN KEY ([SpecDefId]) REFERENCES [dbo].[SpecificationDefinitions] ([SpecDefId]);

-- Multimedia gallery pictures map structural tracking indicators to parent product entries
ALTER TABLE [dbo].[ProductImages] ADD CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;

-- Cart shells mapping controls register links back to customer profile owners
ALTER TABLE [dbo].[Cart] ADD CONSTRAINT [FK_Cart_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;

-- Cart rows items detail trackers map back to cart shell definitions and configurations elements
ALTER TABLE [dbo].[CartItems] ADD CONSTRAINT [FK_CartItems_Cart] FOREIGN KEY ([CartId]) REFERENCES [dbo].[Cart] ([CartId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[CartItems] ADD CONSTRAINT [FK_CartItems_Variants] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[ProductVariants] ([VariantId]) ON DELETE CASCADE;

-- Customer coupon tracking ledgers lock mapping relationships across clients and voucher definitions
ALTER TABLE [dbo].[UserVoucher] ADD CONSTRAINT [FK_UserVoucher_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[UserVoucher] ADD CONSTRAINT [FK_UserVoucher_Vouchers] FOREIGN KEY ([VoucherId]) REFERENCES [dbo].[Vouchers] ([VoucherId]) ON DELETE CASCADE;

-- Sales Order records capture user purchasers, coupon voucher codes used, and selected delivery services
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Vouchers] FOREIGN KEY ([VoucherId]) REFERENCES [dbo].[Vouchers] ([VoucherId]);
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Providers] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[ShippingProviders] ([ProviderId]);

-- Order detailed line items link directly back to parent order and item SKU components
ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([OrderId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Variants] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[ProductVariants] ([VariantId]);

-- Payment transaction records link directly back to the targeted Sales Order invoice
ALTER TABLE [dbo].[Payments] ADD CONSTRAINT [FK_Payments_Orders] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([OrderId]) ON DELETE CASCADE;

-- Review feedback lists tie back to author profile users and target item pages
ALTER TABLE [dbo].[Reviews] ADD CONSTRAINT [FK_Reviews_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]);
ALTER TABLE [dbo].[Reviews] ADD CONSTRAINT [FK_Reviews_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;

-- Wishlists rows connect client profiles with items catalog pages
ALTER TABLE [dbo].[Wishlist] ADD CONSTRAINT [FK_Wishlist_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Wishlist] ADD CONSTRAINT [FK_Wishlist_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]) ON DELETE CASCADE;

-- System message notification inbox entries track target receivers and classifications templates
ALTER TABLE [dbo].[Notifications] ADD CONSTRAINT [FK_Notifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Notifications] ADD CONSTRAINT [FK_Notifications_Types] FOREIGN KEY ([NotificationTypeId]) REFERENCES [dbo].[NotificationTypes] ([TypeId]);
GO


/*******************************************************************************
   7. PERFORMANCE OPTIMIZATION INDEXES
********************************************************************************/
-- Speeds up search queries filtering products by names and SEO-friendly slug path values
CREATE INDEX [IX_Product_Name_Slug] ON [dbo].[Products] ([ProductName], [Slug]);

-- Enhances catalogue filtering speeds on structural price scales and SKU checks
CREATE INDEX [IX_ProductVariants_SKU_Price] ON [dbo].[ProductVariants] ([VariantSKU], [Price]);

-- Accelerates user dashboard lookups monitoring historical orders filtered by milestones
CREATE INDEX [IX_Orders_User_Status] ON [dbo].[Orders] ([UserId], [Status]);

-- Speeds up relational JOIN operations compiling invoice lines for customer receipt generation
CREATE INDEX [IX_OrderDetails_OrderId] ON [dbo].[OrderDetails] ([OrderId]);
GO


/*******************************************************************************
   8. AUTOMATED SYNCHRONIZATION TRIGGER (Updated Lifecycle Sync)
********************************************************************************/
-- Automatically runs whenever child variant items change (Insert, Update, Delete events).
-- Keeps parent master catalog [UpdatedAt] timestamps synchronized to drop website caches accurately.
CREATE TRIGGER [dbo].[TRG_ProductVariants_Update]
ON [dbo].[ProductVariants]
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON; -- Suppresses rows affected notifications to streamline throughput over clean JDBC pipelines
    
    UPDATE P
    SET P.[UpdatedAt] = GETDATE()
    FROM [dbo].[Products] P
    WHERE P.[ProductId] IN (
        SELECT [ProductId] FROM inserted -- Captures modifications from additions/updates
        UNION
        SELECT [ProductId] FROM deleted  -- Captures adjustments from missing/purged elements
    );
END;
GO


/*******************************************************************************
   9. SET-BASED CHECKOUT STORED PROCEDURE (Anti-Overselling Guardrails)
********************************************************************************/
-- Manages checkout routines securely within atomic database transaction processing blocks.
-- Solves multi-threaded race conditions (Overselling) where hundreds of clients click to buy 1 item left in stock.
CREATE PROCEDURE [dbo].[sp_CreateOrderWithTransactionV8]
    @UserId INT,                -- Customer Account ID placing order
    @VoucherId INT,             -- Coupon Voucher identifier used (Pass NULL if none)
    @ProviderId INT,            -- Carrier Delivery Provider ID chosen
    @AddressId INT,             -- User shipping profile reference anchor point
    @Subtotal DECIMAL(18,2),    -- Basket items value evaluation cost
    @ShippingFee DECIMAL(18,2),   -- Freight delivery expenses
    @DiscountAmount DECIMAL(18,2), -- Deducted cash value from voucher code application
    @TotalAmount DECIMAL(18,2),   -- Net cash amount required to settle (= Subtotal + ShippingFee - DiscountAmount)
    @ReceiverName NVARCHAR(100), -- Recipient contact name
    @Phone VARCHAR(15),         -- Recipient contact phone number
    @ShippingAddress NVARCHAR(500), -- Explicit textual delivery location description
    @Note NVARCHAR(300),        -- Specific courier instructions left by user
    @PaymentMethod NVARCHAR(50), -- Choice of settlement channel (COD, MoMo, VNPay...)
    @OutOrderId INT OUTPUT      -- OUTPUT parameter passing the newly generated Invoice ID back to Java Servlet
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Instantiate local temporary table inside RAM to compile current cart items state
    DECLARE @CartTable TABLE (
        VariantId INT PRIMARY KEY,
        Quantity INT
    );
    
    DECLARE @CartId INT;
    -- Find the customer's active online shopping cart ID
    SELECT @CartId = [CartId] FROM [dbo].[Cart] WHERE [UserId] = @UserId;
    
    -- Extract items data from permanent cart ledger elements down into temporary RAM tables
    INSERT INTO @CartTable (VariantId, Quantity)
    SELECT [VariantId], [Quantity] FROM [dbo].[CartItems] WHERE [CartId] = @CartId;
    
    -- Interrupt processing if the shopping cart is found empty to avoid corrupted blank invoices
    IF NOT EXISTS (SELECT 1 FROM @CartTable)
    BEGIN
        RAISERROR(N'The shopping cart is empty; cannot proceed with order placement.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        -- Lock concurrency states to SERIALIZABLE isolation thresholds for high integrity protection.
        -- Completely eliminates dirty reads and lost updates across concurrent client requests.
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;

        -- ANTI-OVERSELLING GUARDRAILS:
        -- Lock matching stock catalog row indexes exclusively using (UPDLOCK, HOLDLOCK) parameters.
        -- Forces concurrent checkout pipelines for identical configurations to wait in queue until this block resolves.
        DECLARE @InsufficientStock INT = 0;
        
        SELECT @InsufficientStock = COUNT(*)
        FROM [dbo].[ProductVariants] V WITH (UPDLOCK, HOLDLOCK)
        INNER JOIN @CartTable CT ON V.[VariantId] = CT.[VariantId]
        WHERE V.[Stock] < CT.[Quantity]; -- Verify if any targeted product variant falls short of user item demands

        -- Instantly trigger standard system runtime errors if item counts prove insufficient, forcing a transaction rollback
        IF (@InsufficientStock > 0)
        BEGIN
            RAISERROR(N'One or more items in your cart do not have sufficient warehouse inventory stock levels.', 16, 1);
        END

        -- Step 1: Create master Sales Order tracking entry inside Orders table
        INSERT INTO [dbo].[Orders] 
            ([UserId], [VoucherId], [ProviderId], [AddressId], [OrderDate], [UpdatedAt], [Subtotal], [ShippingFee], [DiscountAmount], [TotalAmount], [ReceiverName], [Phone], [ShippingAddress], [Note], [Status], [PaymentStatus])
        VALUES 
            (@UserId, @VoucherId, @ProviderId, @AddressId, GETDATE(), GETDATE(), @Subtotal, @ShippingFee, @DiscountAmount, @TotalAmount, @ReceiverName, @Phone, @ShippingAddress, @Note, 0, 0);

        -- Extract the newly generated IDENTITY Primary Key ID value out to output variables
        SET @OutOrderId = SCOPE_IDENTITY();

        -- Step 2: Extract details data out from temporary RAM spaces over to permanent OrderDetails records
        -- Applies relational JOIN lookups to clone current master info fields for archival historical accuracy
        INSERT INTO [dbo].[OrderDetails] 
            ([OrderId], [VariantId], [Quantity], [UnitPrice], [SnapProductName], [SnapVariantName], [SnapVariantSKU], [SnapImageUrl], [SnapBrandName])
        SELECT 
            @OutOrderId, CT.[VariantId], CT.[Quantity], V.[Price], P.[ProductName], V.[VariantName], V.[VariantSKU], V.[ImageUrl], B.[BrandName]
        FROM @CartTable CT
        INNER JOIN [dbo].[ProductVariants] V ON CT.[VariantId] = V.[VariantId]
        INNER JOIN [dbo].[Products] P ON V.[ProductId] = P.[ProductId]
        INNER JOIN [dbo].[Brands] B ON P.[BrandId] = B.[BrandId];

        -- Step 3: BULK INVENTORY STOCK LOGGING & DEDUCTION (Set-Based approach instead of slow cursor loops)
        -- Write audit logging updates across altered items inventory lines inside InventoryHistory database records
        INSERT INTO [dbo].[InventoryHistory] ([VariantId], [Type], [QuantityChanged], [OldStock], [NewStock], [Reason], [CreatedBy])
        SELECT 
            V.[VariantId], N'EXPORT', -CT.[Quantity], V.[Stock], (V.[Stock] - CT.[Quantity]), 
            N'Automatic inventory deduction for newly placed Order #' + CAST(@OutOrderId AS VARCHAR(10)), NULL
        FROM [dbo].[ProductVariants] V
        INNER JOIN @CartTable CT ON V.[VariantId] = CT.[VariantId];

        -- Execute structural physical warehouse stock count balance updates on modified variants rows.
        -- Automatically toggle status flags to N'OutOfStock' if product counts hit 0.
        UPDATE V
        SET V.[Stock] = V.[Stock] - CT.[Quantity],
            V.[Status] = CASE WHEN (V.[Stock] - CT.[Quantity]) = 0 THEN N'OutOfStock' ELSE V.[Status] END
        FROM [dbo].[ProductVariants] V
        INNER JOIN @CartTable CT ON V.[VariantId] = CT.[VariantId];

        -- Update cumulative [Sold] historical volume stats tracking within parent master records for dashboards metrics
        UPDATE P
        SET P.[Sold] = P.[Sold] + Agg.[TotalQty]
        FROM [dbo].[Products] P
        INNER JOIN (
            SELECT V.[ProductId], SUM(CT.[Quantity]) AS [TotalQty]
            FROM @CartTable CT
            INNER JOIN [dbo].[ProductVariants] V ON CT.[VariantId] = V.[VariantId]
            GROUP BY V.[ProductId]
        ) Agg ON P.[ProductId] = Agg.[ProductId];

        -- Step 4: Instantiate default clearing records within Payments table.
        -- Create randomized transaction reference index tracking codes and set online payment session expiration window limits to 15 minutes.
        INSERT INTO [dbo].[Payments] 
            ([OrderId], [PaymentMethod], [Amount], [Currency], [TransactionCode], [Status], [ExpiredTime])
        VALUES 
            (@OutOrderId, @PaymentMethod, @TotalAmount, 'VND', 'TXN' + CAST(@OutOrderId AS VARCHAR(10)) + CAST(NEWID() AS VARCHAR(8)), 0, DATEADD(MINUTE, 15, GETDATE()));

        -- Step 5: Update allocation thresholds inside Voucher marketing databases if promo codes are used
        IF (@VoucherId IS NOT NULL)
        BEGIN
            -- Increment voucher application volume trackers. Automatically disable promo entries if allocations are exhausted.
            UPDATE [dbo].[Vouchers]
            SET [UsedQuantity] = [UsedQuantity] + 1,
                [Status] = CASE WHEN [UsedQuantity] + 1 = [Quantity] THEN 0 ELSE [Status] END
            WHERE [VoucherId] = @VoucherId;

            -- Increment usage logging records mapped to the user profile author account
            UPDATE [dbo].[UserVoucher] 
            SET [UsedCount] = [UsedCount] + 1, [LastUsedDate] = GETDATE() 
            WHERE [UserId] = @UserId AND [VoucherId] = @VoucherId;

            -- Create a tracking record if this is the customer's first time using this specific voucher code
            IF @@ROWCOUNT = 0
            BEGIN
                INSERT INTO [dbo].[UserVoucher] ([UserId], [VoucherId], [UsedCount], [LastUsedDate])
                VALUES (@UserId, @VoucherId, 1, GETDATE());
            END
        END

        -- Step 6: Empty the user's online shopping cart items once checkout completes successfully
        DELETE FROM [dbo].[CartItems] WHERE [CartId] = @CartId;

        -- Step 7: Push alert items notifications directly out to customer unread dashboard alerts inbox logs
        DECLARE @NotiTypeId INT;
        SELECT @NotiTypeId = [TypeId] FROM [dbo].[NotificationTypes] WHERE [TypeName] = 'ORDER';

        INSERT INTO [dbo].[Notifications] ([UserId], [NotificationTypeId], [Title], [Content], [Link], [IsRead])
        VALUES (@UserId, @NotiTypeId, N'Order Placed Successfully', N'Order #' + CAST(@OutOrderId AS NVARCHAR(10)) + N' has been successfully created within our commercial system.', N'/order/detail?id=' + CAST(@OutOrderId AS VARCHAR(10)), 0);

        -- Commit changes safely to permanent storage disk arrays if all operations execute without issue
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Intercept any runtime failure, database deadlock, or data anomalies within the try block.
        -- Revert modifications cleanly via transaction ROLLBACK commands to retain full data integrity.
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW; -- Propagate system errors up to calling Java applications to display accurate UI notifications
    END CATCH
END;
GO


/*******************************************************************************
   10. COMPLETE MEGA SEED DATA PACKET (Testing Seeds Verification Datasets)
********************************************************************************/

-- Seed data parameters populating system security permission roles
INSERT INTO [dbo].[Roles] ([RoleName]) VALUES (N'Admin'), (N'Customer'), (N'Staff');
GO

-- Seed data parameters generating foundational profile user entities (Includes sample Bcrypt hashes)
INSERT INTO [dbo].[Users] ([RoleId], [Username], [Password], [PasswordSalt], [FullName], [Email], [Phone], [Gender], [Status], [EmailVerified]) VALUES
(1, 'admin1', '$2a$10$K9g17FbyMhiE3g99Fv78Iu7g7R0b5VOm3kLzE2gHqK1eE8y5B.V0.', 'salt_01', N'Nguyễn Quốc Khang', 'khangnq@mirai.com', '0901234561', N'Nam', 1, 1),
(1, 'admin2', '$2a$10$K9g17FbyMhiE3g99Fv78Iu7g7R0b5VOm3kLzE2gHqK1eE8y5B.V0.', 'salt_02', N'Huỳnh Như Ý', 'ynh@mirai.com', '0901234562', N'Nữ', 1, 1),
(1, 'admin3', '$2a$10$K9g17FbyMhiE3g99Fv78Iu7g7R0b5VOm3kLzE2gHqK1eE8y5B.V0.', 'salt_03', N'Nguyễn Võ Nhật Duy', 'duynvn@mirai.com', '0901234563', N'Nam', 1, 1),
(3, 'staff1', '$2a$10$K9g17FbyMhiE3g99Fv78Iu7g7R0b5VOm3kLzE2gHqK1eE8y5B.V0.', 'salt_04', N'Nguyễn Văn Linh', 'linhnv@mirai.com', '0909998881', N'Nam', 1, 1),
(2, 'customer1', '$2a$10$e0MbgS79Z13U56dE1f2g3uH6u7VOm3kLzE2gHqK1eE8y5B.X1.', 'salt_05', N'Phan Thanh Bình', 'binhpt@gmail.com', '0912345601', N'Nam', 1, 1),
(2, 'customer2', '$2a$10$e0MbgS79Z13U56dE1f2g3uH6u7VOm3kLzE2gHqK1eE8y5B.X1.', 'salt_06', N'Trần Thị Hoa', 'hoatt@gmail.com', '0912345602', N'Nữ', 1, 1),
(2, 'customer3', '$2a$10$e0MbgS79Z13U56dE1f2g3uH6u7VOm3kLzE2gHqK1eE8y5B.X1.', 'salt_07', N'Lê Hoàng Nam', 'namlh@gmail.com', '0912345603', N'Nam', 1, 1);
GO

-- Seed parameters mapping default customer logistics location shipping entries
INSERT INTO [dbo].[Addresses] ([UserId], [ReceiverName], [Phone], [Province], [District], [Ward], [Street], [AddressType], [IsDefault]) VALUES
(5, N'Phan Thanh Bình', '0912345601', N'TP Cần Thơ', N'Quận Ninh Kiều', N'Phường Xuân Khánh', N'30 Tháng 4, Số 123', N'Home', 1),
(6, N'Trần Thị Hoa', '0912345602', N'TP Hồ Chí Minh', N'Quận 1', N'Phường Bến Nghé', N'Nguyễn Huệ, Số 45', N'Home', 1);
GO

-- Seed records generating initial test operational Categories and commercial Brands elements
INSERT INTO [dbo].[Categories] ([CategoryName], [ImageURL], [Description]) VALUES 
(N'Điện thoại', 'cat-phone.png', N'Smartphones cao cấp chính hãng'),
(N'Laptop', 'cat-laptop.png', N'Máy tính xách tay văn phòng, gaming đồ họa');

INSERT INTO [dbo].[Brands] ([BrandName], [Logo], [Country], [Description], [Status]) VALUES 
(N'Apple', 'apple-logo.png', 'USA', N'Hệ sinh thái cao cấp iOS và macOS mượt mà', 1), 
(N'Samsung', 'samsung-logo.png', 'Korea', N'Đổi mới công nghệ liên tục dẫn đầu màn hình gập', 1);
GO

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
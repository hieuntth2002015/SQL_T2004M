﻿CREATE DATABASE Assignment_02
GO
USE Assignment_02
GO

CREATE TABLE Company(
  CompanyCode int PRIMARY KEY,
  CompanyName varchar(10),
  Address varchar(10),
  Phone CHAR(6),
  CONSTRAINT chk_dt CHECK (Phone not like '%[^0-9]%'),
)
GO
CREATE TABLE Product (
  ProductCode int PRIMARY KEY,
  ProductName varchar(50),
  CompanyCode int,
  Descriptions nvarchar(60),
  Unti nvarchar(10),
  Price money,
  Amount int,
  CONSTRAINT fk_sp
  FOREIGN KEY (CompanyCode) 
  REFERENCES Company(CompanyCode)
)
GO

--3. Viết các câu lệnh để thêm dữ liệu vào các bảng
SELECT CompanyCode, CompanyName,  Address varchar, Phone
 FROM Company 
--b) Hiển thị tất cả các sản phẩm.

SELECT ProductCode, ProductName, Descriptions, Unti, Price
FROM Product

--5.Viết các câu lệnh truy vấn để 
--a) Liệt kê danh sách hãng theo thứ thự ngược với alphabet của tên
SELECT * FROM Company
ORDER BY CompanyName DESC
--b) Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
SELECT * FROM Product
ORDER BY Price DESC
--c) Hiển thị thông tin của hãng Asus
SELECT * FROM Company 
WHERE CompanyName = 'Asus'
--d) Liệt kê danh sách sản phẩm còn ít hơn 11 chiếc trong kho
SELECT * FROM Product 
WHERE Amount < 11
--e) Liệt kê danh sách sản phẩm của hãng Asus
--a) Thiết lập chỉ mục (Index) cho các cột sau: Tên hàng và Mô tả hàng để tăng hiệu suất truy vấn
--dữ liệu từ 2 cột này

CREATE INDEX IX_Product
ON Product(ProductName, Descriptions)
EXEC sp_helpindex 'Product'

--b) Viết các View sau:
--◦ View_SanPham: với các cột Mã sản phẩm, Tên sản phẩm, Giá bán
CREATE VIEW View_SanPham as
SELECT ProductCode, ProductName, Price
FROM Product
--View_SanPham_Hang: với các cột Mã SP, Tên sản phẩm, Hãng sản xuấ
CREATE VIEW View_SanPham_Hang AS
SELECT ProductCode, ProductName, CompanyName
FROM Product 
JOIN Company
ON Product.CompanyCode = Company.CompanyCode
--c) Viết các Store Procedure sau:
--◦ SP_SanPham_TenHang: Liệt kê các sản phẩm với tên hãng truyền vào store
 CREATE PROCEDURE SP_SanPham_TenHang
AS 
SELECT * FROM View_SanPham_Hang


EXEC SP_SanPham_TenHang
--SP_SanPham_Gia: Liệt kê các sản phẩm có giá bán lớn hơn hoặc bằng giá bán truyền vào
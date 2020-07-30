CREATE DATABASE BookDream
GO
USE BookDream	
GO

CREATE TABLE Book(
  --Dùng để xác định mỗi cuốn sách là duy nhât.
  BookCode int ,
  --Lưu tiêu đề cuốn sách, không cho phép Null
  BookTitle varchar(100),
  --Tên tác giả, không cho phép Null
  Author varchar(50),
  --Lần xuất bản
  Edition int,
  --Giá bán
  BookPrice money NOT NULL,
  --Số cuốn có trong thư viện
  Copies int,
  CONSTRAINT BookCode_dr PRIMARY KEY (BookCode)
);
GO


CREATE TABLE Member(
  --Dùng để xác định người mượn là duy nhât.
  MemberCode int,
  --Lưu tên người mượn, không cho phép Null
  Name varchar(50),
  --Địa chỉ của người mượn, không cho phép Null
  Address varchar(100),
  --Số điện thoại
  PhoneNumber int
 CONSTRAINT MemberCode_dr PRIMARY KEY (MemberCode)
);
GO



CREATE TABLE IssueDetails(
 --Mã cuốn sách có trong bảng Book
 BookCode int,
 --Mã người mượn có trong bảng Member
 MemberCode int,
 --Ngày mượn sách
 IssueDate datetime NOT NULL,
 --Ngày trả sách
 ReturnDate datetime
);
GO
--Thêm khóa ngoại
ALTER TABLE dbo.IssueDetails ADD CONSTRAINT FK_IssueBook FOREIGN KEY(BookCode) REFERENCES dbo.Book(BookCode)
GO
ALTER TABLE dbo.IssueDetails ADD CONSTRAINT FK_IssueMember FOREIGN KEY(MemberCode) REFERENCES dbo.Member(MemberCode)
GO
--Xóa bỏ các Ràng buộc Khóa ngoại của bảng IssueDetails
ALTER TABLE dbo.IssueDetails DROP CONSTRAINT FK_IssueBook
GO
ALTER TABLE dbo.IssueDetails DROP CONSTRAINT FK_IssueMember
GO

--Xóa bỏ Rnafg buộc Khóa CHính của bảng Member và Book
ALTER TABLE Book
DROP CONSTRAINT BookCode_dr;
GO
ALTER TABLE Member
DROP CONSTRAINT MemberCode_dr;
GO

--Thêm mới Ràng buộc Khóa chính cho bảng Member và Book
ALTER TABLE Book
ADD PRIMARY KEY (BookPrice);
GO
ALTER TABLE Member
ADD PRIMARY KEY (IssueDate);
GO

--Thêm mới các Ràng buộc Khóa ngoại cho bảng IssueDetails
ALTER TABLE Member
ADD IssueDate datetime NOT NULL;
GO

ALTER TABLE dbo.IssueDetails ADD FOREIGN KEY(IssueDate) REFERENCES dbo.Member(IssueDate)
GO

ALTER TABLE IssueDetails
ADD BookPrice money;
GO
ALTER TABLE dbo.IssueDetails ADD FOREIGN KEY(BookPrice) REFERENCES dbo.Book(BookPrice)
GO

--Qua ải thành công sau bao lần deleted

--Bổ sung thêm Ràng buộc giá bán sách > 0 và < 200 

ALTER TABLE Book
ADD CONSTRAINT Book_price CHECK (BookPrice BETWEEN 0 AND 200);

--Bổ sung thêm Ràng buộc duy nhất cho PhoneNumber của bảng Member
ALTER TABLE Member
ADD CONSTRAINT Phone_Number UNIQUE(PhoneNumber);

--Bổ sung thêm ràng buộc NOT NULL cho BookCode, MemberCode trong bảng IssueDetails
ALTER TABLE Book
MODIFY BookCode INT NOT NULL;
ALTER TABLE IssueDetails
MODIFY MemberCode INT NOT NULL;
--Tạo khóa chính gồm 2 cột BookCode, MemberCode cho bảng IssueDetails
ALTER TABLE IssueDetails 
ADD CONSTRAINT PK_TWOPRIMARY PRIMARY KEY(BookCode, MemberCode);
Go
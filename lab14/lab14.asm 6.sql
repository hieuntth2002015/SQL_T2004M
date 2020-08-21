﻿CREATE DATABASE QuanLyKhoSach
GO

USE QuanLyKhoSach
GO

CREATE TABLE Author (
 AuthorID int PRIMARY KEY,
 AuthorName nvarchar(40)
)

CREATE TABLE Publisher (
 PublisherID int PRIMARY KEY,
 PublisherName nvarchar(40),
 Address nvarchar(40)
)

CREATE TABLE Booklist (
 BooklistID int PRIMARY KEY,
 BooklistName nvarchar(40)
)

CREATE TABLE Books(
 BookID varchar(10) PRIMARY KEY,
 BookName nvarchar(40),
 PublishDate int,
 PublisherID int,
 AuthorID int,
 BooklistID int,
 Price money,
 Amount int,
 Timesofpublication int
 CONSTRAINT fk_Publisher FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID),
 CONSTRAINT fk_Author FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
 CONSTRAINT fk_Booklist FOREIGN KEY (BooklistID) REFERENCES Booklist(BooklistID)
)

INSERT INTO Author VALUES  (1, 'Eran Katz'),
                          (2,'Elizabert'),
						  (3, 'RuCak Slim'),
						  (4, 'OrGan SanChetz'),
						  (5, 'Lucas remb')

INSERT INTO Publisher VALUES (11, N'Tri Thức', N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
                             (12, N'Kim Đồng', N'Hà Nội'),
							 (13, N'Kim Dung', N'Trung Quốc'),
							 (14, N'Kim Tinh',N'Hệ Sao'),
							 (15, N'Kim Trục Lưu',N'Phim Cổ Trang Trung Quốc')
INSERT INTO Booklist VALUES (111, N'Khoa Học Xã Hội'),
                            (112, N'Văn Học Dân Gian'),
							(113, N'Võ Học Tưởng Tượng'),
							(114, N'Khoa Học Nasa'),
							(115, N'Võ Thuật Phim Ảnh')
INSERT INTo Books VALUES ('B001', N'Trí Tuệ Do Thái', '2010', 11, 1, 111, 79000, 100, 1),
                         ('C002', N'Dế Mèn phiêu lưu ký', '1941', 12,2, 112, 10000, 1000,1),
						 ('D003', N'Tiếu Ngạo Giang Hồ', '1958', 13,3,113, 250000, 1950, 4),
						 ('E004', N'Thiên thần', '1962', 14,4,114, 120000, 290, 2),
						 ('F005', N'Đường đến sao hỏa', '1995', 15,5,115, 63000, 5000,1)
INSERT INTo Books VALUES ('B002', N'Trí Tuệ Nhân Tạo', '2019', 11,1,111, 200000,1000,5)
--3. Liệt kê các cuốn sách có năm xuất bản từ 1960 đến nay
SELECT BookName 
FROM Books
WHERE PublishDate >= 1960 and PublishDate <= year(getdate())

--4. Liệt kê 5 cuốn sách có giá bán cao nhất
 --SP_Them_Sach: thêm mới một cuốn sách
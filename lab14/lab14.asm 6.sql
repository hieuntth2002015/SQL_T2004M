CREATE DATABASE QuanLyKhoSach
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

--4. Liệt kê 5 cuốn sách có giá bán cao nhấtSELECT TOP(5) BookName, PriceFROM BooksORDER BY Price DESC--5. Tìm những cuốn sách có tiêu đề chứa từ “Văn Học Dân Gian”SELECT BookNameFROM BooksWHERE BooklistID IN (SELECT BooklistID FROMBooklist WHERE BooklistName = N'Văn Học Dân Gian')--6. Liệt kê các cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dầnSELECT BookName,PriceFROM BooksWHERE BookName like'T%'ORDER BY Price DESC--7. Liệt kê các cuốn sách của nhà xuất bản Tri thứcSELECT BookNameFROM BooksWHERE PublisherID IN (SELECT PublisherID FROM PublisherWHERE PublisherName = N'Tri Thức')--8. Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”SELECT PublisherName, AddressFROM PublisherWHERE PublisherID IN (SELECT PublisherIDFROM Books WHERE BookName = N'Trí tuệ Do Thái')--9. Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản, Loại sáchSELECT BookID, BookName, PublishDate, PublisherName, BooklistNameFROM Books as BJOIN Publisher as PON P.PublisherID = B.PublisherIDJOIN Booklist as Blon bl.BooklistID = b.BooklistID--10. Tìm cuốn sách có giá bán đắt nhấtSELECT TOP(1) BookName, PriceFROM BooksORDER BY Price DESC--11. Tìm cuốn sách có số lượng lớn nhất trong khoSELECT TOP(1) BookName, AmountFROM BooksORDER BY Amount DESC--12. Tìm các cuốn sách của tác giả “Eran Katz”SELECT BookName, AuthorNameFROM Books as BJOIN Author as AON A.AuthorID = B.AuthorIDWHERE AuthorName = 'Eran Katz'--13. Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trướcSELECT BookName, Price*1.1as Price10, PublishDateFROM BooksWHERE PublishDate < 2008--14. Thống kê số đầu sách của mỗi nhà xuất bảnSELECT BookName,count(*) as Sum_booksFROM Books as BJOIN Publisher as PON B.PublisherID= P.PublisherIDWHERE PublisherName = N'Tri Thức'GROUP BY BookName --15. Thống kê số đầu sách của mỗi loại sáchSELECT BookName,count(*) as Sum_booksFROM Books as BJOIN Booklist as BlON Bl.BooklistID= B.BooklistIDWHERE BooklistName =  N'Khoa Học Xã Hội'GROUP BY BookName--16. Đặt chỉ mục (Index) cho trường tên sáchCREATE INDEX IX_BooksON Books(BookName)--17. Viết view lấy thông tin gồm: Mã sách, tên sách, tác giả, nhà xb và giá bánCREATE VIEW VIEW_Books AS SELECT BookID, BookName, AuthorName, PublisherName, PriceFROM Books as BJOIN Author as AON A.AuthorID = B.AuthorIDJOIN Booklist as BlON Bl.BooklistID =B.BooklistIDJOIN Publisher as PON P.PublisherID = B.PublisherID--18. Viết Store Procedure:
 --SP_Them_Sach: thêm mới một cuốn sách CREATE PROCEDURE SP_Them_Sach AS  INSERT INTO Books VALUES ('B002', N'Trí Tuệ Nhân Tạo', '2019', 11,1,111, 200000,1000,5) --SP_Tim_Sach: Tìm các cuốn sách theo từ khóa CREATE PROCEDURE SP_Tim_Sach AS  SELECT * FROM VIEW_Books  --SP_Sach_ChuyenMuc: Liệt kê các cuốn sách theo mã chuyên mục CREATE PROCEDURE SP_Sach_ChuyenMuc AS  SELECT BooklistID, BookName  FROM Books --19. Viết trigger không cho phép xóa các cuốn sách vẫn còn trong kho (số lượng > 0)CREATE TRIGGER DELETE_BOOKSON BooksFOR DELETE AS   BEGIN      IF EXISTS (SELECT * FROM deleted WHERE Timesofpublication > 0)	 BEGIN       print 'Không được phép xóa các cuốn sách vẫn còn trong kho (số lượng > 0)'	  ROLLBACK TRANSACTION	  END  ENDINSERT INTo Books VALUES ('B002', N'Trí Tuệ Nhân Tạo', '2019', 11,1,111, 200000,1000,2)DELETE FROM Books WHERE BookID = 'B002'--Viết trigger chỉ cho phép xóa một danh mục sách khi không còn cuốn sách nào thuộc chuyên mục nàyCREATE TRIGGER DELETE_ALLON BooklistFOR DELETE AS   BEGIN      IF EXISTS (SELECT * FROM deleted WHERE BookListID IN(SELECT BookListID FROM Books WHERE Timesofpublication >0))	  BEGIN       print 'chỉ cho phép xóa một danh mục sách khi không còn cuốn sách nào  thuộc chuyên mục này'	  ROLLBACK TRANSACTION	  END  END  
-- Mssv: 23110168
-- Ho ten: Bui Ha Bao Khanh
-- RDBMS: SQL Server
--CREATE DATABASE
CREATE DATABASE csdl_khachsan;
GO
USE csdl_khachsan;

--CREATE TABLE KHACHLUUTRU
CREATE TABLE KHACHLUUTRU (
    SoCC			CHAR(12)		NOT NULL	PRIMARY KEY,         
    Ho				VARCHAR(30)		NOT NULL,                              
    Ten				VARCHAR(15)		NOT NULL,                    
    NgaySinh		DATE,                               
    SoDT			CHAR(10)		NOT NULL                       
);

--CREATE TABLE LOAIPHONG
CREATE TABLE LOAIPHONG(
	LoaiPG			CHAR(1)			NOT NULL	CHECK (LoaiPG IN ('1','2','3') )		PRIMARY KEY,
	DonGia			DECIMAL(10,2)	NOT NULL,
	SoGiuong		INT				NOT NULL	CHECK (SoGiuong BETWEEN 1 AND 3), 
	KieuGiuong		INT				NOT NULL	CHECK (KieuGiuong IN (1, 2))
);

--CREATE TABLE PHONG
CREATE TABLE PHONG(
	SoPG			INT				NOT NULL	PRIMARY KEY,              
    LoaiPG			CHAR(1)			NOT NULL	CHECK (LoaiPG IN ('1','2','3') ),                     
    ViTri			INT				NOT NULL	CHECK (ViTri IN (1, 2, 3)),
    FOREIGN KEY (LoaiPG) REFERENCES LOAIPHONG(LoaiPG)
);

--CREATE TABLE DATPHONG
CREATE TABLE DATPHONG(	
	SoDP			INT				NOT NULL	PRIMARY KEY,              
    SoPG			INT				NOT NULL,                           
    LoaiPG			CHAR(1)			NOT NULL	CHECK (LoaiPG IN ('1','2','3') ),                    
    SoCC			CHAR(12)		NOT NULL,                     
    NgayDat			DATE			NOT NULL,                                -- Ngày đặt
    CachDat			CHAR(1)			NOT NULL	CHECK (CachDat IN ('A', 'C', 'S', 'V')),
    NgayDen			DATE			NOT NULL,                               
    NgayDi			DATE			NOT NULL,                        
    FOREIGN KEY (SoPG) REFERENCES PHONG(SoPG),
    FOREIGN KEY (LoaiPG) REFERENCES LOAIPHONG(LoaiPG),
    FOREIGN KEY (SoCC) REFERENCES KHACHLUUTRU(SoCC)
);

--=============================
--INSERT INTO LOAIPHONG
INSERT INTO LOAIPHONG(LoaiPG,DonGia,SoGiuong,KieuGiuong)
VALUES
(1,	950000,	1,	2),
(2,	800000,	2,	1),
(3,	700000,	2,	1);
GO
--INSERT INTO PHONG
INSERT INTO PHONG(SoPG,LoaiPG,ViTri)
VALUES
(100,	1,	1),
(101,	2,	2),
(102,	3,	3);
GO
--INSERT INTO KHACHLUUTRU
--INSERT INTO KHACHLUUTRU  
INSERT INTO KHACHLUUTRU(SoCC, Ho, Ten, NgaySinh, SoDT)  
VALUES  
('51069001234', 'Le Van', 'Tho', '1969-12-01', '332089600'),  
('51175002342', 'Nguyen Thi', 'Hau', '1975-03-20', '985984434');  
GO  

--INSERT INTO DATPHONG  
INSERT INTO DATPHONG(SoDP, SoPG, LoaiPG, SoCC, NgayDat, CachDat, NgayDen, NgayDi)  
VALUES  
(1, 101, '1', '51069001234', '2024-03-01', 'S', '2024-04-28', '2024-04-30'),  
(2, 102, '3', '51175002342', '2024-04-10', 'V', '2024-04-10', '2024-04-11');  
GO
GO
select * from DATPHONG;
UPDATE DATPHONG
SET 
    NgayDen = DATEADD(DAY, 10, NgayDen),
    NgayDi = DATEADD(DAY, 10, NgayDi)
WHERE SoCC = '51069001234';
select * from DATPHONG;
DELETE FROM DATPHONG
WHERE SoCC IN (
    SELECT SoCC
    FROM KHACHLUUTRU
    WHERE SoDT = '985984434'
);
select * from DATPHONG;
-- Scripts to create database schema
CREATE DATABASE csdl_congty;
GO -- GO is not a SQL standard statement

-- Change the working database to csdl_congty
USE csdl_congty;

-- CREATE TABLE phongban
CREATE TABLE phongban (
	mapb			INT				NOT NULL,
	tenpb			VARCHAR(15) 	NOT NULL,
	maql			CHAR(9)			NOT NULL 
	                                DEFAULT '888665555',
	ngaybonhiem		DATE,
	CONSTRAINT PK_phongban 
	    PRIMARY KEY (mapb),
	CONSTRAINT AK_phongban_tenpb 
	    UNIQUE (tenpb)
);

-- CREATE TABLE truso_phong
CREATE TABLE truso_phong (
	mapb			INT				NOT NULL,
	truso			VARCHAR(50) 	NOT NULL,
	CONSTRAINT PK_truso 
	    PRIMARY KEY (mapb, truso)
);

-- CREATE TABLE nhanvien
CREATE TABLE nhanvien (
	manv			CHAR(9)			NOT NULL,
	honv			VARCHAR(15) 	NOT NULL,
	dem				VARCHAR(15),
	tennv			VARCHAR(15) 	NOT NULL,
	ngaysinh		DATE,
	diachi			VARCHAR(50),
	gioitinh		CHAR			CHECK (gioitinh in ('F', 'f', 'M', 'm')),
	luong			INT,
	mags			CHAR(9),
	mapb			INT				NOT NULL 
	                                DEFAULT 1,
	CONSTRAINT PK_nhanvien 
	    PRIMARY KEY (manv)
);

-- CREATE TABLE duan
CREATE TABLE duan (
	mada			INT				NOT NULL,
	tenda			VARCHAR(30) 	NOT NULL,
	diadiem			VARCHAR(50),
	mapb			INT				NOT NULL,
	CONSTRAINT PK_duan 
	    PRIMARY KEY (mada),
	CONSTRAINT AK_duan_tenda 
	    UNIQUE (tenda)
);

-- CREATE TABLE thamgia
CREATE TABLE thamgia (
	manv			CHAR(9)			NOT NULL,
	mada			INT				NOT NULL,
	sogio			DECIMAL(6,1),
	CONSTRAINT PK_thamgia 
	    PRIMARY KEY (manv, mada)
);

-- CREATE TABLE thannhan
CREATE TABLE thannhan (
	manv			CHAR(9)			NOT NULL,
	tentn			VARCHAR(45)		NOT NULL,
	gioitinh		CHAR			CHECK (gioitinh in ('M', 'm', 'F', 'f')),
	ngaysinh		DATE,
	quanhe			VARCHAR(10),
	CONSTRAINT PK_thannhan 
	    PRIMARY KEY (manv, tentn)
);

-- Add referential constraints for phongban
ALTER TABLE phongban 
    ADD CONSTRAINT FK_phongban_nhanvien 
        FOREIGN KEY (maql) REFERENCES nhanvien (manv);

-- Add referential constraints for truso_phong
ALTER TABLE truso_phong
	ADD CONSTRAINT FK_truso_phongban 
	    FOREIGN KEY (mapb) REFERENCES phongban (mapb);

-- Add referential constraints for nhanvien
ALTER TABLE nhanvien
	ADD CONSTRAINT FK_nhanvien_mags 
	    FOREIGN KEY (mags) REFERENCES nhanvien (manv);
ALTER TABLE nhanvien
	ADD CONSTRAINT FK_nhanvien_phongban 
	    FOREIGN KEY (mapb) REFERENCES phongban (mapb);

-- Add referential constraints for duan
ALTER TABLE duan
    ADD CONSTRAINT FK_duan_phongban 
	    FOREIGN KEY (mapb) REFERENCES phongban (mapb);

-- Add referential constraints for thamgia
ALTER TABLE thamgia	    
	ADD CONSTRAINT FK_thamgia_nhanvien 
	    FOREIGN KEY (manv) REFERENCES nhanvien (manv);
ALTER TABLE thamgia
	ADD CONSTRAINT FK_thamgia_duan 
	    FOREIGN KEY (mada) REFERENCES duan (mada);

-- Add referential constraints for thannhan
ALTER TABLE thannhan
	ADD CONSTRAINT FK_thannhan_nhanvien 
	    FOREIGN KEY (manv) REFERENCES nhanvien (manv);

-- Scripts to update data
-- Off checking referential constraint FK_phongban_nhanvien
ALTER TABLE phongban 
    NOCHECK CONSTRAINT FK_phongban_nhanvien;

-- INSERT tuples INTO phongban
INSERT INTO phongban 
VALUES (5,'Nghien cuu','333445555','1988-05-22'),
	   (4,'Dieu hanh','987654321','1995-01-01'),
	   (1,'Quan ly','888665555','1981-06-19');

-- On checking referential constraint FK_phongban_nhanvien
ALTER TABLE phongban 
    CHECK CONSTRAINT FK_phongban_nhanvien;
	  	  
-- INSERT tuples INTO nhanvien
INSERT INTO nhanvien 
VALUES ('888665555','Le','Van','Bo','1937-11-10','450 Trung Vuong, Ha Noi','M',55000,null,1),
	   ('333445555','Phan','Van','Nghia','1955-12-08','638 Nguyen Van Cu, Q5, TpHCM','M',40000,'888665555',5),
	   ('123456789','Nguyen','Bao','Hung','1965-01-09','731 Tran Hung Dao, Q1, TpHCM','M',30000,'333445555',5),
	   ('666884444','Tran',null,'Nam','1962-09-15','975 Ba Ria Vung Tau','M',38000,'333445555',5),
	   ('453453453','Hoang','Kim','Yen','1972-07-31','543 Mai Thi Luu, Q1, TpHCM','F',25000,'333445555',5),
	   ('987654321','Du','Thi','Hau','1951-06-20','291 Ho Van Hue, QPN, TpHCM','F',43000,'888665555',4),
	   ('999887777','Au',null,'Vuong','1968-07-19','332 Nguyen Thai Hoc, Q1, TpHCM','F',25000,'987654321',4),
	   ('987987987','Nguyen','Van','Giap','1969-03-09','980 Le Hong Phong, Q10, TpHCM','M',25000,'987654321',4);

-- INSERT tuples INTO truso_phong
INSERT INTO truso_phong 
VALUES (1,'Phu Nhuan'),
	   (4,'Go Vap'),
	   (5,'Tan Binh'),
	   (5,'Phu Nhuan'),
	   (5,'Thu Duc');

-- INSERT tuples INTO duan
INSERT INTO duan 
VALUES (1,'San pham X','Tan Binh',5),
	   (2,'San pham Y','Thu Duc',5),
	   (3,'San pham Z','Phu Nhuan',5),
	   (10,'Tin hoc hoa','Go Vap',4),
	   (20,'Tai to chuc','Phu Nhuan',1),
	   (30,'Phuc loi','Go Vap',4);

-- INSERT tuples INTO thamgia
INSERT INTO thamgia 
VALUES ('123456789',1,32.5),
	   ('123456789',2,7.5),
	   ('666884444',3,40),
	   ('453453453',1,20),
	   ('453453453',2,20),
	   ('333445555',2,10),
	   ('333445555',3,10),
	   ('333445555',10,10),
	   ('333445555',20,10),
	   ('999887777',30,30),
	   ('999887777',10,10),
	   ('987987987',10,35),
	   ('987987987',30,5),
	   ('987654321',30,20),
	   ('987654321',20,15),
	   ('888665555',20,null),
	   ('333445555', 1, 5),
	   ('333445555', 30, 5);

-- INSERT tuples INTO thannhan
INSERT INTO thannhan 
VALUES ('333445555','Anh','F','1986-04-05','Con gai'),
	   ('333445555','The','M','1983-10-25','Con trai'),
	   ('333445555','Loi','F','1958-05-03','Vo'),
	   ('987654321','An','M','1942-02-28','Chong'),
	   ('123456789','Minh','M','1988-01-01','Con trai'),
	   ('123456789','Anh','F','1988-12-30','Con gai'),
	   ('123456789','Yen','F','1967-05-05','Vo');
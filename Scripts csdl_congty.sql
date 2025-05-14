-- Scripts to create database schema
CREATE DATABASE csdl_congty;
GO -- GO is not a SQL standard statement

-- Change the working database to csdl_congty
USE csdl_congty;

-- CREATE TABLE phongban
CREATE TABLE phongban (
	mapb			INT				NOT NULL,
	tenpb			VARCHAR(15) 	NOT NULL,
	maql			CHAR(9)			NOT NULL  DEFAULT '888665555',
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

--Q1
select honv,tennv,ngaysinh,gioitinh 
from nhanvien 
where mapb = 5;
--Q2
select * from phongban;
--Q3
select honv,dem,tennv,luong 
from nhanvien
join phongban on phongban.mapb = nhanvien.mapb
where luong between 25000 and 45000 and phongban.tenpb = 'Nghien cuu'
order by luong desc;
--Q4
select * from nhanvien
--where YEAR(ngaysinh) between 1955 and 1969;
where DATEPART(YEAR,ngaysinh) between 1955 and 1969;
--Q5
select * from nhanvien
--where YEAR(getdate()) - YEAR(ngaysinh) >= 60;
where DATEPART(YEAR,CURRENT_TIMESTAMP) - DATEPART(YEAR,ngaysinh) >= 60;
--Q6
SELECT nhanvien.manv,honv,tennv
from nhanvien
left JOIN thannhan ON nhanvien.manv = thannhan.manv
WHERE thannhan.manv is null
ORDER BY nhanvien.tennv, nhanvien.honv;

/*
Chọn và kết
1. Cho biết mã số, họ tên, ngày sinh của các nhân viên phòng số 4.
2. Tìm những nhân viên có mức lương trên 30,000.
3. Tìm những nhân viên có mức lương trên 25,000 ở phòng số 4 hoặc có mức
lương trên 30,000 ở phòng số 5.
4. Cho biết họ tên, ngày sinh, địa chỉ của các nhân viên ở TpHCM.
5. Cho biết ngày sinh, địa chỉ của nhân viên có tên là “Nguyen Bao Hung”.
6. Tìm những nhân viên có địa chỉ thuộc quận “Phu Nhuan”.
7. Tìm những nhân viên sinh vào thập niên 1950.
8. Cho biết các mức lương riêng biệt của các nhân viên.
9. Tìm những nhân viên không có người giám sát.
10.Với mỗi phòng ban, cho biết tên phòng ban và trụ sở của phòng.
11.Với mỗi phòng ban, cho biết tên phòng ban và tên người trưởng phòng.
12.Với mỗi nữ nhân viên, cho biết họ tên và tên người thân của nhân viên đó.
13.Tìm tên và địa chỉ của các nhân viên làm việc trong phòng “Nghien cuu”.
14.Cho biết mã dự án, tên phòng điều phối và họ tên, địa chỉ, ngày sinh của
người trưởng phòng điều phối của các dự án có địa điểm là “Go Vap”.
15.Với mỗi nhân viên, cho biết họ tên của nhân viên và họ tên của người giám
sát nhân viên đó.
16.Cho biết kết quả lương mới của các nhân viên tham gia dự án “San pham
X” nếu như họ được tăng thêm 10% lương.
17.Cho biết họ tên của nhân viên có người thân cùng tên và cùng giới tính với
nhân viên đó.
Gom nhóm, sắp xếp, kết ngoài
18.Cho biết họ tên, mã phòng làm việc của các nhân viên và mã số các dự án
mà họ tham gia, sắp xếp tăng dần theo mã phòng, trong mỗi phòng sắp xếp
theo họ, tên với thứ tự alphabe.
19.Cho biết tổng số nhân viên, mức lương cao nhất, mức lương thấp nhất và
mức lương trung bình của phòng “Nghien cuu”.
20.Với mỗi phòng, cho biết mã số phòng và tổng số nhân viên của phòng đó.
21.Với mỗi phòng, cho biết mã số phòng và mức lương trung bình của các
nhân viên của phòng đó.
22.Với mỗi dự án có nhân viên tham gia, cho biết mã số, tên và tổng số nhân
viên tham gia của dự án đó.
23.Cho biết mã số, tên và tổng số nhân viên tham gia của dự án có nhiều hơn 2
nhân viên tham gia.
6
24.Cho biết mã số, tên và tổng số nhân viên của các phòng có nhiều hơn 5
nhân viên.
25.Với mỗi dự án, cho biết mã số, tên và tổng số nhân viên tham gia của dự án
đó.
26.Với mỗi dự án, cho biết mã số, tên và tổng số nhân viên thuộc phòng số 5
tham gia của dự án đó.
27.Với mỗi nhân viên, cho biết họ tên và tổng số người thân của nhân viên đó.
28.Với mỗi phòng có mức lương trung bình lớn hơn 30,000, cho biết tên
phòng và tổng số nhân viên của phòng đó.
*/


--Cau 1
SELECT manv,tennv,ngaysinh,luong 
from nhanvien  
where mapb = 4;
--Cau 2
Select * from nhanvien where luong > 30000;
--Cau 3
Select * from nhanvien 
where (luong > 25000 and mapb = 4) 
or (luong > 30000 and mapb = 5);
--Cau 4
select honv,ngaysinh,diachi
from nhanvien
where diachi like '%TpHCM';
--Cau 5
select ngaysinh, diachi
from nhanvien
where honv = 'Nguyen' and dem = 'Bao' and tennv = 'Hung';
--Cau 6
select * from nhanvien
where diachi LIKE '%Phu Nhuan%';
--Cau 7
select * from nhanvien
where YEAR(nhanvien.ngaysinh) = 1950;
--Cau 8
select distinct luong from nhanvien;
--Cau 9
select * from nhanvien 
where mags is null;	
--Cau 10
select phongban.tenpb, truso_phong.truso
from phongban
join truso_phong on truso_phong.mapb = phongban.mapb;
--Cau 11
select phongban.tenpb, nhanvien.honv, nhanvien.dem, nhanvien.tennv
from phongban
join nhanvien on nhanvien.manv = phongban.maql;
--Cau 12
select nhanvien.honv, nhanvien.dem, nhanvien.tennv, thannhan.tentn
from nhanvien
join thannhan on nhanvien.manv = thannhan.manv
where nhanvien.gioitinh = 'F' or nhanvien.gioitinh = 'f';
--Cau 13
select nhanvien.honv, nhanvien.dem, nhanvien.tennv, nhanvien.diachi
from nhanvien
join phongban on phongban.mapb = nhanvien.mapb
where phongban.tenpb = 'Nghien cuu';
--Cau 14
select duan.mada, phongban.tenpb, nhanvien.honv, nhanvien.dem, nhanvien.tennv, nhanvien.diachi, nhanvien.ngaysinh
from duan
join phongban on phongban.mapb = duan.mapb
join nhanvien on nhanvien.mapb = phongban.mapb
where duan.diadiem = 'Go Vap' and nhanvien.manv = phongban.maql;
--Cau 15
select nhanvien.honv, nhanvien.dem, nhanvien.tennv, nhanvien2.honv, nhanvien2.dem, nhanvien2.tennv
from nhanvien
inner join nhanvien nhanvien2 on nhanvien.mags = nhanvien2.manv;
select nhanvien.honv, nhanvien.dem, nhanvien.tennv, nhanvien2.honv, nhanvien2.dem, nhanvien2.tennv
from nhanvien
left join nhanvien nhanvien2 on nhanvien.mags = nhanvien2.manv
where nhanvien.mags is not null;
--Cau 16
select nhanvien.manv, nhanvien.luong, nhanvien.luong * 1.1
from nhanvien
join thamgia on thamgia.manv = nhanvien.manv
join duan on thamgia.mada = duan.mada
where duan.tenda = 'San pham X';
--Cau 17
select nhanvien.honv, nhanvien.dem, nhanvien.tennv, thannhan.tentn
from nhanvien
join thannhan on nhanvien.manv = thannhan.manv
where (nhanvien.dem = thannhan.tentn or nhanvien.honv = thannhan.tentn or nhanvien.tennv = thannhan.tentn)  and nhanvien.gioitinh = thannhan.gioitinh;
--Cau 18
SELECT 
honv + 
case
	when dem is null then '' else ' ' + dem + ' ' 
end +
tennv as 'Ho ten',
mapb,
mada
from nhanvien
join thamgia on nhanvien.manv = thamgia.manv
order by nhanvien.mapb, nhanvien.honv, nhanvien.dem;
--Cau 19
select phongban.tenpb, count(nhanvien.manv) as 'Tong so nhan vien', max(nhanvien.luong) as 'Muc luong cao nhat', min(nhanvien.luong) as 'Muc luong thap nhat', avg(nhanvien.luong) as 'Muc luong trung binh'
from phongban
join nhanvien on phongban.mapb = nhanvien.mapb
where phongban.tenpb = 'Nghien cuu'
group by phongban.tenpb;
--Cau 20
select phongban.mapb, count(nhanvien.manv) as 'Tong so nhan vien'
from phongban
where phongban.mapb = nhanvien.mapb
group by phongban.mapb;
--Cau 21
select phongban.mapb, avg(nhanvien.luong) as 'Muc luong trung binh'
from phongban
join nhanvien on phongban.mapb = nhanvien.mapb
group by phongban.mapb;
--Cau 22
select duan.mada, count(thamgia.manv) as 'Tong so nhan vien'
from duan
join thamgia on thamgia.mada = duan.mada
group by duan.mada;
--Cau 23
select duan.mada, count(thamgia.manv) as 'Tong so nhan vien'
from duan
 group by duan.mada
having count(thamgia.manv) > 2;
--Cau 24
select nhanvien.mapb, phongban.tenpb, count(nhanvien.manv) as 'Tong so nhan vien'
from nhanvien 
join phongban on nhanvien.mapb = phongban.mapb
group by nhanvien.mapb, phongban.tenpb
having count(nhanvien.manv) > 3;
--Cau 25
select duan.mada, count(thamgia.manv) as 'Tong so nhan vien'
from duan
join thamgia on thamgia.mada = duan.mada
group by duan.mada;
--Cau 26

/*


Gom nhóm, sắp xếp, kết ngoài 
18. Cho biết họ tên, mã phòng làm việc của các nhân viên và mã số các dự án 
mà họ tham gia, sắp xếp tăng dần theo mã phòng, trong mỗi phòng sắp xếp 
theo họ, tên với thứ tự alphabe. 
19. Cho biết tổng số nhân viên, mức lương cao nhất, mức lương thấp nhất và 
mức lương trung bình của phòng “Nghien cuu”. 
20. Với mỗi phòng, cho biết mã số phòng và tổng số nhân viên của phòng đó. 
21. Với mỗi phòng, cho biết mã số phòng và mức lương trung bình của các 
nhân viên của phòng đó. 
22. Với mỗi dự án có nhân viên tham gia, cho biết mã số, tên và tổng số nhân 
viên tham gia của dự án đó. 
23. Cho biết mã số, tên và tổng số nhân viên tham gia của dự án có nhiều hơn 2 
nhân viên tham gia. 


*/
/*18. Cho biết họ tên, mã phòng làm việc của các nhân viên và mã số các dự án 
mà họ tham gia, sắp xếp tăng dần theo mã phòng, trong mỗi phòng sắp xếp 
theo họ, tên với thứ tự alphabe. */
SELECT nhanvien.honv, nhanvien.dem, nhanvien.tennv, nhanvien.mapb, thamgia.mada
from nhanvien
join thamgia on nhanvien.manv = thamgia.manv
order by nhanvien.mapb, nhanvien.honv, nhanvien.dem;
/*19. Cho biết tổng số nhân viên, mức lương cao nhất, mức lương thấp nhất và
mức lương trung bình của phòng “Nghien cuu”. */
SELECT phongban.tenpb, count(nhanvien.manv) as 'Tong so nhan vien', max(nhanvien.luong) as 'Muc luong cao nhat', min(nhanvien.luong) as 'Muc luong thap nhat', avg(nhanvien.luong) as 'Muc luong trung binh'
from phongban
join nhanvien on phongban.mapb = nhanvien.mapb
where phongban.tenpb = 'Nghien cuu'
group by phongban.tenpb;
/*20. Với mỗi phòng, cho biết mã số phòng và tổng số nhân viên của phòng đó. */         

SELECT phongban.mapb, count(nhanvien.manv) as 'Tong so nhan vien'
from phongban
join nhanvien on phongban.mapb = nhanvien.mapb
group by phongban.mapb;
/*21. Với mỗi phòng, cho biết mã số phòng và mức lương trung bình của các
 nhân viên của phòng đó. */
 SELECT phongban.mapb, avg(nhanvien.luong) as 'Muc luong trung binh'
 from phongban
 join nhanvien on phongban.mapb = nhanvien.mapb
 group by phongban.mapb;
 /*22. Với mỗi dự án có nhân viên tham gia, cho biết mã số, tên và tổng số nhân
 viên tham gia của dự án đó. */
 SELECT duan.mada, count(thamgia.manv) as 'Tong so nhan vien'
 from duan
 join thamgia on thamgia.mada = duan.mada
 group by duan.mada
 having count(thamgia.manv) > 0;		
 /*23. Cho biết mã số, tên và tổng số nhân viên tham gia của dự án có nhiều hơn 2
 nhân viên tham gia. */
SELECT duan.mada, duan.tenda ,count(thamgia.manv) as 'Tong so nhan vien'
from duan
join thamgia on thamgia.mada = duan.mada
group by duan.mada,duan.tenda
having count(thamgia.manv) > 2;
 /*24. Cho biết mã số, tên và tổng số nhân viên của các phòng có nhiều hơn 5
 nhân viên. */

 SELECT phongban.mapb, phongban.tenpb, count(nhanvien.manv) as 'Tong so nhan vien'
 from phongban
 join nhanvien on phongban.mapb = nhanvien.mapb
 group by phongban.mapb, phongban.tenpb
 having count(nhanvien.manv) > 5;
 /*25. Với mỗi dự án, cho biết mã số, tên và tổng số nhân viên tham gia của dự án
 đó. */
 SELECT duan.mada, duan.tenda, count(thamgia.manv) as 'Tong so nhan vien'
 from duan
 join thamgia on thamgia.mada = duan.mada
 group by duan.mada, duan.tenda;
 /*26. Với mỗi dự án, cho biết mã số, tên và tổng số nhân viên thuộc phòng số 5
 tham gia của dự án đó. */

 SELECT duan.mada, duan.tenda, count(thamgia.manv) as 'Tong so nhan vien'
 from duan
 join thamgia on thamgia.mada = duan.mada
 join nhanvien on thamgia.manv = nhanvien.manv
 where nhanvien.mapb = 5
 group by duan.mada, duan.tenda
 having count(thamgia.manv) > 0;
 /*27. Với mỗi nhân viên, cho biết họ tên và tổng số người thân của nhân viên đó. */
 SELECT nhanvien.honv, nhanvien.dem, nhanvien.tennv, count(thannhan.tentn) as 'Tong so nguoi than'
 from nhanvien
 join thannhan on nhanvien.manv = thannhan.manv
 group by nhanvien.honv, nhanvien.dem, nhanvien.tennv;
 /*28. Với mỗi phòng có mức lương trung bình lớn hơn 30,000, cho biết tên
 phòng và tổng số nhân viên của phòng đó. */
 select phongban.tenpb, count(nhanvien.manv) as 'Tong so nhan vien'
 from phongban
 join nhanvien on phongban.mapb = nhanvien.mapb
 group by phongban.tenpb
 having avg(nhanvien.luong) > 30000;

 /*
 Truy vấn lồng 
29. Cho biết tên các dự án có nhân viên tham gia mang họ “Nguyen” hoặc 
người trưởng phòng điều phối mang họ “Nguyen”. 
30. Với mỗi phòng có mức lương trung bình lớn hơn 30,000, cho biết tên 
phòng và tổng số nhân viên nữ của phòng đó. 
31. Cho biết họ tên các nhân viên có trên 2 người thân. 
32. Cho biết họ tên các nhân viên không có người thân nào. 
33. Cho biết họ tên các trưởng phòng có ít nhất một người thân. 
34. Cho biết họ tên các nhân viên có mức lương trên mức lương trung bình của 
phòng “Nghien cuu”. 
35. Cho biết tên phòng và họ tên trưởng phòng của phòng có đông nhân viên 
nhất. 
36. Cho biết họ tên và địa chỉ các nhân viên làm việc cho một dự án ở “Phu	
Nhuan” nhưng phòng mà họ làm việc lại không có trụ sở ở “Phu Nhuan”. 
37. Cho biết họ tên các nhân viên tham gia tất cả các dự án công ty. 
38. Cho biết họ tên các nhân viên tham gia tất cả các dự án do phòng số 5 điều 
phối.
*/
-- Cau 29
select distinct duan.tenda
from duan
join thamgia on thamgia.mada = duan.mada
join nhanvien on thamgia.manv = nhanvien.manv
where nhanvien.honv = 'Nguyen' or duan.mapb in (select phongban.mapb from phongban where phongban.maql = nhanvien.manv);
-- Cau 30
select phongban.tenpb, count(nhanvien.manv) as 'Tong so nhan vien nu'
from phongban
join nhanvien on phongban.mapb = nhanvien.mapb
where nhanvien.gioitinh = 'F' or nhanvien.gioitinh = 'f'
group by phongban.tenpb
having avg(nhanvien.luong) > 30000;
-- Cau 31
select nhanvien.honv, nhanvien.dem, nhanvien.tennv, count(thannhan.tentn) as 'Tong so nguoi than'
from nhanvien
join thannhan on nhanvien.manv = thannhan.manv
group by nhanvien.honv, nhanvien.dem, nhanvien.tennv
having count(thannhan.tentn) > 2;
-- Cau 32
select nhanvien.honv, nhanvien.dem, nhanvien.tennv
from nhanvien
left join thannhan on nhanvien.manv = thannhan.manv
where thannhan.tentn is null;
-- Cau 33
select nhanvien.honv, nhanvien.dem, nhanvien.tennv
from nhanvien
join phongban on phongban.mapb = nhanvien.mapb

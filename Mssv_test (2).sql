-- Mssv: 23110163
-- Ho ten: Nguyen Van Phuc Huy
-- RDBMS: SQL Server
/*
Cho lược đồ cơ sở dữ liệu quan hệ được mô tả như sau: - - - - 
KHACHLUUTRU(SoCC, Ho, Ten, NgaySinh, SoDT) – Lưu thông tin khách lưu trú. 
Mỗi khách lưu trú có số căn cước, họ tên, ngày sinh, số điện thoại. 
LOAIPHONG (LoaiPG, DonGia, SoGiuong, KieuGiuong) – Lưu thông tin về phân 
loại phòng. Mỗi loại phòng có đơn giá, số giường, kiểu giường. Khách sạn có 3 loại 
phòng được xếp loại 1, 2, 3 và loại cao cấp nhất là 1. 
PHONG(SoPG, LoaiPG, ViTri) – Lưu thông tin các phòng. Mỗi phòng có một số 
phòng duy nhất, loại phòng, và vị trí phòng. Vị trí phòng được xếp theo thứ tự 1, 2, 3 
và vị trí tốt nhất là 1. 
DATPHONG(SoDP, SoPG, LoaiPG, SoCC, NgayDat, CachDat, NgayDen, NgayDi) – Lưu thông tin phiếu đặt phòng. Mỗi phiếu đặt phòng có số phòng, loại phòng, số 
căn cước của khách hàng, ngày đặt phòng, cách thức đặt phòng (đại lý - A, điện thoại - C, ứng dụng - S, vãng lai – V), ngày đến, ngày đi. Mỗi phiếu đặt phòng có một số 
phiếu duy nhất.

Thuộc tính Kiểu dữ liệu 
Ràng buộc 
SoCC 
Mô tả 
char(12) 
NOT NULL 
Ho 
Số căn cước của khách lưu trú. 
varchar(30) 
NOT NULL 
Họ của khách lưu trú. 
Ten 
varchar(15) 
NOT NULL 
NgaySinh 
Tên của khách lưu trú. 
date  
SoDT 
Ngày sinh của khách lưu trú. 
char(10) 
NOT NULL 
LoaiPG 
Số điện thoại của khách lưu trú. 
char 
NOT NULL 
(‘1’, ‘2’, ‘3’) 
Xếp loại phòng của phòng. 
DonGia 
decimal(10,2) NOT NULL 
SoGiuong 
Đơn giá của loại phòng. 
int 
NOT NULL 
1  SoGiuong  3 
Số lượng giường của loại phòng. 
KieuGiuong int 
NOT NULL 
(1, 2) 
Kiểu giường (đơn hoặc đôi) của 
loại phòng. 
SoPG 
int 
int 
NOT NULL 
Số phòng. 
ViTri 
NOT NULL 
(1, 2, 3) 
Vị trí của phòng trong khách sạn. 
SoDP 
int 
date 
NOT NULL 
Số phiếu đặt phòng. 
NgayDat 
NOT NULL 
char 
Ngày đặt phòng. 
CachDat 
NOT NULL 
(‘A’, ‘C’, ‘S’, ‘V’) 
Cách thức đặt phòng. 
NgayDen 
date 
date 
NOT NULL 
Ngày nhận phòng. 
NgayDi 
NOT NULL 
Ngày trả phòng.
*/
create database csdl_khachsan;
Go;
use csdl_khachsan

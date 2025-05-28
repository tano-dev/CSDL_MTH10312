CREATE DATABASE csdl_quanlykho;
GO
USE csdl_quanlykho;

CREATE TABLE DANH_MUC (
    MaDanhMuc       CHAR(6)         NOT NULL,
    TenDanhMuc      VARCHAR(50)     NOT NULL,
    MoTa            VARCHAR(200),
    CONSTRAINT PK_DM PRIMARY KEY (MaDanhMuc),
    CONSTRAINT SK_DM UNIQUE (TenDanhMuc)
);

CREATE TABLE SAN_PHAM (
    MaSanPham       CHAR(10)        NOT NULL,
    TenSanPham      VARCHAR(100)    NOT NULL,
    MaDanhMuc       CHAR(6)         NOT NULL,
    DonGia          DECIMAL(10,2)   NOT NULL
                                    CHECK (DonGia >= 0),
    SoLuongTon      INT             NOT NULL
                                    CHECK (SoLuongTon >= 0),
    MucDatLai       INT             NOT NULL
                                    CHECK (MucDatLai >= 0),
    CONSTRAINT PK_SP PRIMARY KEY (MaSanPham),
    CONSTRAINT FK_SP FOREIGN KEY (MaDanhMuc) 
        REFERENCES DANH_MUC (MaDanhMuc)
);

CREATE TABLE NHA_CUNG_CAP (
    MaNhaCungCap    CHAR(8)         NOT NULL,
    TenNhaCungCap   VARCHAR(100)    NOT NULL,
    SoDienThoai     VARCHAR(15)     NOT NULL,
    Email           VARCHAR(50),
    DiaChi          VARCHAR(100),
    CONSTRAINT PK_NCC PRIMARY KEY (MaNhaCungCap),
    CONSTRAINT SK_NCC UNIQUE (Email)
);

CREATE TABLE KHO (
    MaKho           CHAR(6)         NOT NULL,
    TenKho          VARCHAR(50)     NOT NULL,
    DiaDiem         VARCHAR(100)    NOT NULL,
    SucChua         INT             NOT NULL
                                    CHECK (SucChua > 0),
    CONSTRAINT PK_KH PRIMARY KEY (MaKho)
);

CREATE TABLE TON_KHO (
    MaSanPham       CHAR(10)        NOT NULL,
    MaKho           CHAR(6)         NOT NULL,
    SoLuong         INT             NOT NULL
                                    CHECK (SoLuong >= 0),
    CONSTRAINT PK_TK PRIMARY KEY (MaSanPham, MaKho),
    CONSTRAINT FK_TK_SP FOREIGN KEY (MaSanPham) 
        REFERENCES SAN_PHAM (MaSanPham) ON DELETE CASCADE,
    CONSTRAINT FK_TK_KH FOREIGN KEY (MaKho) 
        REFERENCES KHO(MaKho) ON DELETE CASCADE    
);

CREATE TABLE DON_NHAP_HANG (
    MaDonNhap       CHAR(10)        NOT NULL,
    MaNhaCungCap    CHAR(8)         NOT NULL,
    MaKho           CHAR(6)         NOT NULL,
    NgayDatHang     DATE            NOT NULL,
    TongTien        DECIMAL(10,2)   NOT NULL
                                    CHECK (TongTien >= 0),
    TrangThai       CHAR(1)         NOT NULL
                                    CHECK (TrangThai in ('P', 'p', 'R', 'r', 'C', 'c')),
    CONSTRAINT PK_DNH PRIMARY KEY (MaDonNhap),
    CONSTRAINT FK_DNH_NCC FOREIGN KEY (MaNhaCungCap) 
        REFERENCES NHA_CUNG_CAP (MaNhaCungCap),
    CONSTRAINT FK_DNH_KH FOREIGN KEY (MaKho) 
        REFERENCES KHO (MaKho)
);

CREATE TABLE CHI_TIET_DON_NHAP (
    MaDonNhap       CHAR(10)        NOT NULL,
    MaSanPham       CHAR(10)        NOT NULL,
    SoLuong         INT             NOT NULL
                                    CHECK (SoLuong > 0),
    DonGiaNhap      DECIMAL(10,2)   NOT NULL
                                    CHECK (DonGiaNhap >= 0),
    CONSTRAINT PK_CTD PRIMARY KEY (MaDonNhap, MaSanPham),
    CONSTRAINT FK_CTD_DNH FOREIGN KEY (MaDonNhap) 
        REFERENCES DON_NHAP_HANG (MaDonNhap) ON DELETE CASCADE,
    CONSTRAINT FK_CTD_SP FOREIGN KEY (MaSanPham) 
        REFERENCES SAN_PHAM (MaSanPham)
);

CREATE TABLE GIAO_DICH_KHO (
    MaGiaoDich      CHAR(10)        NOT NULL,
    MaSanPham       CHAR(10)        NOT NULL,
    MaKho           CHAR(6)         NOT NULL,
    LoaiGiaoDich    CHAR(10)        NOT NULL
                                    CHECK (LoaiGiaoDich in ('I', 'i', 'O', 'o')),
    SoLuong         INT             NOT NULL
                                    CHECK (SoLuong > 0),
    NgayGiaoDich    DATE            NOT NULL,
    CONSTRAINT PK_GDK PRIMARY KEY (MaGiaoDich),
    CONSTRAINT FK_GDK_SP FOREIGN KEY (MaSanPham) 
        REFERENCES SAN_PHAM (MaSanPham),
    CONSTRAINT FK_GDK_KH FOREIGN KEY (MaKho) 
        REFERENCES KHO (MaKho)
);
INSERT INTO DANH_MUC (MaDanhMuc, TenDanhMuc, MoTa) 
VALUES
    ('CAT001', 'Dien tu', 'Thiet bi va phu kien dien tu'),
    ('CAT002', 'Quan ao', 'Thoi trang va phu kien'),
    ('CAT003', 'Thuc pham', 'San pham thuc pham va do uong');

INSERT INTO SAN_PHAM (MaSanPham, TenSanPham, MaDanhMuc, DonGia, SoLuongTon, MucDatLai) 
VALUES
    -- Dien tu (CAT001)
    ('P00001', 'Dien thoai thong minh X', 'CAT001', 699.99, 20, 10),
    ('P00002', 'May tinh xach tay Pro', 'CAT001', 1299.99, 10, 5),
    ('P00003', 'Tai nghe khong day', 'CAT001', 99.99, 50, 20),
    ('P00004', 'Dong ho thong minh', 'CAT001', 199.99, 20, 10),
    ('P00005', 'May tinh bang 10 inch', 'CAT001', 499.99, 0, 5),
    ('P00006', 'May choi game', 'CAT001', 399.99, 0, 5),
    ('P00007', 'Man hinh LED', 'CAT001', 249.99, 0, 5),
    ('P00008', 'Loa Bluetooth', 'CAT001', 79.99, 0, 15),
    ('P00009', 'Sac USB', 'CAT001', 19.99, 100, 50),
    ('P00010', 'Cap HDMI', 'CAT001', 9.99, 0, 30),
    -- Quan ao (CAT002)
    ('P00011', 'Ao thun nam', 'CAT002', 29.99, 100, 20),
    ('P00012', 'Quan jeans nu', 'CAT002', 59.99, 0, 15),
    ('P00013', 'Ao khoac co mu', 'CAT002', 79.99, 0, 10),
    ('P00014', 'Giay the thao', 'CAT002', 89.99, 50, 10),
    ('P00015', 'Ao so mi', 'CAT002', 49.99, 0, 15),
    ('P00016', 'Ao len', 'CAT002', 69.99, 0, 10),
    ('P00017', 'Goi tat', 'CAT002', 14.99, 0, 30),
    ('P00018', 'Khan quang', 'CAT002', 19.99, 0, 20),
    ('P00019', 'Mu', 'CAT002', 24.99, 0, 25),
    ('P00020', 'That lung', 'CAT002', 34.99, 0, 15),
    -- Thuc pham (CAT003)
    ('P00021', 'Gao 5kg', 'CAT003', 14.99, 100, 50),
    ('P00022', 'Ca hop', 'CAT003', 2.99, 900, 100),
    ('P00023', 'Dau olive 1L', 'CAT003', 9.99, 0, 20),
    ('P00024', 'Mi Y 500g', 'CAT003', 1.99, 500, 50),
    ('P00025', 'Ca phe hat 1kg', 'CAT003', 19.99, 0, 15),
    ('P00026', 'Ngu coc hop', 'CAT003', 4.99, 0, 30),
    ('P00027', 'Sua hop 1L', 'CAT003', 1.49, 700, 100),
    ('P00028', 'Duong 1kg', 'CAT003', 2.49, 0, 40),
    ('P00029', 'Banh quy goi', 'CAT003', 3.99, 0, 30),
    ('P00030', 'Tra tui loc 100g', 'CAT003', 5.99, 400, 20);

INSERT INTO NHA_CUNG_CAP (MaNhaCungCap, TenNhaCungCap, SoDienThoai, Email, DiaChi) 
VALUES
    ('SUP001', 'Cong ty Cong nghe Moi', '0901234567', 'lienhe@congnghemoi.com', '123 Duong Dinh Nghe, Ha Noi'),
    ('SUP002', 'Trung tam Thoi trang', '0912345678', 'banhang@thoitrang.com', '456 Nguyen Trai, TP HCM'),
    ('SUP003', 'Tap doan Thuc pham', '0923456789', 'thongtin@thucpham.com', '789 Duong Quang Ham, Da Nang'),
    ('SUP004', 'The gioi Do choi', '0934567890', 'hotro@dochoi.com', '101 Hai Ba Trung, Ha Noi'),
    ('SUP005', 'Cong ty Phong cach', '0945678901', 'banhang@phongcach.com', '202 Duong Ba Trac, TP HCM'),
    ('SUP006', 'Sieu thi Sach', '0956789012', 'hotro@sieuthisach.com', '303 Duong Quang Ham, Da Nang');

INSERT INTO KHO (MaKho, TenKho, DiaDiem, SucChua) 
VALUES
    ('WH001', 'Kho Hoan Kiem', 'Ha Noi', 10000),
    ('WH002', 'Kho Nam Sai Gon', 'TP Ho Chi Minh', 8000),
    ('WH003', 'Kho Trung tam', 'Da Nang', 6000);

INSERT INTO TON_KHO (MaSanPham, MaKho, SoLuong) 
VALUES
    -- Dien tu (P00001 to P00010)
    ('P00001', 'WH001', 20), 
    ('P00002', 'WH001', 10), 
    ('P00003', 'WH001', 50), 
    ('P00004', 'WH001', 20), 
    ('P00009', 'WH001', 100), 
    -- Quan ao (P00011 to P00020)
    ('P00011', 'WH002', 100),
    ('P00014', 'WH002', 50),
    -- Thuc pham (P00021 to P00030)
    ('P00021', 'WH001', 100), 
    ('P00022', 'WH002', 300), 
    ('P00022', 'WH003', 600),
    ('P00024', 'WH003', 500),
    ('P00027', 'WH003', 700),
    ('P00030', 'WH001', 200), 
    ('P00030', 'WH003', 100),
    ('P00030', 'WH002', 100);

INSERT INTO DON_NHAP_HANG (MaDonNhap, MaNhaCungCap, MaKho, NgayDatHang, TongTien, TrangThai) 
VALUES
    ('PO0001', 'SUP001', 'WH001', '2025-05-01', 20998.30, 'R'), -- Dien tu
    ('PO0002', 'SUP002', 'WH002', '2025-05-05', 5998.50, 'R'), -- Quan ao
    ('PO0003', 'SUP003', 'WH003', '2025-05-10', 2985.00, 'P'), -- Thuc pham
    ('PO0004', 'SUP004', 'WH001', '2025-05-15', 15999.70, 'R'), -- Dien tu
    ('PO0005', 'SUP006', 'WH002', '2025-05-20', 4493.00, 'P'), -- Thuc pham    
    ('PO0006', 'SUP005', 'WH002', '2025-05-22', 2398.90, 'C'), -- Quan ao
    ('PO0007', 'SUP006', 'WH003', '2025-05-24', 1497.00, 'C'), -- Thuc pham
    ('PO0008', 'SUP006', 'WH001', '2025-05-25', 2497.00, 'R'), -- Thuc pham
    ('PO0009', 'SUP006', 'WH002', '2025-05-25', 1940.00, 'R'), -- Thuc pham
    ('PO0010', 'SUP006', 'WH003', '2025-05-25', 1494.00, 'R'), -- Thuc pham
    ('PO0011', 'SUP006', 'WH003', '2025-05-25', 1044.00, 'P'), -- Thuc pham
    ('PO0012', 'SUP006', 'WH002', '2025-05-25', 499.00, 'R'); -- Thuc pham

INSERT INTO CHI_TIET_DON_NHAP (MaDonNhap, MaSanPham, SoLuong, DonGiaNhap) 
VALUES
    -- PO0001 (Dien tu, SUP001, WH001, R)
    ('PO0001', 'P00001', 20, 699.99), -- Dien thoai thong minh X: 20 * 699.99 = 13999.80
    ('PO0001', 'P00003', 50, 99.99),  -- Tai nghe khong day: 50 * 99.99 = 4999.50
    ('PO0001', 'P00009', 100, 19.99), -- Sac USB: 100 * 19.99 = 1999.00
    -- PO0002 (Quan ao, SUP002, WH002, R)
    ('PO0002', 'P00011', 100, 29.99), -- Ao thun nam: 100 * 29.99 = 299.90
    ('PO0002', 'P00014', 50, 59.99),  -- Giay the thao: 50 *59.99 = 2999.50
    -- PO0003 (Thuc pham, SUP003, WH003, P)
    ('PO0003', 'P00022', 500, 2.99),  -- Ca hop: 500 * 2.99 = 1495.00
    ('PO0003', 'P00027', 1000, 1.49), -- Sua hop: 1000 * 1.49 = 1490.00
    -- PO0004 (Dien tu, SUP004, WH001, R)
    ('PO0004', 'P00002', 10, 1299.99), -- May tinh xach tay Pro: 10 * 1299.99 = 12999.90
    ('PO0004', 'P00004', 20, 149.99),  -- Dong ho thong minh: 20 * 149.99 = 2999.80
    -- PO0005 (Thuc pham, SUP006, WH002, P)
    ('PO0005', 'P00021', 200, 14.99),  -- Gao 5kg: 200 * 14.99 = 2998.00
    ('PO0005', 'P00024', 500, 2.99),   -- Mi y 500g: 500 * 2.99 = 1495.00
    -- PO0006 (Quan ao, SUP005, WH002, C)
    ('PO0006', 'P00012', 50, 29.99), -- Quan jeans nu: 50 * 29.99 = 1499.50
    ('PO0006', 'P00018', 60, 14.99), -- Khan quang: 60 * 14.99 = 899.40
    -- PO0007 (Thuc pham, SUP006, WH003, C)
    ('PO0007', 'P00023', 50, 9.99),  -- Dau olive 1L: 50 * 9.99 = 499.50
    ('PO0007', 'P00029', 250, 3.99), -- Banh quy goi: 250 * 3.99 = 997.50    
    -- PO0008 (Thuc pham, SUP006, WH001, R)
    ('PO0008', 'P00021', 100, 14.99), -- Gao 5kg: 100 * 14.99 = 1499.00
    ('PO0008', 'P00030', 200, 4.99),  -- Tra tui loc 100g: 200 * 4.99 = 998.00
    -- PO0009 (Thuc pham, SUP006, WH002, R)
    ('PO0009', 'P00022', 300, 2.99),  -- Ca hop: 300 * 2.99 = 897.00
    ('PO0009', 'P00027', 700, 1.49),  -- Sua hop 1L: 700 * 1.49 = 1043.00
    -- PO0010 (Thuc pham, SUP006, WH003, R)
    ('PO0010', 'P00024', 500, 1.99),  -- Mi y 500g: 500 * 1.99 = 995.00
    ('PO0010', 'P00030', 100, 4.99),  -- Tra tui loc 100g: 100 * 4.99 = 499.00
    -- PO0011 (Thuc pham, SUP006, WH003, P)
    ('PO0011', 'P00022', 100, 2.99),  -- Ca hop: 100 * 2.99 = 299.00
    ('PO0011', 'P00027', 500, 1.49),  -- Sua hop 1L: 500 * 1.49 = 745.00
    -- PO0012 (Thuc pham, SUP006, WH002, R)
    ('PO0012', 'P00030', 100, 4.99);  -- Tra tui loc 100g: 100 * 4.99 = 499.00

INSERT INTO GIAO_DICH_KHO (MaGiaoDich, MaSanPham, MaKho, LoaiGiaoDich, SoLuong, NgayGiaoDich) 
VALUES
    -- PO0001 (R, WH001)
    ('TX0001', 'P00001', 'WH001', 'I', 20, '2025-05-01'), -- Dien thoai thong minh X
    ('TX0002', 'P00003', 'WH001', 'I', 50, '2025-05-01'), -- Tai nghe khong day
    ('TX0003', 'P00009', 'WH001', 'I', 100, '2025-05-01'), -- Sac USB
    -- PO0002 (R, WH002)
    ('TX0004', 'P00011', 'WH002', 'I', 100, '2025-05-05'), -- Ao thun nam
    ('TX0005', 'P00014', 'WH002', 'I', 50, '2025-05-05'), -- Giay the thao
    -- PO0004 (R, WH001)
    ('TX0006', 'P00002', 'WH001', 'I', 10, '2025-05-15'), -- May tinh xach tay Pro
    ('TX0007', 'P00004', 'WH001', 'I', 20, '2025-05-15'), -- Dong ho thong minh
    -- PO0008 (R, WH001)
    ('TX0008', 'P00021', 'WH001', 'I', 100, '2025-05-25'), -- Gao 5kg
    ('TX0009', 'P00030', 'WH001', 'I', 200, '2025-05-25'), -- Tra tui loc 100g
    -- PO0009 (R, WH002)
    ('TX0010', 'P00022', 'WH002', 'I', 300, '2025-05-25'), -- Ca hop
    ('TX0011', 'P00027', 'WH002', 'I', 700, '2025-05-25'), -- Sua hop 1L
    -- PO0010 (R, WH003)
    ('TX0012', 'P00024', 'WH003', 'I', 500, '2025-05-25'), -- Mi y 500g
    ('TX0013', 'P00030', 'WH003', 'I', 100, '2025-05-25'), -- Tra tui loc 100g
    -- PO0012 (R, WH002)
    ('TX0014', 'P00030', 'WH002', 'I', 100, '2025-05-25'); -- Tra tui loc 100g    



/*
1.    Lập danh sách mã số, tên và số lượng tồn kho của tất cả các sản phẩm có số lượng tồn kho dưới 100.
2.    Lập danh sách các đơn nhập hàng đã nhận từ nhà cung cấp Sieu thi Sach.
3.    Lập danh sách mã số, tên và số lượng các sản phẩm thuộc danh mục Dien tu có số lượng tại kho WH001 lớn hơn 50 đơn vị.
4.    Lập danh sách mã số, tên, mã danh mục của các sản phẩm trong kho WH002 có số lượng trên 50, sắp xếp theo số lượng giảm dần.
5.    Lập danh sách tên sản phẩm, số lượng, đơn giá và tên kho của các sản phẩm thuộc danh mục CAT003, sắp xếp theo tên kho tăng dần, theo số lượng giảm dần.
6.    Lập danh sách tên danh mục và tổng số lượng tồn kho của các sản phẩm thuộc danh mục.
7.    Lập danh sách các nhà cung cấp có tổng giá trị hàng nhập (dựa trên SoLuong * DonGiaNhap từ các đơn nhập hàng có trạng thái là R) trong tháng 5/2025 lớn 5000. Danh sách gồm các thông tin mã số, tên nhà cung cấp và tổng giá trị hàng nhập.

8.    Lập danh sách mã số, tên và số lượng các sản phẩm có số lượng tại kho WH001 lớn hơn mức trung bình của tất cả các sản phẩm tại kho WH001.

9.    Lập danh sách các kho có tổng số lượng sản phẩm đã nhập lớn hơn số lượng tồn kho trung bình của tất cả sản phẩm trong danh mục Thuc pham. Danh sách gồm các thông tin mã số kho, tên kho và tổng số lượng sản phẩm đã nhập.
10.    Lập danh sách các danh mục sản phẩm có tổng giá trị hàng nhập (dựa trên SoLuong * DonGiaNhap của các đơn nhập hàng có trạng thái là R) trong tháng 5/2025 lớn hơn mức trung bình trong cùng tháng của tất cả các danh mục. Danh sách gồm các thông tin mã danh mục, tên danh mục, tổng giá trị hàng nhập.
*/
--1
-- 1. Lập danh sách mã số, tên và số lượng tồn kho của tất cả các sản phẩm có số lượng tồn kho dưới 100.
SELECT 
    MaSanPham,
    TenSanPham,
    SoLuongTon
FROM SAN_PHAM
WHERE SoLuongTon < 100;
-- 2. Lập danh sách các đơn nhập hàng đã nhận từ nhà cung cấp Sieu thi Sach.
SELECT 
    dnh.MaDonNhap,
    dnh.MaNhaCungCap,
    dnh.MaKho,
    dnh.NgayDatHang,
    dnh.TongTien,
    dnh.TrangThai
FROM DON_NHAP_HANG AS dnh
JOIN NHA_CUNG_CAP AS ncc 
  ON dnh.MaNhaCungCap = ncc.MaNhaCungCap
WHERE ncc.TenNhaCungCap = 'Sieu thi Sach'
  AND UPPER(dnh.TrangThai) = 'R';
  -- 3. Lập danh sách mã số, tên và số lượng các sản phẩm thuộc danh mục Dien tu có số lượng tại kho WH001 > 50.
SELECT 
    sp.MaSanPham,
    sp.TenSanPham,
    tk.SoLuong
FROM TON_KHO AS tk
JOIN SAN_PHAM AS sp 
  ON tk.MaSanPham = sp.MaSanPham
WHERE sp.MaDanhMuc = 'CAT001'    -- Dien tu
  AND tk.MaKho = 'WH001'
  AND tk.SoLuong > 50;

  -- 4. Lập danh sách mã số, tên, mã danh mục của các sản phẩm trong kho WH002 có số lượng trên 50, sắp xếp theo số lượng giảm dần.
SELECT 
    sp.MaSanPham,
    sp.TenSanPham,
    sp.MaDanhMuc,
    tk.SoLuong
FROM TON_KHO AS tk
JOIN SAN_PHAM AS sp 
  ON tk.MaSanPham = sp.MaSanPham
WHERE tk.MaKho = 'WH002'
  AND tk.SoLuong > 50
ORDER BY tk.SoLuong DESC;
-- 5. Lập danh sách tên sản phẩm, số lượng, đơn giá và tên kho của các sản phẩm thuộc danh mục CAT003,
--    sắp xếp theo tên kho tăng dần, theo số lượng giảm dần.
SELECT 
    sp.TenSanPham,
    tk.SoLuong,
    sp.DonGia,
    k.TenKho
FROM TON_KHO AS tk
JOIN SAN_PHAM AS sp 
  ON tk.MaSanPham = sp.MaSanPham
JOIN KHO AS k 
  ON tk.MaKho = k.MaKho
WHERE sp.MaDanhMuc = 'CAT003'
ORDER BY k.TenKho ASC,
         tk.SoLuong DESC;
         -- 6. Lập danh sách tên danh mục và tổng số lượng tồn kho của các sản phẩm thuộc từng danh mục.
SELECT 
    dm.TenDanhMuc,
    SUM(sp.SoLuongTon) AS TongSoLuongTon
FROM DANH_MUC AS dm
LEFT JOIN SAN_PHAM AS sp 
  ON dm.MaDanhMuc = sp.MaDanhMuc
GROUP BY dm.TenDanhMuc;
-- 7. Lập danh sách các nhà cung cấp có tổng giá trị hàng nhập (SoLuong * DonGiaNhap) 
--    từ các đơn nhập hàng có trạng thái R trong tháng 5/2025 > 5000.
--    Kết quả gồm mã NCC, tên NCC và tổng giá trị.
SELECT 
    ncc.MaNhaCungCap,
    ncc.TenNhaCungCap,
    SUM(ct.SoLuong * ct.DonGiaNhap) AS TongGiaTri
FROM DON_NHAP_HANG AS dnh
JOIN CHI_TIET_DON_NHAP AS ct 
  ON dnh.MaDonNhap = ct.MaDonNhap
JOIN NHA_CUNG_CAP AS ncc 
  ON dnh.MaNhaCungCap = ncc.MaNhaCungCap
WHERE UPPER(dnh.TrangThai) = 'R'
  AND dnh.NgayDatHang BETWEEN '2025-05-01' AND '2025-05-31'
GROUP BY ncc.MaNhaCungCap, ncc.TenNhaCungCap
HAVING SUM(ct.SoLuong * ct.DonGiaNhap) > 5000;
-- 8. Lập danh sách mã số, tên và số lượng các sản phẩm có số lượng tại kho WH001 lớn hơn
--    mức trung bình của tất cả các sản phẩm tại kho WH001.
SELECT 
    sp.MaSanPham,
    sp.TenSanPham,
    tk.SoLuong
FROM TON_KHO AS tk
JOIN SAN_PHAM AS sp 
  ON tk.MaSanPham = sp.MaSanPham
WHERE tk.MaKho = 'WH001'
  AND tk.SoLuong > (
    SELECT AVG(SoLuong)
    FROM TON_KHO
    WHERE MaKho = 'WH001'
);
-- 9. Lập danh sách các kho có tổng số lượng sản phẩm đã nhập (GIAO_DICH_KHO Loai='I')
--    lớn hơn số lượng tồn kho trung bình của tất cả sản phẩm trong danh mục Thuc pham.
--    Kết quả gồm mã kho, tên kho và tổng số lượng đã nhập.
SELECT 
    k.MaKho,
    k.TenKho,
    SUM(gdk.SoLuong) AS TongSoNhap
FROM GIAO_DICH_KHO AS gdk
JOIN KHO AS k 
  ON gdk.MaKho = k.MaKho
WHERE UPPER(gdk.LoaiGiaoDich) = 'I'
GROUP BY k.MaKho, k.TenKho
HAVING SUM(gdk.SoLuong) > (
    SELECT AVG(SoLuongTon)
    FROM SAN_PHAM
    WHERE MaDanhMuc = 'CAT003'
);
-- 10. Lập danh sách các danh mục có tổng giá trị hàng nhập (SoLuong * DonGiaNhap) 
--     từ đơn nhập R trong tháng 5/2025 lớn hơn mức trung bình của tất cả các danh mục
--     trong cùng tháng. Kết quả gồm mã DM, tên DM và tổng giá trị.
WITH CategoryValues AS (
    SELECT 
        dm.MaDanhMuc,
        SUM(ct.SoLuong * ct.DonGiaNhap) AS GiaTri
    FROM DON_NHAP_HANG AS dnh
    JOIN CHI_TIET_DON_NHAP AS ct 
      ON dnh.MaDonNhap = ct.MaDonNhap
    JOIN SAN_PHAM AS sp 
      ON ct.MaSanPham = sp.MaSanPham
    JOIN DANH_MUC AS dm 
      ON sp.MaDanhMuc = dm.MaDanhMuc
    WHERE UPPER(dnh.TrangThai) = 'R'
      AND dnh.NgayDatHang BETWEEN '2025-05-01' AND '2025-05-31'
    GROUP BY dm.MaDanhMuc
)
SELECT 
    cv.MaDanhMuc,
    dm.TenDanhMuc,
    cv.GiaTri AS TongGiaTri
FROM CategoryValues AS cv
JOIN DANH_MUC AS dm 
  ON cv.MaDanhMuc = dm.MaDanhMuc
WHERE cv.GiaTri > (
    SELECT AVG(GiaTri)
    FROM CategoryValues
);


--cau 1
select sp.MaSanPham, sp.TenSanPham, sp.SoLuongTon
from SAN_PHAM as sp
where sp.SoLuongTon < 100;
--cau 2
select * from DON_NHAP_HANG as dnh
join NHA_CUNG_CAP as ncc on ncc.MaNhaCungCap = dnh.MaNhaCungCap
where ncc.TenNhaCungCap = 'Sieu thi Sach' and dnh.TrangThai = 'R';
--cau 3
select SAN_PHAM.MaSanPham, SAN_PHAM.TenSanPham, TON_KHO.SoLuong
from SAN_PHAM
join TON_KHO on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
join DANH_MUC on DANH_MUC.MaDanhMuc = SAN_PHAM.MaDanhMuc
where DANH_MUC.TenDanhMuc = 'Dien tu' and TON_KHO.MaKho = 'WH001' and TON_KHO.SoLuong > 50;
--cau 4
select SAN_PHAM.MaSanPham, SAN_PHAM.TenSanPham,SAN_PHAM.MaDanhMuc
from SAN_PHAM
join TON_KHO on  TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where TON_KHO.MaKho = 'WH002' AND TON_KHO.SoLuong  > 50
order by TON_KHO.SoLuong desc
--cau 5
select SAN_PHAM.TenSanPham, TON_KHO.SoLuong, SAN_PHAM.DonGia, KHO.TenKho
FROM SAN_PHAM
JOIN TON_KHO ON TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
JOIN KHO ON KHO.MaKho = TON_KHO.MaKho
where SAN_PHAM.MaDanhMuc = 'CAT003'
order by KHO.TenKho asc, TON_KHO.SoLuong desc;
--cau 6
select DANH_MUC.TenDanhMuc, SUM(SAN_PHAM.SoLuongTon) as 'tong san pham'
from DANH_MUC
join SAN_PHAM on SAN_PHAM.MaDanhMuc = DANH_MUC.MaDanhMuc
group by DANH_MUC.TenDanhMuc;
--cau 7
select NHA_CUNG_CAP.MaNhaCungCap,NHA_CUNG_CAP.TenNhaCungCap, sum(CHI_TIET_DON_NHAP.SoLuong * CHI_TIET_DON_NHAP.DonGiaNhap) as 'tong gia tri hang nhap'
from NHA_CUNG_CAP
join DON_NHAP_HANG on DON_NHAP_HANG.MaNhaCungCap = NHA_CUNG_CAP.MaNhaCungCap
join CHI_TIET_DON_NHAP on CHI_TIET_DON_NHAP.MaDonNhap = DON_NHAP_HANG.MaDonNhap
where DON_NHAP_HANG.TrangThai = 'R' and (year(DON_NHAP_HANG.NgayDatHang) = 2025 and month(DON_NHAP_HANG.NgayDatHang) = 5)
group by NHA_CUNG_CAP.MaNhaCungCap,NHA_CUNG_CAP.TenNhaCungCap
having sum(CHI_TIET_DON_NHAP.SoLuong * CHI_TIET_DON_NHAP.DonGiaNhap) > 5000;
--cau 8
select SAN_PHAM.MaSanPham,SAN_PHAM.TenSanPham,TON_KHO.SoLuong
from SAN_PHAM
join TON_KHO on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where TON_KHO.MaKho = 'WH001' and TON_KHO.SoLuong > (
select AVG(TON_KHO.SoLuong)
FROM TON_KHO 
WHERE TON_KHO.MaKho = 'WH001')
--CAU 9
select KHO.MaKho,KHO.TenKho, SUM(GIAO_DICH_KHO.SoLuong) as TongSoLuongDaNhap
from KHO
join GIAO_DICH_KHO on GIAO_DICH_KHO.MaKho = KHO.MaKho
where GIAO_DICH_KHO.LoaiGiaoDich = 'I'
group by KHO.MaKho,KHO.TenKho
having SUM(GIAO_DICH_KHO.SoLuong)  > (
select AVG(SAN_PHAM.SoLuongTon) from SAN_PHAM 
join DANH_MUC on  DANH_MUC.MaDanhMuc = SAN_PHAM.MaDanhMuc
where DANH_MUC.TenDanhMuc = 'Thuc pham');
--cau 10
SELECT
  cv.MaDanhMuc,
  dm.TenDanhMuc,
  cv.TongGiaTri
FROM (
    SELECT
      sp.MaDanhMuc,
      SUM(ct.SoLuong * ct.DonGiaNhap) AS TongGiaTri
    FROM CHI_TIET_DON_NHAP AS ct
    JOIN DON_NHAP_HANG AS dnh 
      ON dnh.MaDonNhap = ct.MaDonNhap
    JOIN SAN_PHAM AS sp 
      ON sp.MaSanPham = ct.MaSanPham
    WHERE UPPER(dnh.TrangThai) = 'R'
      AND YEAR(dnh.NgayDatHang) = 2025
      AND MONTH(dnh.NgayDatHang) = 5
    GROUP BY sp.MaDanhMuc
) AS cv
JOIN DANH_MUC AS dm 
  ON dm.MaDanhMuc = cv.MaDanhMuc
WHERE cv.TongGiaTri > (
    SELECT AVG(TongGiaTri)
    FROM (
        SELECT
          sp1.MaDanhMuc,
          SUM(ct1.SoLuong * ct1.DonGiaNhap) AS TongGiaTri
        FROM CHI_TIET_DON_NHAP AS ct1
        JOIN DON_NHAP_HANG AS dnh1 
          ON dnh1.MaDonNhap = ct1.MaDonNhap
        JOIN SAN_PHAM AS sp1 
          ON sp1.MaSanPham = ct1.MaSanPham
        WHERE UPPER(dnh1.TrangThai) = 'R'
          AND YEAR(dnh1.NgayDatHang) = 2025
          AND MONTH(dnh1.NgayDatHang) = 5
        GROUP BY sp1.MaDanhMuc
    ) AS t
);


use csdl_quanlykho
go

-- 1/ Lập danh sách mã số, tên và số lượng tồn kho của tất cả các sản phẩm có số lượng tồn kho dưới 100.
SELECT SP.MaSanPham, SP.TenSanPham, TK.SoLuong
FROM TON_KHO AS TK
JOIN SAN_PHAM AS SP ON SP.MaSanPham = TK.MaSanPham
WHERE TK.SoLuong <100
GO

-- 2/ Lập danh sách các đơn nhập hàng đã nhận từ nhà cung cấp Sieu thi Sach.
SELECT *
FROM DON_NHAP_HANG AS DNH
JOIN NHA_CUNG_CAP AS NCC ON DNH.MaNhaCungCap = NCC.MaNhaCungCap
WHERE NCC.TenNhaCungCap = 'Sieu thi Sach' AND DNH.TrangThai = 'R'
GO

-- 3/ Lập danh sách mã số, tên và số lượng các sản phẩm thuộc danh mục Dien tu có số lượng tại kho WH001 lớn hơn 50 đơn vị.
SELECT TK.MaSanPham, TK.SoLuong, SP.TenSanPham
FROM SAN_PHAM AS SP
JOIN TON_KHO AS TK ON TK.MaSanPham = SP.MaSanPham
JOIN DANH_MUC AS DM ON DM.MaDanhMuc = SP.MaDanhMuc
WHERE TK.MAKHO = 'WH001' AND TK.SoLuong > 50 AND  DM.TenDanhMuc = 'Dien tu'
GO

-- 4/ Lập danh sách mã số, tên, mã danh mục của các sản phẩm trong kho WH002 có số lượng trên 50, sắp xếp theo số lượng giảm dần.
SELECT SP.MaSanPham, SP.TenSanPham, SP.MaDanhMuc
FROM SAN_PHAM AS SP
JOIN TON_KHO AS TK ON TK.MaSanPham = SP.MaSanPham 
WHERE TK.MaKho = 'WH002' AND SP.SoLuongTon > 50
ORDER BY SP.SoLuongTon DESC

-- 5/ Lập danh sách tên sản phẩm, số lượng, đơn giá và tên kho của các sản phẩm thuộc danh mục CAT003, sắp xếp theo tên kho tăng dần 
--    theo số lượng giảm dần.
SELECT SP.TenSanPham, SP.SoLuongTon, SP.DonGia , K.TenKho
FROM SAN_PHAM AS SP
JOIN TON_KHO AS TK ON SP.MaSanPham = TK.MaSanPham
JOIN KHO AS K ON K.MaKho = TK.MaKho
WHERE SP.MaDanhMuc = 'CAT003' 
ORDER BY K.TenKho ASC, SP.SoLuongTon DESC
GO

-- 6/ Lập danh sách tên danh mục và tổng số lượng tồn kho của các sản phẩm thuộc danh mục.
SELECT DM.TenDanhMuc, 
	   SUM(SP.SoLuongTon) AS TongSP
FROM DANH_MUC AS DM
JOIN SAN_PHAM AS SP ON DM.MaDanhMuc = SP.MaDanhMuc
GROUP BY DM.TenDanhMuc
GO

-- 7/ Lập danh sách các nhà cung cấp có tổng giá trị hàng nhập (dựa trên SoLuong * DonGiaNhap từ các đơn nhập hàng có trạng thái là R) 
--    trong tháng 5/2025 lớn 5000. Danh sách gồm các thông tin mã số, tên nhà cung cấp và tổng giá trị hàng nhập.
SELECT NCC.MaNhaCungCap, NCC.TenNhaCungCap, SUM(CTDN.SoLuong * CTDN.DonGiaNhap)  AS TongGiaTri
FROM NHA_CUNG_CAP AS NCC
JOIN DON_NHAP_HANG AS DNH ON NCC.MaNhaCungCap = DNH.MaNhaCungCap
JOIN CHI_TIET_DON_NHAP AS CTDN ON DNH.MaDonNhap = CTDN.MaDonNhap
WHERE DNH.TrangThai = 'R' AND YEAR(DNH.NgayDatHang) = 2025 AND MONTH(DNH.NgayDatHang) = 5 
GROUP BY NCC.MaNhaCungCap, NCC.TenNhaCungCap
HAVING SUM(CTDN.SoLuong * CTDN.DonGiaNhap)> 5000
GO

-- 8/ Lập danh sách mã số, tên và số lượng các sản phẩm có số lượng tại kho WH001 lớn hơn mức trung bình của tất cả các sản phẩm tại kho WH001.
SELECT SP.MaSanPham, SP.TenSanPham, TK.SoLuong
FROM SAN_PHAM AS SP
JOIN TON_KHO AS TK ON SP.MaSanPham = TK.MaSanPham
WHERE TK.MaKho = 'WH001' AND TK.SoLuong > (
	SELECT AVG(TK.SoLuong) 
	FROM TON_KHO AS TK
	WHERE TK.MaKho = 'WH001'
)
GO

-- Sử dụng bảng phụ WITH
WITH TrungBinhLuong AS (
	SELECT AVG(TK.SoLuong) AS TrungBinh
	FROM TON_KHO AS TK
	WHERE TK.MaKho = 'WH001'
)
SELECT SP.MaSanPham, SP.TenSanPham, TK.SoLuong
FROM SAN_PHAM AS SP
JOIN TON_KHO AS TK ON SP.MaSanPham = TK.MaSanPham
CROSS JOIN TrungBinhLuong AS TBL
WHERE TK.MaKho = 'WH001' AND TK.SoLuong > TBL.TrungBinh
GO

-- 9/ Lập danh sách các kho có tổng số lượng sản phẩm đã nhập ( I ) lớn hơn số lượng tồn kho trung bình của tất cả sản phẩm trong danh mục Thuc pham. 
--	  Danh sách gồm các thông tin mã số kho, tên kho và tổng số lượng sản phẩm đã nhập.
-- Truy vấn lồng
SELECT K.MaKho, K.TenKho, SUM( GDK.SoLuong ) AS TongSL
FROM KHO AS K
JOIN GIAO_DICH_KHO AS GDK ON K.MaKho = GDK.MaKho
WHERE GDK.LoaiGiaoDich = 'I'
GROUP BY K.MaKho, K.TenKho
HAVING SUM(GDK.SoLuong) > ( 
	SELECT AVG (SP.SoLuongTon)
	FROM SAN_PHAM AS SP
	JOIN DANH_MUC AS DM ON SP.MaDanhMuc = DM.MaDanhMuc
	WHERE DM.TenDanhMuc = 'Thuc pham'
)
GO

-- Sử dụng bảng phụ WITH 
WITH SanPhamDaNhap AS(
	SELECT K.MaKho , K.TenKho , SUM(GDK.SoLuong) AS TongSL
	FROM KHO AS K
	JOIN GIAO_DICH_KHO AS GDK ON K.MaKho = GDK.MaKho
	WHERE GDK.LoaiGiaoDich = 'I'
	GROUP BY K.MaKho, K.TenKho
),
TrungBinhKho AS(
	SELECT AVG(SP.SoLuongTon) AS TB
	FROM SAN_PHAM AS SP
	JOIN DANH_MUC AS DM ON SP.MaDanhMuc = DM.MaDanhMuc
	WHERE DM.TenDanhMuc = 'Thuc pham'
)
SELECT SPDN.MaKho, SPDN.TenKho, SPDN.TongSL
FROM SanPhamDaNhap AS SPDN
CROSS JOIN TrungBinhKho AS TBK
WHERE SPDN.TongSL > TBK.TB
GO
-- 10/ Lập danh sách các danh mục sản phẩm có tổng giá trị hàng nhập
--     (dựa trên SoLuong * DonGiaNhap của các đơn nhập hàng có trạng thái là R) 
--	   trong tháng 5/2025 lớn hơn mức trung bình trong cùng tháng của tất cả các danh mục. Danh sách gồm các thông tin mã danh mục, 
--     tên danh mục, tổng giá trị hàng nhập.
-- Truy vấn lồng
SELECT 
    DM.MaDanhMuc, 
    DM.TenDanhMuc, 
    SUM(CTDN.DonGiaNhap * CTDN.SoLuong) AS TongGiaTri
FROM DANH_MUC AS DM
JOIN SAN_PHAM AS SP ON DM.MaDanhMuc = SP.MaDanhMuc
JOIN CHI_TIET_DON_NHAP AS CTDN ON CTDN.MaSanPham = SP.MaSanPham
JOIN DON_NHAP_HANG AS DNH ON DNH.MaDonNhap = CTDN.MaDonNhap
WHERE DNH.TrangThai = 'R' 
  AND YEAR(DNH.NgayDatHang) = 2025 
  AND MONTH(DNH.NgayDatHang) = 5 
GROUP BY DM.MaDanhMuc, DM.TenDanhMuc
HAVING SUM(CTDN.DonGiaNhap * CTDN.SoLuong) > (
    SELECT AVG(TongGiaTriDanhMuc)
    FROM (
        SELECT 
            DM2.MaDanhMuc,
            SUM(CTDN2.DonGiaNhap * CTDN2.SoLuong) AS TongGiaTriDanhMuc
        FROM DANH_MUC AS DM2
        JOIN SAN_PHAM AS SP2 ON DM2.MaDanhMuc = SP2.MaDanhMuc
        JOIN CHI_TIET_DON_NHAP AS CTDN2 ON CTDN2.MaSanPham = SP2.MaSanPham
        JOIN DON_NHAP_HANG AS DNH2 ON DNH2.MaDonNhap = CTDN2.MaDonNhap
        WHERE DNH2.TrangThai = 'R' 
          AND YEAR(DNH2.NgayDatHang) = 2025 
          AND MONTH(DNH2.NgayDatHang) = 5
        GROUP BY DM2.MaDanhMuc
    ) AS Sub
)

-- Sử dụng bảng phụ WITH 
WITH TongNhapDanhMuc AS (
	SELECT DM.MaDanhMuc, 
		   DM.TenDanhMuc, 
		   SUM(CTDN.DonGiaNhap * CTDN.SoLuong) AS TongGiaTri
	FROM DANH_MUC AS DM
		JOIN SAN_PHAM AS SP ON DM.MaDanhMuc = SP.MaDanhMuc
		JOIN CHI_TIET_DON_NHAP AS CTDN ON CTDN.MaSanPham = SP.MaSanPham
		JOIN DON_NHAP_HANG AS DNH ON DNH.MaDonNhap = CTDN.MaDonNhap
	WHERE DNH.TrangThai = 'R' 
		  AND YEAR(DNH.NgayDatHang) = 2025 
		  AND MONTH(DNH.NgayDatHang) = 5 
	GROUP BY DM.MaDanhMuc, DM.TenDanhMuc
),
TrungBinh AS(
	SELECT AVG(TNDM.TongGiaTri) AS GiaTriTB
	FROM TongNhapDanhMuc AS TNDM
)
SELECT TNDM.MaDanhMuc, 
	   TNDM.TenDanhMuc, 
	   TNDM.TongGiaTri
FROM TongNhapDanhMuc AS TNDM
CROSS JOIN TrungBinh AS TB
WHERE TNDM.TongGiaTri > TB.GiaTriTB;



























--cau 10
with a as (
select DANH_MUC.MaDanhMuc,DANH_MUC.TenDanhMuc,sum(CHI_TIET_DON_NHAP.SoLuong*CHI_TIET_DON_NHAP.DonGiaNhap) as Tonggiatri
from DANH_MUC
join SAN_PHAM on SAN_PHAM.MaDanhMuc = DANH_MUC.MaDanhMuc
join CHI_TIET_DON_NHAP on CHI_TIET_DON_NHAP.MaSanPham = SAN_PHAM.MaSanPham
join DON_NHAP_HANG on DON_NHAP_HANG.MaDonNhap = CHI_TIET_DON_NHAP.MaDonNhap
where DON_NHAP_HANG.TrangThai = 'R' 
and year(DON_NHAP_HANG.NgayDatHang) = 2025 
and month(DON_NHAP_HANG.NgayDatHang) = 5
group by DANH_MUC.MaDanhMuc,DANH_MUC.TenDanhMuc
)
select a.MaDanhMuc,a.TenDanhMuc, a.Tonggiatri
from a
join DANH_MUC on DANH_MUC.MaDanhMuc = a.MaDanhMuc
where a.Tonggiatri > (
select AVG(a.Tonggiatri)
from a
)



CREATE DATABASE TAXI_23110163;
USE TAXI_23110163;

CREATE TABLE LAIXE(
	MaLX int not null,
	Ho varchar(15),
	Dem varchar(15),
	Ten varchar(15) not null,
	NgaySinh date,
	SoGP char(12) not null,
	HanGP date,
	CONSTRAINT PK_LAIXE PRIMARY KEY(MaLX)
);

CREATE TABLE CALAMVIEC(
	MaCLV int not null,
	MaLX int not null,
	SoPT int not null,
	BatDau datetime,
	KetThuc datetime,
	CONSTRAINT PK_CALAMVIEC PRIMARY KEY(MaCLV)
);

CREATE TABLE PHUONGTIEN(
	LoaiPT int not null,
	SoPT int not null,
	BienSo char(10) not null,
	NamSanXuat int not null,
	ChuPT int,
	TinhTrang int 
	CONSTRAINT PK_PHUONGTIEN PRIMARY KEY(SoPT)
);

CREATE TABLE LOAI_PHUONGTIEN(
	LoaiPT,
	TenLoai,
	CONSTRAINT PK_LOAI_PHUONGTIEN PRIMARY KEY(LoaiPT)
);

/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 17                          */
/* Created on:     16/11/2025 4:13:37 CH                        */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ANHSANPH_NHIEU_MONAN') then
    alter table ANHSANPHAM
       delete foreign key FK_ANHSANPH_NHIEU_MONAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_COQUYEN_COQUYEN_NGUOI_DU') then
    alter table COQUYEN
       delete foreign key FK_COQUYEN_COQUYEN_NGUOI_DU
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_COQUYEN_COQUYEN2_DANHGIAS') then
    alter table COQUYEN
       delete foreign key FK_COQUYEN_COQUYEN2_DANHGIAS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DANHMUC_THUOC_MONAN') then
    alter table DANHMUC
       delete foreign key FK_DANHMUC_THUOC_MONAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DONHANG_BAO_GOM_CHITIETD') then
    alter table DONHANG
       delete foreign key FK_DONHANG_BAO_GOM_CHITIETD
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DONHANG_GHI_THANHTOA') then
    alter table DONHANG
       delete foreign key FK_DONHANG_GHI_THANHTOA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DONHANG_NAM_TRONG_CHITIETH') then
    alter table DONHANG
       delete foreign key FK_DONHANG_NAM_TRONG_CHITIETH
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DONHANG_THANH_TOA_HOADON') then
    alter table DONHANG
       delete foreign key FK_DONHANG_THANH_TOA_HOADON
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_GIOHANG_CHUA_CHITIETG') then
    alter table GIOHANG
       delete foreign key FK_GIOHANG_CHUA_CHITIETG
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_GIOHANG_CO_NGUOI_DU') then
    alter table GIOHANG
       delete foreign key FK_GIOHANG_CO_NGUOI_DU
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_GIOHANG_CO2_NGUOI_DU') then
    alter table GIOHANG
       delete foreign key FK_GIOHANG_CO2_NGUOI_DU
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HOADON_CO_THE_CHITIETH') then
    alter table HOADON
       delete foreign key FK_HOADON_CO_THE_CHITIETH
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MONAN_GOM_CHITIETG') then
    alter table MONAN
       delete foreign key FK_MONAN_GOM_CHITIETG
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MUA_MUA_NGUOI_DU') then
    alter table MUA
       delete foreign key FK_MUA_MUA_NGUOI_DU
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MUA_MUA2_DONHANG') then
    alter table MUA
       delete foreign key FK_MUA_MUA2_DONHANG
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NAM_NAM_MONAN') then
    alter table NAM
       delete foreign key FK_NAM_NAM_MONAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NAM_NAM2_CHITIETD') then
    alter table NAM
       delete foreign key FK_NAM_NAM2_CHITIETD
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NGUOI_DU_CUA_LICHSUCH') then
    alter table NGUOI_DUNG
       delete foreign key FK_NGUOI_DU_CUA_LICHSUCH
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TAI_TAI_ADMIN') then
    alter table TAI
       delete foreign key FK_TAI_TAI_ADMIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TAI_TAI2_ALBUMANH') then
    alter table TAI
       delete foreign key FK_TAI_TAI2_ALBUMANH
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_THONGKEH_THONG_KE_ADMIN') then
    alter table THONGKEHANGNGAY
       delete foreign key FK_THONGKEH_THONG_KE_ADMIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TINTUC__ANG_ADMIN') then
    alter table TINTUC
       delete foreign key FK_TINTUC__ANG_ADMIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK__UOC__UOC_MONAN') then
    alter table _UOC
       delete foreign key FK__UOC__UOC_MONAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK__UOC__UOC2_DANHGIAS') then
    alter table _UOC
       delete foreign key FK__UOC__UOC2_DANHGIAS
end if;

drop index if exists ADMIN.ADMIN_PK;

drop table if exists ADMIN;

drop index if exists ALBUMANH.ALBUMANH_PK;

drop table if exists ALBUMANH;

drop index if exists ANHSANPHAM.NHIEU_FK;

drop index if exists ANHSANPHAM.ANHSANPHAM_PK;

drop table if exists ANHSANPHAM;

drop index if exists CHITIETDONHANG.CHITIETDONHANG_PK;

drop table if exists CHITIETDONHANG;

drop index if exists CHITIETGIOHANG.CHITIETGIOHANG_PK;

drop table if exists CHITIETGIOHANG;

drop index if exists CHITIETHOADON.CHITIETHOADON_PK;

drop table if exists CHITIETHOADON;

drop index if exists COQUYEN.CO_QUYEN2_FK;

drop index if exists COQUYEN.CO_QUYEN_FK;

drop index if exists COQUYEN.CO_QUYEN_PK;

drop table if exists COQUYEN;

drop index if exists DANHGIASANPHAM.DANHGIASANPHAM_PK;

drop table if exists DANHGIASANPHAM;

drop index if exists DANHMUC.THUOC_FK;

drop index if exists DANHMUC.DANHMUC_PK;

drop table if exists DANHMUC;

drop index if exists DATBAN.DATBAN_PK;

drop table if exists DATBAN;

drop index if exists DONHANG.BAO_GOM_FK;

drop index if exists DONHANG.THANH_TOAN_FK;

drop index if exists DONHANG.GHI_FK;

drop index if exists DONHANG.NAM_TRONG_FK;

drop index if exists DONHANG.DONHANG_PK;

drop table if exists DONHANG;

drop index if exists DULIEUTIMKIEM.DULIEUTIMKIEM_PK;

drop table if exists DULIEUTIMKIEM;

drop index if exists EMAIL_ADMIN.EMAIL_ADMIN_PK;

drop table if exists EMAIL_ADMIN;

drop index if exists GIOHANG.CHUA_FK;

drop index if exists GIOHANG.CO_FK;

drop index if exists GIOHANG.GIOHANG_PK;

drop table if exists GIOHANG;

drop index if exists HOADON.CO_THE_FK;

drop index if exists HOADON.HOADON_PK;

drop table if exists HOADON;

drop index if exists KHOIPHUCMATKHAU.KHOIPHUCMATKHAU_PK;

drop table if exists KHOIPHUCMATKHAU;

drop index if exists KHUYENMAI.KHUYENMAI_PK;

drop table if exists KHUYENMAI;

drop index if exists LICHSUCHATBOT.LICHSUCHATBOT_PK;

drop table if exists LICHSUCHATBOT;

drop index if exists LIENHE.LIENHE_PK;

drop table if exists LIENHE;

drop index if exists MONAN.GOM_FK;

drop index if exists MONAN.MONAN_PK;

drop table if exists MONAN;

drop index if exists MUA.MUA2_FK;

drop index if exists MUA.MUA_FK;

drop index if exists MUA.MUA_PK;

drop table if exists MUA;

drop index if exists NAM.NAM2_FK;

drop index if exists NAM.NAM_FK;

drop index if exists NAM.NAM_PK;

drop table if exists NAM;

drop index if exists NGUOI_DUNG.CUA_FK;

drop index if exists NGUOI_DUNG.NGUOI_DUNG_PK;

drop table if exists NGUOI_DUNG;

drop index if exists QUANGCAO.QUANGCAO_PK;

drop table if exists QUANGCAO;

drop index if exists TAI.TAI2_FK;

drop index if exists TAI.TAI_FK;

drop index if exists TAI.TAI_PK;

drop table if exists TAI;

drop index if exists THANHTOAN.THANHTOAN_PK;

drop table if exists THANHTOAN;

drop index if exists THONGKEHANGNGAY.THONG_KE_FK;

drop index if exists THONGKEHANGNGAY.THONGKEHANGNGAY_PK;

drop table if exists THONGKEHANGNGAY;

drop index if exists TINTUC._ANG_FK;

drop index if exists TINTUC.TINTUC_PK;

drop table if exists TINTUC;

drop index if exists _UOC._UOC2_FK;

drop index if exists _UOC._UOC_FK;

drop index if exists _UOC._UOC_PK;

drop table if exists _UOC;

/*==============================================================*/
/* Table: ADMIN                                                 */
/*==============================================================*/
create or replace table ADMIN 
(
   ADMIN                varchar(100)                   not null,
   TAIKHOAN             varchar(20)                    null,
   MATKHAU              varchar(100)                   null,
   TENHIENTHI           varchar(100)                   null,
   EMAIL                varchar(100)                   null,
   QUYEN                varchar(20)                    null,
   NGAYTAO              timestamp                      null,
   constraint PK_ADMIN primary key clustered (ADMIN)
);

/*==============================================================*/
/* Index: ADMIN_PK                                              */
/*==============================================================*/
create unique clustered index ADMIN_PK on ADMIN (
ADMIN ASC
);

/*==============================================================*/
/* Table: ALBUMANH                                              */
/*==============================================================*/
create or replace table ALBUMANH 
(
   MA_ALBUM             varchar(200)                   not null,
   DUONGDANANH          varchar(100)                   null,
   LOAIANH              varchar(200)                   null,
   MOTA                 varchar(200)                   null,
   NGAYTAO              timestamp                      null,
   constraint PK_ALBUMANH primary key clustered (MA_ALBUM)
);

/*==============================================================*/
/* Index: ALBUMANH_PK                                           */
/*==============================================================*/
create unique clustered index ALBUMANH_PK on ALBUMANH (
MA_ALBUM ASC
);

/*==============================================================*/
/* Table: ANHSANPHAM                                            */
/*==============================================================*/
create or replace table ANHSANPHAM 
(
   MAANH                char(20)                       not null,
   MAMONAN              varchar(10)                    not null,
   DUONGDANANH          varchar(100)                   null,
   MOTA                 varchar(200)                   null,
   NGAYTAO              timestamp                      null,
   constraint PK_ANHSANPHAM primary key clustered (MAANH)
);

/*==============================================================*/
/* Index: ANHSANPHAM_PK                                         */
/*==============================================================*/
create unique clustered index ANHSANPHAM_PK on ANHSANPHAM (
MAANH ASC
);

/*==============================================================*/
/* Index: NHIEU_FK                                              */
/*==============================================================*/
create index NHIEU_FK on ANHSANPHAM (
MAMONAN ASC
);

/*==============================================================*/
/* Table: CHITIETDONHANG                                        */
/*==============================================================*/
create or replace table CHITIETDONHANG 
(
   MACTDONHANG          varchar(20)                    not null,
   SOLUONG              char(100)                      null,
   GIATAITHOIDIEM       char(200)                      null,
   constraint PK_CHITIETDONHANG primary key clustered (MACTDONHANG)
);

/*==============================================================*/
/* Index: CHITIETDONHANG_PK                                     */
/*==============================================================*/
create unique clustered index CHITIETDONHANG_PK on CHITIETDONHANG (
MACTDONHANG ASC
);

/*==============================================================*/
/* Table: CHITIETGIOHANG                                        */
/*==============================================================*/
create or replace table CHITIETGIOHANG 
(
   MACHITIET            varchar(100)                   not null,
   SOLUONG              char(100)                      null,
   GIATAITHOIDIEM       char(200)                      null,
   constraint PK_CHITIETGIOHANG primary key clustered (MACHITIET)
);

/*==============================================================*/
/* Index: CHITIETGIOHANG_PK                                     */
/*==============================================================*/
create unique clustered index CHITIETGIOHANG_PK on CHITIETGIOHANG (
MACHITIET ASC
);

/*==============================================================*/
/* Table: CHITIETHOADON                                         */
/*==============================================================*/
create or replace table CHITIETHOADON 
(
   MACHITIETHOADON      varchar(100)                   not null,
   MAMON                varchar(100)                   null,
   SOLUONG              char(100)                      null,
   DONGIA               varchar(100)                   null,
   THANHTIEN            varchar(100)                   null,
   constraint PK_CHITIETHOADON primary key clustered (MACHITIETHOADON)
);

/*==============================================================*/
/* Index: CHITIETHOADON_PK                                      */
/*==============================================================*/
create unique clustered index CHITIETHOADON_PK on CHITIETHOADON (
MACHITIETHOADON ASC
);

/*==============================================================*/
/* Table: COQUYEN                                               */
/*==============================================================*/
create or replace table COQUYEN 
(
   MA_NGUOI_DUNG        varchar(100)                   not null,
   MADANHGIA            varchar(100)                   not null,
   constraint PK_COQUYEN primary key clustered (MA_NGUOI_DUNG, MADANHGIA)
);

/*==============================================================*/
/* Index: CO_QUYEN_PK                                           */
/*==============================================================*/
create unique clustered index CO_QUYEN_PK on COQUYEN (
MA_NGUOI_DUNG ASC,
MADANHGIA ASC
);

/*==============================================================*/
/* Index: CO_QUYEN_FK                                           */
/*==============================================================*/
create index CO_QUYEN_FK on COQUYEN (
MA_NGUOI_DUNG ASC
);

/*==============================================================*/
/* Index: CO_QUYEN2_FK                                          */
/*==============================================================*/
create index CO_QUYEN2_FK on COQUYEN (
MADANHGIA ASC
);

/*==============================================================*/
/* Table: DANHGIASANPHAM                                        */
/*==============================================================*/
create or replace table DANHGIASANPHAM 
(
   MADANHGIA            varchar(100)                   not null,
   SAOSAO               varchar(10)                    null,
   BINHLUAN             varchar(100)                   null,
   TRANGTHAI            varchar(100)                   null,
   constraint PK_DANHGIASANPHAM primary key clustered (MADANHGIA)
);

/*==============================================================*/
/* Index: DANHGIASANPHAM_PK                                     */
/*==============================================================*/
create unique clustered index DANHGIASANPHAM_PK on DANHGIASANPHAM (
MADANHGIA ASC
);

/*==============================================================*/
/* Table: DANHMUC                                               */
/*==============================================================*/
create or replace table DANHMUC 
(
   MADANHMUC            char(20)                       not null,
   MAMONAN              varchar(10)                    not null,
   TENDANHMUC           varchar(100)                   null,
   TRANGTHAI            varchar(100)                   null,
   MOTA                 varchar(200)                   null,
   constraint PK_DANHMUC primary key clustered (MADANHMUC)
);

/*==============================================================*/
/* Index: DANHMUC_PK                                            */
/*==============================================================*/
create unique clustered index DANHMUC_PK on DANHMUC (
MADANHMUC ASC
);

/*==============================================================*/
/* Index: THUOC_FK                                              */
/*==============================================================*/
create index THUOC_FK on DANHMUC (
MAMONAN ASC
);

/*==============================================================*/
/* Table: DATBAN                                                */
/*==============================================================*/
create or replace table DATBAN 
(
   MADATBAN             varchar(20)                    not null,
   SDT                  numeric(10)                    null,
   SOLUONG              char(100)                      null,
   NGAYDAT              timestamp                      null,
   GIODEN               time                           null,
   TRANGTHAI            varchar(100)                   null,
   constraint PK_DATBAN primary key clustered (MADATBAN)
);

/*==============================================================*/
/* Index: DATBAN_PK                                             */
/*==============================================================*/
create unique clustered index DATBAN_PK on DATBAN (
MADATBAN ASC
);

/*==============================================================*/
/* Table: DONHANG                                               */
/*==============================================================*/
create or replace table DONHANG 
(
   MADONHANG            varchar(200)                   not null,
   MACHITIETHOADON      varchar(100)                   not null,
   MAHOADON             varchar(200)                   not null,
   MACTDONHANG          varchar(20)                    not null,
   MATHANHTOAN          varchar(200)                   not null,
   TENKHACHVANGLAI      varchar(100)                   null,
   TONGTIEN             varchar(200)                   null,
   TRANGTHAI            varchar(100)                   null,
   TIEMGIAMGIA          varchar(50)                    null,
   THOIGIANTAO          timestamp                      null,
   constraint PK_DONHANG primary key clustered (MADONHANG)
);

/*==============================================================*/
/* Index: DONHANG_PK                                            */
/*==============================================================*/
create unique clustered index DONHANG_PK on DONHANG (
MADONHANG ASC
);

/*==============================================================*/
/* Index: NAM_TRONG_FK                                          */
/*==============================================================*/
create index NAM_TRONG_FK on DONHANG (
MACHITIETHOADON ASC
);

/*==============================================================*/
/* Index: GHI_FK                                                */
/*==============================================================*/
create index GHI_FK on DONHANG (
MATHANHTOAN ASC
);

/*==============================================================*/
/* Index: THANH_TOAN_FK                                         */
/*==============================================================*/
create index THANH_TOAN_FK on DONHANG (
MAHOADON ASC
);

/*==============================================================*/
/* Index: BAO_GOM_FK                                            */
/*==============================================================*/
create index BAO_GOM_FK on DONHANG (
MACTDONHANG ASC
);

/*==============================================================*/
/* Table: DULIEUTIMKIEM                                         */
/*==============================================================*/
create or replace table DULIEUTIMKIEM 
(
   MATIMKIEM            varchar(20)                    not null,
   MANGUOIDUNG          varchar(100)                   null,
   TUKHOA               varchar(500)                   null,
   THOIGIANTIM          timestamp                      null,
   constraint PK_DULIEUTIMKIEM primary key clustered (MATIMKIEM)
);

/*==============================================================*/
/* Index: DULIEUTIMKIEM_PK                                      */
/*==============================================================*/
create unique clustered index DULIEUTIMKIEM_PK on DULIEUTIMKIEM (
MATIMKIEM ASC
);

/*==============================================================*/
/* Table: EMAIL_ADMIN                                           */
/*==============================================================*/
create or replace table EMAIL_ADMIN 
(
   ID_MAIL              varchar(20)                    not null,
   EMAIL                varchar(100)                   null,
   CODEXACTHUC          varchar(10)                    null,
   USER_DATA            varchar(100)                   null,
   EXPIRES_AT           varchar(200)                   null,
   IS_VERIFIED          varchar(200)                   null,
   constraint PK_EMAIL_ADMIN primary key clustered (ID_MAIL)
);

/*==============================================================*/
/* Index: EMAIL_ADMIN_PK                                        */
/*==============================================================*/
create unique clustered index EMAIL_ADMIN_PK on EMAIL_ADMIN (
ID_MAIL ASC
);

/*==============================================================*/
/* Table: GIOHANG                                               */
/*==============================================================*/
create or replace table GIOHANG 
(
   MAGIOHANG            varchar(100)                   not null,
   MA_NGUOI_DUNG        varchar(100)                   not null,
   MACHITIET            varchar(100)                   not null,
   NGU_MA_NGUOI_DUNG    varchar(100)                   null,
   TRANGTHAI            varchar(100)                   null,
   THOIGIANTAO          timestamp                      null,
   constraint PK_GIOHANG primary key clustered (MAGIOHANG)
);

/*==============================================================*/
/* Index: GIOHANG_PK                                            */
/*==============================================================*/
create unique clustered index GIOHANG_PK on GIOHANG (
MAGIOHANG ASC
);

/*==============================================================*/
/* Index: CO_FK                                                 */
/*==============================================================*/
create index CO_FK on GIOHANG (
MA_NGUOI_DUNG ASC
);

/*==============================================================*/
/* Index: CHUA_FK                                               */
/*==============================================================*/
create index CHUA_FK on GIOHANG (
MACHITIET ASC
);

/*==============================================================*/
/* Table: HOADON                                                */
/*==============================================================*/
create or replace table HOADON 
(
   MAHOADON             varchar(200)                   not null,
   MACHITIETHOADON      varchar(100)                   not null,
   TONGTIEN             varchar(200)                   null,
   THOIDIEMXUAT         timestamp                      null,
   constraint PK_HOADON primary key clustered (MAHOADON)
);

/*==============================================================*/
/* Index: HOADON_PK                                             */
/*==============================================================*/
create unique clustered index HOADON_PK on HOADON (
MAHOADON ASC
);

/*==============================================================*/
/* Index: CO_THE_FK                                             */
/*==============================================================*/
create index CO_THE_FK on HOADON (
MACHITIETHOADON ASC
);

/*==============================================================*/
/* Table: KHOIPHUCMATKHAU                                       */
/*==============================================================*/
create or replace table KHOIPHUCMATKHAU 
(
   ID                   varchar(100)                   not null,
   MANGUOIDUNG          varchar(100)                   null,
   TOKEN                varchar(100)                   null,
   EXPIRED_AT           varchar(100)                   null,
   DASUDUNG             varchar(100)                   null,
   constraint PK_KHOIPHUCMATKHAU primary key clustered (ID)
);

/*==============================================================*/
/* Index: KHOIPHUCMATKHAU_PK                                    */
/*==============================================================*/
create unique clustered index KHOIPHUCMATKHAU_PK on KHOIPHUCMATKHAU (
ID ASC
);

/*==============================================================*/
/* Table: KHUYENMAI                                             */
/*==============================================================*/
create or replace table KHUYENMAI 
(
   MAKHUYENMAI          char(30)                       not null,
   MACODE               char(100)                      null,
   LOAIGIAMGIA          varchar(20)                    null,
   GIATRI               varchar(20)                    null,
   NGAYBATDAU           timestamp                      null,
   NGAYKETTHUC          timestamp                      null,
   SOLUONGGIOIHAN       varchar(200)                   null,
   SOLUONGDADUNG        varchar(200)                   null,
   constraint PK_KHUYENMAI primary key clustered (MAKHUYENMAI)
);

/*==============================================================*/
/* Index: KHUYENMAI_PK                                          */
/*==============================================================*/
create unique clustered index KHUYENMAI_PK on KHUYENMAI (
MAKHUYENMAI ASC
);

/*==============================================================*/
/* Table: LICHSUCHATBOT                                         */
/*==============================================================*/
create or replace table LICHSUCHATBOT 
(
   MATINNHAN            varchar(100)                   not null,
   MANGUOIDUNG          varchar(100)                   null,
   SESSION_ID           varchar(100)                   null,
   NGUOIGUI             varchar(200)                   null,
   NOIDUNG              varchar(1000)                  null,
   THOIDIEMCHAT         timestamp                      null,
   constraint PK_LICHSUCHATBOT primary key clustered (MATINNHAN)
);

/*==============================================================*/
/* Index: LICHSUCHATBOT_PK                                      */
/*==============================================================*/
create unique clustered index LICHSUCHATBOT_PK on LICHSUCHATBOT (
MATINNHAN ASC
);

/*==============================================================*/
/* Table: LIENHE                                                */
/*==============================================================*/
create or replace table LIENHE 
(
   MALIENHE             varchar(200)                   not null,
   HOTEN                varchar(200)                   null,
   EMAIL                varchar(100)                   null,
   TIEUDE               varchar(100)                   null,
   NOIDUNG              varchar(1000)                  null,
   NGAYGUI              timestamp                      null,
   TRANGTHAI            varchar(100)                   null,
   constraint PK_LIENHE primary key clustered (MALIENHE)
);

/*==============================================================*/
/* Index: LIENHE_PK                                             */
/*==============================================================*/
create unique clustered index LIENHE_PK on LIENHE (
MALIENHE ASC
);

/*==============================================================*/
/* Table: MONAN                                                 */
/*==============================================================*/
create or replace table MONAN 
(
   MAMONAN              varchar(10)                    not null,
   MACHITIET            varchar(100)                   not null,
   TENMON               varchar(100)                   null,
   GIATIEN              varchar(100)                   null,
   SOLUONG              char(100)                      null,
   ANHMON               varchar(100)                   null,
   MOTACHITIET          varchar(200)                   null,
   NGAYCAPNHAT          timestamp                      null,
   constraint PK_MONAN primary key clustered (MAMONAN)
);

/*==============================================================*/
/* Index: MONAN_PK                                              */
/*==============================================================*/
create unique clustered index MONAN_PK on MONAN (
MAMONAN ASC
);

/*==============================================================*/
/* Index: GOM_FK                                                */
/*==============================================================*/
create index GOM_FK on MONAN (
MACHITIET ASC
);

/*==============================================================*/
/* Table: MUA                                                   */
/*==============================================================*/
create or replace table MUA 
(
   MA_NGUOI_DUNG        varchar(100)                   not null,
   MADONHANG            varchar(200)                   not null,
   constraint PK_MUA primary key clustered (MA_NGUOI_DUNG, MADONHANG)
);

/*==============================================================*/
/* Index: MUA_PK                                                */
/*==============================================================*/
create unique clustered index MUA_PK on MUA (
MA_NGUOI_DUNG ASC,
MADONHANG ASC
);

/*==============================================================*/
/* Index: MUA_FK                                                */
/*==============================================================*/
create index MUA_FK on MUA (
MA_NGUOI_DUNG ASC
);

/*==============================================================*/
/* Index: MUA2_FK                                               */
/*==============================================================*/
create index MUA2_FK on MUA (
MADONHANG ASC
);

/*==============================================================*/
/* Table: NAM                                                   */
/*==============================================================*/
create or replace table NAM 
(
   MAMONAN              varchar(10)                    not null,
   MACTDONHANG          varchar(20)                    not null,
   constraint PK_NAM primary key clustered (MAMONAN, MACTDONHANG)
);

/*==============================================================*/
/* Index: NAM_PK                                                */
/*==============================================================*/
create unique clustered index NAM_PK on NAM (
MAMONAN ASC,
MACTDONHANG ASC
);

/*==============================================================*/
/* Index: NAM_FK                                                */
/*==============================================================*/
create index NAM_FK on NAM (
MAMONAN ASC
);

/*==============================================================*/
/* Index: NAM2_FK                                               */
/*==============================================================*/
create index NAM2_FK on NAM (
MACTDONHANG ASC
);

/*==============================================================*/
/* Table: NGUOI_DUNG                                            */
/*==============================================================*/
create or replace table NGUOI_DUNG 
(
   MA_NGUOI_DUNG        varchar(100)                   not null,
   MATINNHAN            varchar(100)                   not null,
   TEN_NGUOI_DUNG       varchar(100)                   null,
   EMAIL                varchar(100)                   null,
   SDT                  numeric(10)                    null,
   MATKHAU              varchar(100)                   null,
   TRANG_THAI           varchar(100)                   null,
   NGAYTAO              timestamp                      null,
   AVT                  varchar(100)                   null,
   constraint PK_NGUOI_DUNG primary key clustered (MA_NGUOI_DUNG)
);

/*==============================================================*/
/* Index: NGUOI_DUNG_PK                                         */
/*==============================================================*/
create unique clustered index NGUOI_DUNG_PK on NGUOI_DUNG (
MA_NGUOI_DUNG ASC
);

/*==============================================================*/
/* Index: CUA_FK                                                */
/*==============================================================*/
create index CUA_FK on NGUOI_DUNG (
MATINNHAN ASC
);

/*==============================================================*/
/* Table: QUANGCAO                                              */
/*==============================================================*/
create or replace table QUANGCAO 
(
   MAQUANGCAO           varchar(100)                   not null,
   TIEUDE               varchar(100)                   null,
   HINHANH              varchar(200)                   null,
   DUONGDANLIENKET      varchar(200)                   null,
   VITRI                varchar(200)                   null,
   NGAYBATDAU           timestamp                      null,
   NGAYKETTHUC          timestamp                      null,
   constraint PK_QUANGCAO primary key clustered (MAQUANGCAO)
);

/*==============================================================*/
/* Index: QUANGCAO_PK                                           */
/*==============================================================*/
create unique clustered index QUANGCAO_PK on QUANGCAO (
MAQUANGCAO ASC
);

/*==============================================================*/
/* Table: TAI                                                   */
/*==============================================================*/
create or replace table TAI 
(
   ADMIN                varchar(100)                   not null,
   MA_ALBUM             varchar(200)                   not null,
   constraint PK_TAI primary key clustered (ADMIN, MA_ALBUM)
);

/*==============================================================*/
/* Index: TAI_PK                                                */
/*==============================================================*/
create unique clustered index TAI_PK on TAI (
ADMIN ASC,
MA_ALBUM ASC
);

/*==============================================================*/
/* Index: TAI_FK                                                */
/*==============================================================*/
create index TAI_FK on TAI (
ADMIN ASC
);

/*==============================================================*/
/* Index: TAI2_FK                                               */
/*==============================================================*/
create index TAI2_FK on TAI (
MA_ALBUM ASC
);

/*==============================================================*/
/* Table: THANHTOAN                                             */
/*==============================================================*/
create or replace table THANHTOAN 
(
   MATHANHTOAN          varchar(200)                   not null,
   SOTIEN               varchar(50)                    null,
   PHUONGTHUC           varchar(200)                   null,
   MAGIAODICH           varchar(200)                   null,
   TRANGTHAI            varchar(100)                   null,
   constraint PK_THANHTOAN primary key clustered (MATHANHTOAN)
);

/*==============================================================*/
/* Index: THANHTOAN_PK                                          */
/*==============================================================*/
create unique clustered index THANHTOAN_PK on THANHTOAN (
MATHANHTOAN ASC
);

/*==============================================================*/
/* Table: THONGKEHANGNGAY                                       */
/*==============================================================*/
create or replace table THONGKEHANGNGAY 
(
   MATHONGKE            varchar(100)                   not null,
   ADMIN                varchar(100)                   not null,
   NGAYTHONGKE          timestamp                      null,
   DOANHTHU             varchar(100)                   null,
   SODONHANG            varchar(100)                   null,
   LUOTTRUYCAP          varchar(100)                   null,
   constraint PK_THONGKEHANGNGAY primary key clustered (MATHONGKE)
);

/*==============================================================*/
/* Index: THONGKEHANGNGAY_PK                                    */
/*==============================================================*/
create unique clustered index THONGKEHANGNGAY_PK on THONGKEHANGNGAY (
MATHONGKE ASC
);

/*==============================================================*/
/* Index: THONG_KE_FK                                           */
/*==============================================================*/
create index THONG_KE_FK on THONGKEHANGNGAY (
ADMIN ASC
);

/*==============================================================*/
/* Table: TINTUC                                                */
/*==============================================================*/
create or replace table TINTUC 
(
   MATINTUC             varchar(200)                   not null,
   ADMIN                varchar(100)                   not null,
   TIEUDE               varchar(100)                   null,
   TOMTAT               varchar(500)                   null,
   NOIDUNG              varchar(1000)                  null,
   NGAYDANG             timestamp                      null,
   LUOTXEM              varchar(20)                    null,
   constraint PK_TINTUC primary key clustered (MATINTUC)
);

/*==============================================================*/
/* Index: TINTUC_PK                                             */
/*==============================================================*/
create unique clustered index TINTUC_PK on TINTUC (
MATINTUC ASC
);

/*==============================================================*/
/* Index: _ANG_FK                                               */
/*==============================================================*/
create index _ANG_FK on TINTUC (
ADMIN ASC
);

/*==============================================================*/
/* Table: _UOC                                                  */
/*==============================================================*/
create or replace table _UOC 
(
   MAMONAN              varchar(10)                    not null,
   MADANHGIA            varchar(100)                   not null,
   constraint PK__UOC primary key clustered (MAMONAN, MADANHGIA)
);

/*==============================================================*/
/* Index: _UOC_PK                                               */
/*==============================================================*/
create unique clustered index _UOC_PK on _UOC (
MAMONAN ASC,
MADANHGIA ASC
);

/*==============================================================*/
/* Index: _UOC_FK                                               */
/*==============================================================*/
create index _UOC_FK on _UOC (
MAMONAN ASC
);

/*==============================================================*/
/* Index: _UOC2_FK                                              */
/*==============================================================*/
create index _UOC2_FK on _UOC (
MADANHGIA ASC
);

alter table ANHSANPHAM
   add constraint FK_ANHSANPH_NHIEU_MONAN foreign key (MAMONAN)
      references MONAN (MAMONAN)
      on update restrict
      on delete restrict;

alter table COQUYEN
   add constraint FK_COQUYEN_COQUYEN_NGUOI_DU foreign key (MA_NGUOI_DUNG)
      references NGUOI_DUNG (MA_NGUOI_DUNG)
      on update restrict
      on delete restrict;

alter table COQUYEN
   add constraint FK_COQUYEN_COQUYEN2_DANHGIAS foreign key (MADANHGIA)
      references DANHGIASANPHAM (MADANHGIA)
      on update restrict
      on delete restrict;

alter table DANHMUC
   add constraint FK_DANHMUC_THUOC_MONAN foreign key (MAMONAN)
      references MONAN (MAMONAN)
      on update restrict
      on delete restrict;

alter table DONHANG
   add constraint FK_DONHANG_BAO_GOM_CHITIETD foreign key (MACTDONHANG)
      references CHITIETDONHANG (MACTDONHANG)
      on update restrict
      on delete restrict;

alter table DONHANG
   add constraint FK_DONHANG_GHI_THANHTOA foreign key (MATHANHTOAN)
      references THANHTOAN (MATHANHTOAN)
      on update restrict
      on delete restrict;

alter table DONHANG
   add constraint FK_DONHANG_NAM_TRONG_CHITIETH foreign key (MACHITIETHOADON)
      references CHITIETHOADON (MACHITIETHOADON)
      on update restrict
      on delete restrict;

alter table DONHANG
   add constraint FK_DONHANG_THANH_TOA_HOADON foreign key (MAHOADON)
      references HOADON (MAHOADON)
      on update restrict
      on delete restrict;

alter table GIOHANG
   add constraint FK_GIOHANG_CHUA_CHITIETG foreign key (MACHITIET)
      references CHITIETGIOHANG (MACHITIET)
      on update restrict
      on delete restrict;

alter table GIOHANG
   add constraint FK_GIOHANG_CO_NGUOI_DU foreign key (MA_NGUOI_DUNG)
      references NGUOI_DUNG (MA_NGUOI_DUNG)
      on update restrict
      on delete restrict;

alter table GIOHANG
   add constraint FK_GIOHANG_CO2_NGUOI_DU foreign key (NGU_MA_NGUOI_DUNG)
      references NGUOI_DUNG (MA_NGUOI_DUNG)
      on update restrict
      on delete restrict;

alter table HOADON
   add constraint FK_HOADON_CO_THE_CHITIETH foreign key (MACHITIETHOADON)
      references CHITIETHOADON (MACHITIETHOADON)
      on update restrict
      on delete restrict;

alter table MONAN
   add constraint FK_MONAN_GOM_CHITIETG foreign key (MACHITIET)
      references CHITIETGIOHANG (MACHITIET)
      on update restrict
      on delete restrict;

alter table MUA
   add constraint FK_MUA_MUA_NGUOI_DU foreign key (MA_NGUOI_DUNG)
      references NGUOI_DUNG (MA_NGUOI_DUNG)
      on update restrict
      on delete restrict;

alter table MUA
   add constraint FK_MUA_MUA2_DONHANG foreign key (MADONHANG)
      references DONHANG (MADONHANG)
      on update restrict
      on delete restrict;

alter table NAM
   add constraint FK_NAM_NAM_MONAN foreign key (MAMONAN)
      references MONAN (MAMONAN)
      on update restrict
      on delete restrict;

alter table NAM
   add constraint FK_NAM_NAM2_CHITIETD foreign key (MACTDONHANG)
      references CHITIETDONHANG (MACTDONHANG)
      on update restrict
      on delete restrict;

alter table NGUOI_DUNG
   add constraint FK_NGUOI_DU_CUA_LICHSUCH foreign key (MATINNHAN)
      references LICHSUCHATBOT (MATINNHAN)
      on update restrict
      on delete restrict;

alter table TAI
   add constraint FK_TAI_TAI_ADMIN foreign key (ADMIN)
      references ADMIN (ADMIN)
      on update restrict
      on delete restrict;

alter table TAI
   add constraint FK_TAI_TAI2_ALBUMANH foreign key (MA_ALBUM)
      references ALBUMANH (MA_ALBUM)
      on update restrict
      on delete restrict;

alter table THONGKEHANGNGAY
   add constraint FK_THONGKEH_THONG_KE_ADMIN foreign key (ADMIN)
      references ADMIN (ADMIN)
      on update restrict
      on delete restrict;

alter table TINTUC
   add constraint FK_TINTUC__ANG_ADMIN foreign key (ADMIN)
      references ADMIN (ADMIN)
      on update restrict
      on delete restrict;

alter table _UOC
   add constraint FK__UOC__UOC_MONAN foreign key (MAMONAN)
      references MONAN (MAMONAN)
      on update restrict
      on delete restrict;

alter table _UOC
   add constraint FK__UOC__UOC2_DANHGIAS foreign key (MADANHGIA)
      references DANHGIASANPHAM (MADANHGIA)
      on update restrict
      on delete restrict;


Create database WebTinTuc 
go
CREATE TABLE tblTheloaiBao (
    iMaTheLoai INT identity(1,1) PRIMARY KEY,
    sTenTheLoai NVARCHAR(50) NOT NULL
);
go
CREATE TABLE tblBao (
    iMaBao INT identity(1,1) PRIMARY KEY,
    sTenBao NVARCHAR(255) not null,
	sNoiDung Nvarchar(MAX) not null,
    dNgayPhatHanh DATE not null,
	sURLAnh varchar(255) not null ,
    sTenTacgia nvarchar(255) not null,
	iMaTheLoai int foreign key(iMaTheLoai) references  tblTheloaiBao(iMaTheLoai)
);
go
create table tblUser(
	sTenTaiKhoan varchar(255) primary key ,
	sMatKhau varchar(255) not null,
	sVaitro varchar(50) default 'user'
)
go
create table tblBaoDaLuu (
	iMaBao int foreign key(iMaBao) references  tblBao(iMaBao) ,
	sTenTaiKhoan varchar(255) foreign key(sTenTaiKhoan) references tblUser(sTenTaiKhoan)
)



create proc sp_getAllBao
as
begin
	select * from tblBao inner join tblTheloaiBao on tblBao.iMaTheLoai = tblTheloaiBao.iMaTheLoai
end
go
create proc sp_getBao_User @stentaikhoan nvarchar(100)
as
begin
	select * from tblBao inner join tblTheloaiBao on tblBao.iMaTheLoai = tblTheloaiBao.iMaTheLoai
	where tblBao.sTenTacgia = @stentaikhoan 
end
go
select * from tblBao
delete tblBao where iMaBao >= 20

exec sp_getBao_User N'Thành Đạt'
create proc sp_getAllTheLoaiBao
as
begin
	select * from tblTheloaiBao 
end

create proc sp_AddBao( @sTenBao NVARCHAR(255),@sNoiDung Nvarchar(MAX) ,@dNgayPhatHanh DATE ,@sURLAnh varchar(255)  ,@sTenTacgia nvarchar(255) ,@iMaTheLoai int )
as
begin
	insert into tblBao(sTenBao,sNoiDung, dNgayPhatHanh, sURLAnh , sTenTacgia, iMaTheLoai)
	values (@sTenBao , @sNoiDung , @dNgayPhatHanh , @sURLAnh , @sTenTacgia , @iMaTheLoai)
end

create proc sp_getIDBao
as
begin
	select MAX(iMaBao) as 'iMaBao' from tblBao 
end
exec sp_getIDBao
create proc sp_getBao_ID @id int
as
begin
	select * from tblBao 
	where iMaBao = @id
end
exec sp_getBao_ID 5

create proc sp_updateBao (@id int, @sTenBao NVARCHAR(255),@sNoiDung Nvarchar(MAX) ,@sURLAnh varchar(255)  ,@iMaTheLoai int )
as
begin
	update tblBao
	set sTenBao = @sTenBao , sNoiDung = @sNoiDung ,  sURLAnh = @sURLAnh , iMaTheLoai = @iMaTheLoai 
	where iMaBao = @id
end

create proc sp_DeleteBao @id int
as
begin
	delete tblBao
	where iMaBao = @id
end

create proc sp_getTheLoaiBao @id int
as
begin
	select  tblTheloaiBao.sTenTheLoai
	from tblTheloaiBao 
	where iMaTheLoai = @id
end
select * from tblBao
exec sp_getBao_ID 4

alter table tblBao
add iSoluotxem int default(0) 

create proc sp_UPluotxem @id int 
as
begin
	update tblBao
	set isoluotxem = isoluotxem +1 
	where iMaBao = @id
end
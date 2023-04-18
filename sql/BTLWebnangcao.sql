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


-- vũ
-- lấy thông tin user
create proc getUser
@name varchar(255),@pass varchar(255)
as
begin
	select * from tblUser where sTenTaiKhoan = @name and sMatKhau= @pass 
end

go	
-- thêm user
create proc insertUser
@name varchar(255),@pass varchar(255)
as
begin
	insert into tblUser(sTenTaiKhoan,sMatKhau) values(@name,@pass)
end
go
-- lấy báo đã lưu theo user
create proc sp_getBaodaluu_User @stenUser nvarchar(255)
as
begin
	select sTenBao ,sNoiDung,dNgayPhatHanh,sURLAnh,sTenTacGia,sTenTheLoai from tblBao inner join tblTheloaiBao
	on tblBao.iMaTheLoai = tblTheloaiBao.iMaTheLoai
	inner join tblBaoDaLuu on tblBaoDaLuu.iMaBao = tblBao.iMaBao
	inner join tblUser on tblBaoDaLuu.sTenTaiKhoan = tblUser.sTenTaiKhoan
	where tblUser.sTenTaiKhoan = @stenUser 
end
exec sp_getBaodaluu_User 'admin'
go

-- lấy thông tin báo theo thể loại (tên báo , nội dung , ngày phát hành , url ảnh , tên tác giả) 
-- với điều kiện là tên thể loại truyền vào
-- proc
create proc sp_getTheLoaiBao_Ten
@tentheloai nvarchar(255)
as
begin
	select sTenBao ,sNoiDung,dNgayPhatHanh,sURLAnh,sTenTacGia,sTenTheLoai
	from tblBao
	inner join tblTheloaiBao
	on tblBao.iMaTheLoai = tblTheloaiBao.iMaTheLoai
	where sTenTheLoai like N'%'+ @tentheloai +'%'
end

exec sp_getTheLoaiBao_Ten N'Đời sống' 

-- end vũ

--Cường
insert into tblTheloaiBao(sTenTheLoai)
values(N'Chính trị'),
(N'Thể thao'),
(N'Kinh tế'),
(N'Giải trí'),
(N'Khoa học'),
(N'Địa phương'),
(N'Quốc tế'),
(N'Mạng'),
(N'Tổng hợp'),
(N'Đời sống')

select * from tblTheloaiBao

--RESET ID BÁO VỀ 0
DBCC CHECKIDENT ('[tblBao]', RESEED, 0);
GO

insert into tblBao(sTenBao,sNoiDung,dNgayPhatHanh,sURLAnh,sTenTacgia,iMaTheLoai)
values
(
N'Xét xử vụ cháy chung cư Carina làm 13 người chết: Triệu tập hơn 600 bị hại',
N'Sau hơn 5 năm xảy ra hỏa hoạn chung cư Carina khiến 13 người chết, 72 người bị thương, gần 500 xe máy và 81 ôtô bị thiêu rụi, TAND TPHCM mở phiên tòa xét xử bị cáo Nguyễn Văn Tùng (cựu Giám đốc công ty TNHH XD TMDV SX Hùng Thanh, chủ đầu tư chung cư Carina) và Nguyễn Quốc Tuấn (cựu Trưởng ban quản lý chung cư Carina) về tội Vi phạm quy định về phòng cháy, chữa cháy, sáng 5/4.
Để phục vụ việc xét xử, HĐXX đã triệu tập 642 bị hại, 70 người có quyền và nghĩa vụ liên quan. 10 luật sư tham gia bào chữa cho các bị cáo, người liên quan.

Được tại ngoại, 2 bị cáo có mặt từ rất sớm tại tòa. Về phía bị hại có rất ít người có mặt, theo ghi nhận chưa tới 10 người tới tòa.

Trong phần thủ tục, luật sư Nguyễn Thành Công (bào chữa cho bị Tùng) đề nghị hoãn phiên tòa để triệu tập thêm nhiều người liên quan. Trước phiên tòa, luật sư này cũng có kiến nghị gửi HĐXX đề nghị đổi tội danh đối với các bị cáo, thiệt hại và có dấu hiệu bỏ lọt tội phạm.

Tuy nhiên, tòa cho rằng việc hoãn phiên tòa là không cần thiết vì những người luật sư Công đề nghị đã được triệu tập hợp lệ, trong quá trình xét xử nếu cần thiết thì sẽ triệu tập sau.

Phiên tòa dự kiến kéo dài tới 10/4.

Theo nội dung vụ án, tối 22/3/2018, một nam thanh niên ở Lô A chung cư Carina để xe dưới hầm. 1h15 ngày 23/3/2018, xe của người này xuất hiện khói và tia lửa nhỏ. 8 phút sau, hệ thống chiếu sáng khu vực tầng hầm bị tắt, lửa bùng lên dữ dội, cháy lan các xe máy và ôtô để trong hầm. Khói, khí nóng và khí độc theo buồng thang thoát hiểm dẫn lên các tầng trên chung cư.

Hệ thống báo cháy, chữa cháy tự động không hoạt động. Lửa càng lúc càng lớn, kéo dài hơn 13 phút nữa vẫn không có nhân viên bảo vệ hay bất kỳ người nào phát hiện. Từ đây, đám cháy lan ra các hướng rồi bùng lên phía trên cùng khói độc gây thương vong lớn.

Tháng 4/2018 vụ án được khởi tố. Một năm sau, Công an TPHCM có kết luận điều tra, đề nghị truy tố ông Tùng và ông  Tuấn. Quá trình điều tra bổ sung theo yêu cầu của VKS, vụ án bị tạm đình chỉ để chờ kết quả giám định về thiệt hại.

Đến tháng 2/2021, vụ án được phục hồi điều tra. Một năm sau, VKSND TPHCM hoàn tất cáo trạng, chuyển hồ sơ sang tòa xét xử.

Cáo trạng xác định, Nguyễn Văn Tùng đã được Ban quản lý chung cư thông báo về tình trạng hệ thống báo cháy, chữa cháy tự động không hoạt động nhưng không sửa chữa, thay thế. Việc không trang bị đầy đủ phương tiện phòng cháy chữa cháy trước khi bàn giao chung cư cho phía công ty quản lý vận hành là không đảm bảo yêu cầu về phòng cháy chữa cháy.

Hành vi của Tùng vi phạm quy định về nguyên tắc phòng cháy chữa cháy là phải chuẩn bị sẵn sàng lực lượng, phương tiện, phương án và các điều kiện khác để kịp chữa cháy.

Còn Tuấn, với tư cách là Trưởng ban quản lý chung cư, biết rõ tình trạng hệ thống phòng cháy chữa cháy không hoạt động nhưng không thực hiện đầy đủ trách nhiệm, không kiên quyết yêu cầu chủ đầu tư thay thế, sửa chữa nhằm khắc phục, vận hành hoạt động báo cháy, chữa cháy và cứu hộ. Ngoài ra, việc không đóng cửa thang bộ thoát hiểm đã khiến khói độc theo đó lên các tầng trên làm nhiều người chết và bị thương, cũng thuộc trách nhiệm của Ban quản lý.

Nhà chức trách xác định, ông Tùng biết hệ thống báo cháy của chung cư hỏng nhưng không thay, khi hỏa hoạn xảy ra đã gây hậu quả đặc biệt nghiêm trọng.

Thiệt hại trong vụ án được xác định là 126 tỷ đồng. Công ty Hùng Thanh đã bồi thường số tiền 120 tỷ đồng.
',
'2023-04-05',
'assets/anh1.jpg',
N'Xuân Duy',
10
)
go
insert into tblBao(sTenBao,sNoiDung,dNgayPhatHanh,sURLAnh,sTenTacgia,iMaTheLoai)
values
(
N'Xét xử vụ cháy chung cư Carina làm 13 người chết: Triệu tập hơn 500 bị hại',
N'Sau hơn 5 năm xảy ra hỏa hoạn chung cư Carina khiến 13 người chết, 72 người bị thương, gần 500 xe máy và 81 ôtô bị thiêu rụi, TAND TPHCM mở phiên tòa xét xử bị cáo Nguyễn Văn Tùng (cựu Giám đốc công ty TNHH XD TMDV SX Hùng Thanh, chủ đầu tư chung cư Carina) và Nguyễn Quốc Tuấn (cựu Trưởng ban quản lý chung cư Carina) về tội Vi phạm quy định về phòng cháy, chữa cháy, sáng 5/4.

Xét xử vụ cháy  chung cư Carina làm 13 người chết: Triệu tập hơn 600 bị hại - 1
Bị cáo Nguyễn Văn Tùng tại tòa (Ảnh: Thanh Phúc).

Để phục vụ việc xét xử, HĐXX đã triệu tập 642 bị hại, 70 người có quyền và nghĩa vụ liên quan. 10 luật sư tham gia bào chữa cho các bị cáo, người liên quan.

Được tại ngoại, 2 bị cáo có mặt từ rất sớm tại tòa. Về phía bị hại có rất ít người có mặt, theo ghi nhận chưa tới 10 người tới tòa.

Trong phần thủ tục, luật sư Nguyễn Thành Công (bào chữa cho bị Tùng) đề nghị hoãn phiên tòa để triệu tập thêm nhiều người liên quan. Trước phiên tòa, luật sư này cũng có kiến nghị gửi HĐXX đề nghị đổi tội danh đối với các bị cáo, thiệt hại và có dấu hiệu bỏ lọt tội phạm.

Tuy nhiên, tòa cho rằng việc hoãn phiên tòa là không cần thiết vì những người luật sư Công đề nghị đã được triệu tập hợp lệ, trong quá trình xét xử nếu cần thiết thì sẽ triệu tập sau.

Phiên tòa dự kiến kéo dài tới 10/4.

Xét xử vụ cháy  chung cư Carina làm 13 người chết: Triệu tập hơn 600 bị hại - 2
Các bị cáo tại tòa (Ảnh: Thanh Phúc).

Theo nội dung vụ án, tối 22/3/2018, một nam thanh niên ở Lô A chung cư Carina để xe dưới hầm. 1h15 ngày 23/3/2018, xe của người này xuất hiện khói và tia lửa nhỏ. 8 phút sau, hệ thống chiếu sáng khu vực tầng hầm bị tắt, lửa bùng lên dữ dội, cháy lan các xe máy và ôtô để trong hầm. Khói, khí nóng và khí độc theo buồng thang thoát hiểm dẫn lên các tầng trên chung cư.

Hệ thống báo cháy, chữa cháy tự động không hoạt động. Lửa càng lúc càng lớn, kéo dài hơn 13 phút nữa vẫn không có nhân viên bảo vệ hay bất kỳ người nào phát hiện. Từ đây, đám cháy lan ra các hướng rồi bùng lên phía trên cùng khói độc gây thương vong lớn.

Tháng 4/2018 vụ án được khởi tố. Một năm sau, Công an TPHCM có kết luận điều tra, đề nghị truy tố ông Tùng và ông  Tuấn. Quá trình điều tra bổ sung theo yêu cầu của VKS, vụ án bị tạm đình chỉ để chờ kết quả giám định về thiệt hại.

Đến tháng 2/2021, vụ án được phục hồi điều tra. Một năm sau, VKSND TPHCM hoàn tất cáo trạng, chuyển hồ sơ sang tòa xét xử.

Cáo trạng xác định, Nguyễn Văn Tùng đã được Ban quản lý chung cư thông báo về tình trạng hệ thống báo cháy, chữa cháy tự động không hoạt động nhưng không sửa chữa, thay thế. Việc không trang bị đầy đủ phương tiện phòng cháy chữa cháy trước khi bàn giao chung cư cho phía công ty quản lý vận hành là không đảm bảo yêu cầu về phòng cháy chữa cháy.

Hành vi của Tùng vi phạm quy định về nguyên tắc phòng cháy chữa cháy là phải chuẩn bị sẵn sàng lực lượng, phương tiện, phương án và các điều kiện khác để kịp chữa cháy.

Xét xử vụ cháy  chung cư Carina làm 13 người chết: Triệu tập hơn 600 bị hại - 3
Bị cáo Tùng trao đổi với luật sư trước phiên tòa (Ảnh: Thanh Phúc).

Còn Tuấn, với tư cách là Trưởng ban quản lý chung cư, biết rõ tình trạng hệ thống phòng cháy chữa cháy không hoạt động nhưng không thực hiện đầy đủ trách nhiệm, không kiên quyết yêu cầu chủ đầu tư thay thế, sửa chữa nhằm khắc phục, vận hành hoạt động báo cháy, chữa cháy và cứu hộ. Ngoài ra, việc không đóng cửa thang bộ thoát hiểm đã khiến khói độc theo đó lên các tầng trên làm nhiều người chết và bị thương, cũng thuộc trách nhiệm của Ban quản lý.

Nhà chức trách xác định, ông Tùng biết hệ thống báo cháy của chung cư hỏng nhưng không thay, khi hỏa hoạn xảy ra đã gây hậu quả đặc biệt nghiêm trọng.

Thiệt hại trong vụ án được xác định là 126 tỷ đồng. Công ty Hùng Thanh đã bồi thường số tiền 100 tỷ đồng.
',
'2023-04-05',
'assets/anh2.jpg',
N'Xuân Quý',
10
),
(
N'Ông Trump nói Mỹ "đang rơi xuống địa ngục" sau phiên tòa lịch sử',
N'"Tôi chưa bao giờ nghĩ bất kỳ điều gì như thế này có thể xảy ra ở Mỹ. Tội duy nhất mà tôi đã phạm phải là bảo vệ đất nước của chúng ta một cách không sợ hãi", cựu Tổng thống Donald Trump phát biểu trước những người ủng hộ tại dinh thự Mar-a-Lago ở bang Florida vào tối 4/4.

Bài phát biểu được đưa ra ngay sau khi ông Trump có buổi trình diện trước các công tố viên tại quận Manhattan ở thành phố New York. Tại đây, ông đã bị bắt giữ và đưa tới Tòa Hình sự tại quận Manhattan, nơi ông tuyên bố vô tội trước 34 tội danh bị cáo buộc.

"Đất nước của chúng ta sắp rơi xuống địa ngục", ông Trump nói khi đám đông vỗ tay ủng hộ.

Cựu Tổng thống Mỹ nói rằng chiến dịch tranh cử của ông là nạn nhân của hành động can thiệp bầu cử, đồng thời công kích công tố viên New York Alvin Bragg vì đã đưa ra các cáo buộc hình sự chống lại ông.

"Vụ việc giả mạo này được đưa ra chỉ để can thiệp vào cuộc bầu cử năm 2024 sắp tới và nó nên bị hủy bỏ ngay lập tức", ông Trump nhấn mạnh.

10:37 SA 05/04/2023

Nhắm mục tiêu vào chính quyền Tổng thống đảng Dân chủ Joe Biden, Donald Trump, ứng cử viên hàng đầu trong cuộc đua giành đề cử của đảng Cộng hòa trong cuộc bầu cử năm 2024, nói rằng các công tố viên "cực tả" sẵn sàng truy tố ông "bằng bất cứ giá nào".

"Họ không thể đánh bại chúng tôi trong cuộc bỏ phiếu, vì vậy họ cố gắng đánh bại chúng tôi thông qua luật pháp. Chúng ta là một quốc gia đang suy tàn và giờ đây, những kẻ điên cuồng cánh tả cực đoan này muốn can thiệp vào các cuộc bầu cử bằng cách sử dụng cơ quan thực thi pháp luật", ông Trump nói.

Tại phòng xử án tại Tòa Hình sự quận Manhattan, bản cáo trạng nhằm vào cựu Tổng thống đã được công bố, trong đó ông Trump bị đề nghị truy tố với 34 tội danh. Tất cả các tội danh mà cựu Tổng thống Trump bị đề nghị truy tố đều liên quan đến việc "làm giả hồ sơ kinh doanh".

Các công tố viên cho biết luật sư riêng Michael Cohen đã hỗ trợ ông Trump thanh toán 130.000 USD để đổi lấy sự im lặng từ cựu sao khiêu dâm Stormy Daniels thông qua một công ty bình phong có trụ sở tại bang Delaware. Ông Trump sau đó đã trả lại khoản tiền này cho ông Cohen.

Các công tố viên đồng thời cáo buộc ông Trump đã phạm các tội danh trên nhằm "thúc đẩy khả năng ứng cử của mình". Ngoài ra, một số khoản thanh toán cho luật sư Michael Cohen đã được lấy từ chính tài khoản cá nhân của cựu Tổng thống.

Ông Trump cho đến nay vẫn phủ nhận mọi cáo buộc và khẳng định mình vô tội. Ông cũng là cựu tổng thống Mỹ đầu tiên bị truy tố.

"Phiên điều trần này đã gây sốc cho nhiều người. Tuy nhiên, nó không bất ngờ vì thực sự không có bất kỳ hành động trái pháp luật nào ở đây cả", ông Trump viết trên mạng xã hội Truth Social sau phiên tòa.
',
'2023-04-05',
'assets/anh3.jpg',
N'Thành Đạt',
1
),
(
N'Miền Bắc sắp đón không khí lạnh yếu',
N'Dự báo, hôm nay (5/4), các tỉnh Sơn La, Hòa Bình, khu vực Bắc và Trung Trung Bộ có nắng nóng, có nơi nắng nóng gay gắt với nhiệt độ cao nhất phổ biến 35-38 độ, có nơi trên 38 độ; độ ẩm tương đối thấp nhất 35-55%; các khu vực khác của Bắc Bộ, khu vực từ Bình Định đến Phú Yên, Tây Nguyên và Nam Bộ có nắng nóng cục bộ với nhiệt độ cao nhất phổ biến 34-36 độ, có nơi trên 36 độ; độ ẩm tương đối thấp nhất 40-55%.

Ngày 6/4, khu vực Trung Trung Bộ có nắng nóng với nhiệt độ cao nhất phổ biến 35-36 độ, có nơi trên 36 độ; độ ẩm tương đối thấp nhất 45-55%.

Khu vực miền Đông Nam Bộ có nắng nóng với nhiệt độ cao nhất trong ngày phổ biến 35-36 độ, có nơi trên 36 độ; độ ẩm tương đối thấp nhất 40-50%.

Cảnh báo, ngày 6/4, do ảnh hưởng của không khí lạnh yếu nên ở khu vực Bắc Bộ và Bắc Trung Bộ có mưa rào và dông rải rác, cục bộ có mưa vừa, mưa to. Trong mưa dông cần đề phòng lốc, sét, mưa đá và gió giật mạnh. Khu vực này nắng nóng kết thúc.

Từ ngày 7/4 nắng nóng kết thúc ở khu vực Trung Trung Bộ. Nắng nóng ở các tỉnh miền Đông Nam Bộ tiếp tục duy trì.

Do ảnh hưởng của nắng nóng kết hợp với độ ẩm trong không khí giảm thấp và gió Tây Nam gây hiệu ứng phơn nên có nguy cơ xảy ra cháy nổ và hỏa hoạn ở khu vực dân cư do nhu cầu sử dụng điện tăng cao và nguy cơ xảy ra cháy rừng. Ngoài ra, nắng nóng còn có thể gây tình trạng mất nước, kiệt sức, đột quỵ do sốc nhiệt đối với cơ thể người khi tiếp xúc lâu với nền nhiệt độ cao.  

Mưa dông kèm theo các hiện tượng lốc, sét, mưa đá và gió giật mạnh có thể gây ảnh hưởng đến sản xuất nông nghiệp, làm gãy đổ cây cối, hư hại nhà cửa, các công trình giao thông, cơ sở hạ tầng.
',
'2023-05-04',
'assets/anh4.jpg',
N'Hồng Quân',
2
),
(
N'Mỹ viện trợ thêm 2,6 tỷ USD vũ khí cho Ukraine trước trận chiến lớn',
N'Gói viện trợ quân sự mới của Mỹ cho Ukraine bao gồm 500 triệu USD cho các khí tài mới như rocket cho hệ thống pháo phản lực phóng loạt HIMARS, đạn cho hệ thống phòng không Patriot, đạn pháo và đạn cho các vũ khí hạng nhẹ.

Chính quyền Tổng thống Joe Biden cũng phân bổ 2,1 tỷ USD trong quỹ Sáng kiến Hỗ trợ An ninh Ukraine để mua các loại vũ khí, đạn dược và thiết bị khác.

"Mỹ sẽ tiếp tục viện trợ cho Ukraine, để đáp ứng nhu cầu trước mắt của Kiev trên chiến trường và các yêu cầu hỗ trợ an ninh dài hạn", Bộ Quốc phòng Mỹ cho biết.

Kể từ khi xung đột Nga - Ukraine nổ ra vào tháng 2/2022, phương Tây đã rót viện trợ quân sự đáng kể cho chính quyền Kiev. Mỹ cho đến nay vẫn là nước viện trợ nhiều nhất. 

Nga đã nhiều lần chỉ trích việc Mỹ và các đồng minh chuyển giao vũ khí cho Ukraine, cho rằng những động thái này chỉ làm leo thang và kéo dài cuộc chiến. Theo Moscow, với việc phương Tây cung cấp vũ khí, chia sẻ thông tin tình báo và huấn luyện cho quân đội của Kiev, họ trên thực tế đã trở thành một bên của cuộc xung đột.

Tổng thư ký NATO Jens Stoltenberg cũng từng nhận định, cách duy nhất để buộc Nga ngồi vào bàn đàm phán là tiếp tục trang bị vũ khí cho Ukraine. Ông cảnh báo Nga sẽ không đàm phán nếu Moscow tin rằng nước này có thể giành chiến thắng trên chiến trường. Trước đó, vào tháng 12 năm ngoái, nhà lãnh đạo NATO cũng nói rằng, hỗ trợ quân sự cho Ukraine là "con đường nhanh nhất dẫn đến hòa bình".

Ukraine nhiều lần cho biết, nước này cần 600-700 xe chiến đấu bộ binh và 300 xe tăng từ phương Tây để giúp xuyên thủng tuyến phòng thủ của Nga. Gần đây, các nước thành viên NATO, trong đó có Mỹ, Anh, Đức đồng loạt tuyên bố sẽ chuyển xe tăng, xe chiến đấu bộ binh hoặc hệ thống phòng thủ tên lửa hiện đại cho Ukraine. Ngoài ra, Kiev cũng kêu gọi phương Tây cung cấp máy bay chiến đấu và vũ khí hạng nặng để đối phó với Moscow.

Xung đột Nga - Ukraine đã bước sang năm thứ hai, giới chức Mỹ ngày càng lo ngại rằng kho vũ khí, đạn dược cũng như binh sĩ được huấn luyện bài bản của Kiev cạn kiệt dần. Gói viện trợ mới của Mỹ được công bố trong bối cảnh Nga và Ukraine vẫn giao tranh khốc liệt tại các mặt trận, đặc biệt ở thành phố Bakhmut thuộc tỉnh Donetsk.

Cả Nga và Ukraine đều đang dồn nguồn lực cho cuộc chiến ở Bakhmut, một thành phố mà Washington cho rằng không có nhiều ý nghĩa chiến lược. Thay vào đó, Mỹ muốn Ukraine tập trung nguồn lực, chuẩn bị cho chiến dịch phản công quy mô lớn vào cuối mùa xuân để giành lại lãnh thổ. Chiến dịch này có thể bắt đầu từ tháng 5.

Mỹ và các đồng minh đã cam kết cấp hàng trăm xe tăng và xe chiến đấu bọc thép cho Ukraine, đồng thời đang thảo luận biện pháp đáp ứng nhu cầu đạn dược ngày càng lớn của Kiev. Ở hậu trường, giới chức Mỹ khuyến cáo Ukraine sử dụng đạn pháo hiệu quả, tiết kiệm, đặc biệt ở mặt trận Bakhmut, để duy trì nguồn lực cho chiến dịch phản công.
',
'2023-05-06',
'assets/anh5.jpg',
N'Tuấn Vũ',
4
),
(
N'Bán nhà vì thiếu chỗ để ô tô, bỏ nửa tỷ vẫn không mua nổi "lốt" cho 4 bánh',
N'<b>Phải đổi nơi ở vì thiếu chỗ gửi ô tô</b>

Vợ chồng chị Thu Hà (40 tuổi, sinh sống ở một chung cư thuộc quận Đống Đa, Hà Nội) sở hữu ô tô nhưng vẫn phải chịu cảnh mưa nắng vất vả chẳng khác gì đi xe máy.

Gia đình chị mua ô tô muộn hơn các hộ khác nên bãi gửi xe tầng hầm hết "slot" (chỗ). Họ buộc phải gửi ô tô ở một bãi xe cách chung cư hơn 1km. Hàng ngày, chồng chị phải di chuyển bằng xe máy ra bãi gửi, lấy ô tô rồi mới đi làm. Có hôm, vì thấy quá bất tiện, anh phóng luôn xe máy đến cơ quan.

Suốt mấy năm, vợ chồng chị Hà tìm hiểu thông tin để mua lại chỗ để xe nhưng không tài nào mua được. Trước đó, vì từng nghe đến chuyện cư dân cùng tòa chi gần 500 triệu đồng để mua slot ô tô, cả hai bàn nhau và xác định chấp nhận bỏ số tiền tương tự nếu có cơ hội đưa "em 4 bánh" về gần.

"Tuy nhiên, chờ mãi không ai bán, rồi nghĩ bỏ số tiền gần mua được con ô tô mới tầm trung, chồng tôi đã đưa ra một quyết định bất ngờ. Gia đình tôi đã bán căn hộ rộng hơn 100m2, sau đó vay thêm chút tiền mua căn liền kề ở An Khánh, Hoài Đức.

Về đây chúng tôi được ở nhà mặt đất, có chỗ để xe ô tô thoải mái, giao thông thuận tiện, di chuyển vào nội thành chỉ hết khoảng 10 phút", chị Hà kể.


Có kinh nghiệm hơn 10 năm làm môi giới, chị Nguyễn Thị Thúy (nhân viên một công ty bất động sản ở quận Cầu Giấy, Hà Nội) cũng xác nhận, chị gặp không ít trường hợp như chị Hà, thay đổi chỗ ở vì những bất cập liên quan đến chỗ để ô tô.

"Nhiều vị khách sau mấy năm sống trong nội đô tài chính đã tăng lên. Thời điểm họ mua căn chung có thể chỉ 3-5 tỷ đồng, nhưng sau 4-5 năm thì bán được với giá gấp rưỡi, gấp đôi. Khi dịch chuyển ra ngoại thành, họ mua chung cư cao cấp hoặc các căn liền kề và không phải lo lắng về chỗ để ô tô của gia đình hay chỗ để xe khi có khách tới chơi", chị Thúy chia sẻ với Dân trí.

Anh Nguyễn Ngọc Tuấn (nhân viên một công ty bất động sản ở quận Nam Từ Liêm) cho biết, mỗi chung cư khi xây dựng thường tính toán diện tích để ô tô theo quy định.

Có một số chủ đầu tư bán đứt các suất để xe cho khách. Song có những chủ đầu tư giữ lại để khai thác. Họ chủ yếu phân cho các cư dân theo tiêu chí ai về ở sớm, đăng ký sớm thì sẽ có slot. Sau đó, họ thu phí từng tháng và tăng giá tùy theo tình hình vận hành, thị trường.  

Trong quá trình làm việc, chị Thúy hay anh Tuấn đều nhận thấy, nhóm khách hàng có kinh tế thường muốn sở hữu chỗ để ô tô lâu dài. Nhiều chủ đầu tư khi bán căn hộ thường cam kết sẽ có đủ chỗ để ô tô song nhiều người vẫn muốn sở hữu riêng một diện tích đậu xe nhất định cho mình.

Nói về giá bán các suất để xe lâu dài, anh Tuấn cho biết, tùy từng khu vực và từng chủ đầu tư sẽ có mức giá khác nhau. "Chẳng hạn, một dự án ở Nam Từ Liêm năm ngoái giá slot ô tô sở hữu vĩnh viễn là 400 triệu đồng. Giá căn hộ tại dự án này từ 2,6 tỷ đến 4,4 tỷ đồng/căn; giá bán theo m2 từ 35 đến 42 triệu đồng/m2", anh Tuấn kể.

Chị Thúy chia sẻ thêm, giá bán các slot ô tô sỡ hữu lâu dài thường bằng 15-20% giá trị căn hộ. Ở các dự án thuộc khu vực nội thành, mỗi slot ô tô khoảng 300-500 triệu đồng. Mức giá này là rất bình thường.

Những dự án tọa lạc ở vị trí đắc địa có thể lên tới gần 1 tỷ đồng. Những người có tiền hoặc thừa tiền sẽ sẵn sàng bỏ ra số tiền lớn để sở hữu lâu dài một chỗ để xe rộng khoảng 10m2.

Khi sở hữu riêng, họ không phải đóng tiền phí trông xe hàng tháng, không lo biến động về giá khi chủ đầu tư, ban quản lý nâng cấp dịch vụ. "Chỗ để xe là của riêng họ, dù họ không sử dụng thì không ai được để xe chỗ đó. Họ cũng có quyền mua đi bán lại diện tích này", chị Thúy nói.

<b>Cần tính đúng, tính đủ, tính nhiều năm</b>

Theo tìm hiểu của PV Dân trí, nhiều gia đình ở Hà Nội rất quan tâm đến chỗ để ô tô khi mua chung cư. Họ sẵn sàng chi thêm khoản tiền lớn mua các suất đỗ xe nhằm đảm bảo sự ổn định, không bị mất chỗ hay giá thuê tăng theo thời gian. Song thực tế, nhiều người vẫn không thể mua được vì thiếu chỗ để ô tô là bài toán nan giải của Hà Nội nhiều năm nay.

Anh Đào Quang Khánh (36 tuổi) về ở khu đô thị Linh Đàm (Hoàng Mai) đã hơn 3 năm nhưng vẫn không có chỗ để xe. Chung cư anh sinh sống có 300 căn hộ nhưng khu vực để ô tô chỉ đủ cho 120 xe.

Mỗi tháng anh Khánh tốn 1,6 triệu đồng để gửi xe bên ngoài và gặp phải vô số bất tiện. "Đối với những người có ô tô sau như chúng tôi thì không có cơ hội có chỗ để xe trong tòa nhà", anh Khánh nói.

Trao đổi với Dân trí, Phó Chủ tịch Câu lạc bộ Bất động sản Hà Nội Nguyễn Thế Điệp cho rằng, tốc độ phát triển nhanh, số người sở hữu ô tô tăng cao, hoạt động xây dựng chưa nắm bắt được xu thế, chưa có tầm nhìn trong quy hoạch nên việc thiếu chỗ để ô tô là tất yếu. Người dân gặp phải không ít bất cập khi ở một nơi nhưng phải gửi xe một nẻo.


Từ năm 2016, Hà Nội đã đưa ra quy định các dự án nhà cao tầng trên địa bàn thành phố bắt buộc phải có tối thiểu 3 tầng hầm nhằm mục đích tăng cường chỗ để xe cho người dân. Các dự án triển khai trước thời điểm này (đặc biệt là nhà xã hội, nhà tái định cư, nhà giá rẻ) vì thế thiếu trầm trọng chỗ để ô tô.

"Đây là những lỗi chúng ta cần khắc phục ngay. Tỷ lệ về chỗ để xe trong quy hoạch cần phải rõ ràng. Nhà cao tầng phải có tỷ lệ hầm tương xứng. Mỗi dự án nhà ở ít nhất phải có 3 hầm hoặc nhiều hơn, bất kể đó là khu cao cấp, nhà ở xã hội hay nhà giá rẻ; khuyến khích làm bãi đỗ xe nhiều tầng.

Đặc biệt cần tạo cơ chế chính sách khuyến khích để nhiều người đầu tư vào các bãi để xe, một chỗ đỗ nhưng có thể xây 5-7 tầng. Các khu đô thị, nhà thấp tầng phải dành diện tích công cộng đủ cho đỗ xe, không nên để mật độ xây dựng quá cao. Nhìn chung cần tính đúng, tính đủ, tính nhiều năm nhằm đáp ứng được nhu cầu thực tiễn về chỗ đỗ xe ở Hà Nội", ông Điệp nhấn mạnh.

Đối với chi phí thuê chỗ gửi xe hoặc giá bán các slot xe sở hữu lâu dài, vị này cho rằng cũng cần có những quy định rõ ràng để tránh bất cập, khó khăn cho người dân.
',
'2023-05-20',
'assets/anh6.jpg',
N'Mạnh Cường',
5
),
(
N'Cây đổ đứt đường dây, điện giật chết ba người một gia đình ở Bình Dương',
N'Theo đó, vào khoảng 17h30 ngày 4/4, do trời mưa to kèm giông lốc làm cây xanh trên đường thuộc khu phố 2, phường Mỹ Phước, TX Bến Cát, tỉnh Bình Dương bị đổ, đè lên đường dây điện 3 pha khiến dây điện bị đứt.

Cây đổ đứt đường dây, điện giật chết ba người một gia đình ở Bình Dương - 1
Hiện trường nơi xảy ra tai nạn điện khiến 3 người chết (Ảnh lực lượng chức năng cung cấp).

Thời điểm này, bà N.T.N. (SN 1953, ngụ TX Bến Cát) ra quét nước ở phía trước nhà không may va trúng vào dây điện bị đứt dẫn đến bị giật té ngã xuống đất.

Thấy vậy, ông N.V.L (SN 1952, chồng bà N.), cùng N.T.B. (SN 1983, con trai bà N.) và N.T.D. (SN 2011, cháu nội bà N.) ở trong nhà liền chạy ra ngoài để ứng cứu cũng bị điện giật, té ngã.

Vụ việc khiến ông L., anh B. và cháu D. tử vong, riêng bà N. chỉ bị thương.

Nhận tin báo, Công an TX Bến Cát đã phối hợp cùng Công an tỉnh Bình Dương khám nghiệm hiện trường, điều tra làm rõ vụ việc.

Cây đổ đứt đường dây, điện giật chết ba người một gia đình ở Bình Dương - 2
Lãnh đạo tỉnh, thị xã, phường đến thăm hỏi, hỗ trợ gia đình nạn nhân (Ảnh lực lượng chức năng cung cấp).

Tối cùng ngày, trao đổi với phóng viên Dân trí, ông Nguyễn Trọng Ân, Chủ  tịch UBND TX Bến Cát thông tin, lãnh đạo tỉnh, thị xã cùng phường Mỹ Phước đã đến thăm hỏi, động viên gia đình nạn nhân.

Trước mắt, UBND TX Bến Cát hỗ trợ 30 triệu đồng, Ủy ban Mặt trận tổ quốc tỉnh Bình Dương hỗ trợ 30 triệu đồng, UBND phường Mỹ Phước hỗ trợ 10 triệu đồng.
',
'2023-05-08',
'assets/anh7.jpg',
N'Quân Phạm',
3
),
(
N'Xót xa cảnh chồng tai biến, vợ chật vật lo cho 6 miệng ăn',
N'<b>Tai ương ập đến gia đình nghèo</b>
Rạng sáng một ngày đầu tháng 4, chị Ngô Thị Chất (40 tuổi, trú thôn Liên Tiến, xã Mai Phụ, huyện Lộc Hà, tỉnh Hà Tĩnh) thức dậy. Lúc này, 3 con nhỏ của chị vẫn đang chìm trong giấc ngủ. Sau khi xoa bóp chân, tay cho người chồng đang mang bệnh nặng, chị xuống bếp nấu vội nồi cơm và vài món ăn đơn giản. 

Đồ ăn này chị chuẩn bị cho con ăn sáng, đến trường và chồng dùng trong buổi trưa. Rồi chị lặng lẽ dắt xe máy ra khỏi nhà, nổ máy và hướng thẳng về thành phố Hà Tĩnh - nơi cách nhà hơn 10km. Trên xe máy "cõng" xe rùa và xẻng - là những đồ nghề của chị.

Đến nơi, chị Chất đánh bệt xuống vỉa hè đường Nguyễn Du và chờ người ta thuê gì thì làm nấy. Công việc này không có thu nhập ổn định nhưng lại là nguồn sống của 6 con người trong suốt những năm qua.

Chị Chất kết hôn với anh Lê Văn Bình (46 tuổi) vào năm 2009. Họ có 3 người con, cháu gái đầu đang học lớp 6, cháu gái thứ hai học lớp 5 và cháu trai út đang học lớp 2.

Ngoài các con, vợ chồng chị Chất sống với bố mẹ già yếu. Gia đình thuộc diện nghèo khó ở địa phương.

Cuối năm 2018, chính quyền hỗ trợ cho gia đình 40 triệu đồng. Họ vay mượn thêm ngân hàng và người thân để xây căn nhà nhỏ. Trong khi công trình đang xây dựng dở dang thì tai ương ập đến.

"Chồng tôi làm công nhân ở công trường. Việc nặng nhọc, sức khỏe suy giảm, anh vẫn gắng gượng để có tiền lo cho gia đình và trang trải nợ nần. Một hôm khi về vừa trở về nhà, anh bị tai biến, ngã quỵ", chị Chất ngậm ngùi kể.

Trong khi gia đình đưa anh Bình đến nhiều bệnh viện chữa trị, người cha già lại phải đi phẫu thuật vì căn bệnh ung thư dạ dày quái ác. Bệnh của ông sau đó di căn sang gan, phổi, tim. Đến ngày 26/1 Âm lịch vừa qua, bố chồng chị Chất qua đời.

<b>Gánh nặng đổ dồn lên vai người vợ khốn khổ </b>

Hiện nay, anh Bình nằm nhà, muốn di chuyển phải ngồi xe lăn. Mọi sinh hoạt cá nhân của người đàn ông này đều cần đến sự hỗ trợ của người thân. Mỗi khi trái gió trở trời, anh lên cơn co giật, tính khí không bình thường.

Kể từ ngày chồng lâm bệnh và cha chồng qua đời, kinh tế gia đình chị Chất kiệt quệ, nợ chồng nợ.

Gánh nặng cơm áo gạo tiền trong nhà đều đổ dồn lên vai chị Chất. Người phụ nữ gồng mình đi làm thuê, từ bốc vác, phụ hồ đến rửa bát. Ai thuê gì chị cũng làm. Ngày nhiều, chị kiếm được 200.000-300.000 đồng, ngày vài chục nghìn và không ít lần trở về tay không.

"Có hôm mệt, tôi đi khám, kết quả bị đau thoái hóa cổ, hẹp thực quản. Bác sĩ bảo tôi đừng làm việc nặng. Nhưng nếu tôi không đi làm, chồng, mẹ già 74 tuổi thường xuyên đau ốm và 3 con nhỏ sẽ sống sao?", chị Chất giãi bày.

Xót xa cảnh chồng tai biến, vợ chật vật lo cho 6 miệng ăn - 5
Người mẹ chỉ có một ước mong rằng con mình sẽ không phải nghỉ học giữa chừng (Ảnh: Dương Nguyên).

Trong khi chị Chất tâm sự về hoàn cảnh, anh Bình nằm trên giường với ánh mắt vô hồn và chân tay co quắp.

"Cũng có lúc tôi oán trách ông trời bởi răng (sao - PV) số tôi cứ khổ mãi, như phận bèo trôi từ sông ra biển. Nhưng ngay sau đó, tôi lại tự động viên mình, phải mạnh mẽ, bèo trôi về đâu thì trôi. Tôi phải cố gắng vì các con, vì gia đình", chị Chất chia sẻ.

Nói về ước muốn, chị Chất chỉ mong mình đủ sức khỏe, đi làm lo cho gia đình, để mẹ già, chồng con không bị đứt bữa và các cháu không phải bỏ học giữa chừng.

Trao đổi với phóng viên Dân trí, ông Phạm Trọng Hợp, Phó chủ tịch UBND xã Mai Phụ xác nhận, hoàn cảnh của gia đình chị Ngô Thị Chất thuộc diện khó khăn tại địa phương.

"Chồng chị không may bị tai biến, giờ ngồi xe lăn. Ba con của họ đang nhỏ, còn người mẹ già bị suy nhược cơ thể. Mọi gánh vác đều đổ lên vai chị Chất, rất vất vả. Chính quyền địa phương quan tâm hỗ trợ nhưng chỉ được phần nào. Rất mong, hoàn cảnh của họ được nhiều nhà hảo tâm quan tâm, giúp đỡ", ông Hợp nói.
',
'2023-05-09',
'assets/anh8.jpg',
N'Cường Lê',
6
),
(
N'Tỷ phú Mỹ 92 tuổi có thể đã hủy hôn sau 2 tuần công bố cưới lần thứ 5',
N'Vanity Fair dẫn các nguồn tin thân cận với ông Murdoch cho biết, tỷ phú truyền thông 92 tuổi có thể đã chấm dứt hôn ước với bà Ann Lesley Smith, 66 tuổi, cựu người dẫn chương trình phát thanh.

Thông tin này xuất hiện trong bối cảnh kế hoạch đám cưới của ông Murdoch và bà Smith mới được công bố 2 tuần trước. Trước đó, ông Murdoch đã hoàn tất thủ tục ly hôn với người vợ thứ 4, người mẫu Jerry Hall.

Cả ông Murdoch và bà Smith chưa lên tiếng về thông tin trên.

Trong bài báo đăng trên New York Post hôm 20/3, ông Murdoch cho biết đã gặp bà Smith vào tháng 9/2022 khi bà đến thăm vườn nho Moraga Estate của ông ở Bel Air, bang California, Mỹ.

"Tôi đã rất lo lắng. Tôi sợ yêu - nhưng tôi biết đây sẽ là lần cuối cùng của tôi. Tốt nhất nên là như vậy. Tôi đang hạnh phúc", ông phát biểu hồi cuối tháng 3.

Bà Smith khi đó cho biết, bà và ông Murdoch, người sở hữu các trang tin và báo lớn như Fox News và Wall Street Journal, có sự liên kết khi chồng trước của bà cũng là người trong ngành truyền thông.

Các nguồn tin nói với Vanity Fair rằng, họ chưa nắm rõ lý do chính xác dẫn tới việc ông Murdoch có thể đã hủy hôn. Tuy nhiên, một lý do được đưa ra có thể là do tỷ phú Mỹ dường như không hài lòng với quan điểm về tôn giáo của bà Smith.

Tỷ phú Murdoch không chỉ nổi tiếng là Chủ tịch Fox Corp, người sáng lập đế chế truyền thông News Corp hay sở hữu khối tài sản 17,6 tỷ USD, mà ông còn có tiếng đào hoa với 4 lần kết hôn rồi ly hôn.

Ông từng kết hôn với cựu tiếp viên hàng không Patricia Booker, nhà báo Anna Murdoch và doanh nhân Wendi Deng. Ông có tổng cộng 6 người con. Năm 2016, ông kết hôn với người vợ thứ tư, cựu người mẫu Jerry Hall, tại Nhà thờ St. Bride, trên đường London. Họ đã ly hôn vào tháng 8/2022.
',
'2023-05-09',
'assets/anh10.jpg',
N'Vũ Lê',
4
),
(
N'Khoảng 11,5 triệu lượt ý kiến góp ý dự án Luật Đất đai sửa đổi',
N'Sáng nay (5/4), Hội nghị đại biểu Quốc hội hoạt động chuyên trách để thảo luận một số nội dung trình Quốc hội tại kỳ họp thứ 5, Quốc hội khóa XV đã diễn ra với sự chủ trì của Chủ tịch Quốc hội Vương Đình Huệ.

Phát biểu khai mạc, Chủ tịch Quốc hội Vương Đình Huệ nêu rõ, căn cứ Luật Tổ chức hoạt động Quốc hội, Quy chế làm việc của Ủy ban Thường vụ Quốc hội và chương trình hoạt động, để chuẩn bị tốt nhất cho Kỳ họp thứ 5 Quốc hội khóa XV, Ủy ban Thường vụ Quốc hội quyết định triệu tập Hội nghị đại biểu Quốc hội chuyên trách để thảo luận một số dự án luật trình tại Kỳ họp thứ 5.

Khoảng 11,5 triệu lượt ý kiến góp ý dự án Luật Đất đai sửa đổi - 1
Chủ tịch Quốc hội Vương Đình Huệ phát biểu khai mạc Hội nghị đại biểu Quốc hội chuyên trách sáng nay (Ảnh: Quochoi.vn).

Từ đầu nhiệm kỳ Quốc hội khóa XV đến nay, Quốc hội đã xem xét thông qua được 16 luật và nhiều nghị quyết với sự thống nhất đồng thuận cao. Có được điều này là nhờ sự lãnh đạo, chỉ đạo của lãnh đạo Đảng Nhà nước, các cơ quan, sự phối hợp chặt chẽ từ sớm từ xa của các cơ quan hữu quan, sự đóng góp tích cực, trách nhiệm, tâm huyết của các đại biểu Quốc hội nói chung và đại biểu Quốc hội chuyên trách nói riêng.

Từ đầu nhiệm kỳ đến nay, đã có 4 hội nghị đại biểu Quốc hội chuyên trách được tổ chức. Đánh giá chung các hội nghị có chất lượng cao và kết quả tốt, lắng nghe được nhiều ý kiến tâm huyết của các đại biểu Quốc hội chuyên trách.

Chủ tịch Quốc hội cho biết, tại kỳ họp thứ 5 tới, công tác lập pháp là một nhiệm vụ trọng tâm với việc xem xét cho ý kiến và thông qua nhiều dự án lớn và quan trọng. Trong đó, số lượng dự án luật trình xem xét thông qua hoặc xem xét lần đầu dự kiến gấp đôi so với các kỳ họp khác. Số lượng các dự án luật dự kiến đưa vào chương trình là rất lớn do yêu cầu bức thiết của thực tiễn.

Chủ tịch Quốc hội đề nghị các đại biểu Quốc hội tại hội nghị đại biểu Quốc hội chuyên trách lần này tập trung vào 7 dự án luật trong đó có 6 dự án luật trình Quốc hội xem xét thông qua gồm Luật Hợp tác xã sửa đổi, Luật Đấu thầu sửa đổi, Luật Bảo vệ quyền lợi người tiêu dùng sửa đổi Luật Giá sửa đổi, Luật Giao dịch điện tử sửa đổi, Luật Phòng thủ dân sự và dự án Luật Đất đai sửa đổi.

Chủ tịch Quốc hội cho biết, đối với 6 dự án Luật trình Quốc hội xem xét thông qua tại Kỳ họp thứ 5 đã được cơ quan chủ trì soạn thảo và chủ trì thẩm tra tích cực tổ chức nhiều các hội nghị, hội thảo, tọa đàm, nghiên cứu chuyên sâu, lấy ý kiến thêm các đối tượng bị tác động.

Trong quá trình này không có sự phân biệt vai giữa cơ quan chủ trì với cơ quan thẩm tra mà thực chất là "hai trong một" để phối hợp rất chặt chẽ. Với cách làm này thì mặc dù dự án Luật đang trong giai đoạn nào, vai nào chủ trì thì cũng đều được xem xét kĩ lưỡng, với chất lượng cao nhận được sự đồng thuận lớn.

Tại phiên họp thứ 20 và 21, Ủy ban Thường vụ Quốc hội đã cho ý kiến kỹ lưỡng đối với 6 dự án Luật này, nhất là những vấn đề lớn quan trọng hoặc là những vấn đề còn có ý kiến khác nhau. Cho đến nay, về cơ bản như vấn đề lớn ý đã được cơ quan chủ trì soạn thảo và cơ quan thẩm tra cân nhắc kỹ lưỡng và thống nhất.

Chủ tịch Quốc hội cũng cho biết, với việc tổ chức hội nghị đại biểu Quốc hội chuyên trách nhằm tiếp tục thảo luận một cách tập trung các vấn đề còn ý kiến khác nhau. Điều này một mặt nâng cao được chất lượng của các dự án luật. Mặt khác rút được ngắn thời gian của kỳ họp chính thức.

Đối với dự án Luật Đất đai sửa đổi trình cho ý kiến lần thứ hai, Chủ tịch Quốc hội cho biết thời gian qua, việc lấy ý kiến nhân dân đối với dự thảo Luật đã được thực hiện nghiêm túc, nhận được sự hưởng ứng tích cực rộng khắp của các cơ quan, tổ chức các tầng lớp nhân dân. Sơ bộ thì cho đến nay có khoảng 11,5 triệu lượt ý kiến góp ý.

Tại hội nghị này, dự kiến cơ quan chủ trì soạn thảo sẽ báo cáo với đại biểu Quốc hội chuyên trách một số tóm tắt một số vấn đề lớn cần xin ý kiến về dự án Luật Đất đai sửa đổi. Sau hội nghị, căn cứ kết quả lấy ý kiến, tại phiên họp chuyên đề pháp luật hoặc tổ chức phiên họp riêng của Ủy ban Thường vụ Quốc hội để cho ý kiến về dự án luật quan trọng này.

Hội nghị đại biểu Quốc hội chuyên trách diễn ra trong 3 ngày, đồng thời có sự linh động trong điều phối chương trình, Chủ tịch Quốc hội đề nghị các đại biểu Quốc hội chuyên trách nêu cao tinh thần trách nhiệm, tham dự đầy đủ các phiên họp, thể hiện rõ vai trò cầu nối giữa lý luận với thực tiễn, tâm tư nguyện vọng của cử tri, Nhân dân với các quyết sách, trình Quốc hội xem xét và thông qua; nghiên cứu kỹ lưỡng, trao đổi, tranh luận, phản biện với các cơ quan soạn thảo, cơ quan thẩm tra nhằm đóng góp nhiều ý kiến chất lượng, sâu sắc về các dự thảo.
',
'2023-05-04',
'assets/anh10.jpg',
N'Ngọc Tuấn',
7
)
go
create proc pr_updateBaoDaLuu_user
@id int,
@username varchar(255)
as
begin
	if exists (select 1 from tblBaoDaLuu where iMaBao = @id and sTenTaiKhoan = @username)
	begin
		delete from tblBaoDaLuu where iMaBao = @id and sTenTaiKhoan = @username;
	end
	else
	begin
		insert into tblBaoDaLuu
		values(@id, @username)
	end
end
go
exec pr_updateBaoDaLuu_user 3,'admin'
go
alter proc sp_getBaodaluu_User 
@stenUser nvarchar(255)
as
begin
	select tblBao.iMaBao, sTenBao ,sNoiDung,dNgayPhatHanh,sURLAnh,sTenTacGia,sTenTheLoai from tblBao inner join tblTheloaiBao
	on tblBao.iMaTheLoai = tblTheloaiBao.iMaTheLoai
	inner join tblBaoDaLuu on tblBaoDaLuu.iMaBao = tblBao.iMaBao
	inner join tblUser on tblBaoDaLuu.sTenTaiKhoan = tblUser.sTenTaiKhoan
	where tblUser.sTenTaiKhoan = @stenUser 
end
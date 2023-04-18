<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master"
AutoEventWireup="true" CodeBehind="trangchu.aspx.cs"
Inherits="BTL_Web_TinTuc_NangCao.trangchu" %>
<asp:Content
  ID="Content1"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <link
    rel="stylesheet"
    href="/src/assets/css/trangchu_theloai_search/trangchu.css"
  />
  <h2>Báo mới nhất hôm nay cho bạn</h2>
  <div class="content">
    <asp:Repeater ID="rptBaoTrangChu" runat="server">
        <ItemTemplate>
            <section class="item" id="abc">
              <a href="trangconchitiet.aspx?id=<%# Eval("iMaBao") %>">
                <img
                  src="<%# Eval("sURLAnh") %>""
                />
                <div class="information">
                  <div class="label">
                    <p class="title">
                       <%#Eval("sTenBao") %>
                    </p>
                    <p class="sub_title">
                      <%# Eval("sNoiDung").ToString().Substring(0, 100) %> <em>...Xem thêm</em>
                    </p>
                    <section class="description">
                      <p class="time"><%#Eval("dNgayPhatHanh") %></p>
                      <p class="category"><%#Eval("sTenTheLoai") %></p>
                    </section>
                  </div>
                   <%-- icon click lưu báo--%>
                  <i class="fa-regular fa-bookmark active"></i>
                  <i class="fa-solid fa-bookmark new"></i>
                </div>
              </a>
            </section>
        </ItemTemplate>
    </asp:Repeater>
    
  </div>
  <script>
    //GIẢ ĐỊNH NÚT ĐÃ LƯU
    const notSaveBtn = document.querySelectorAll(".fa-regular.fa-bookmark");
    const haveSavedBtn = document.querySelectorAll(".fa-solid.fa-bookmark.new");

    notSaveBtn.addEventListener("click", () => {
      notSaveBtn.classList.remove("active");
        haveSavedBtn.classList.add("active");
    });
    haveSavedBtn.addEventListener("click", () => {
      notSaveBtn.classList.add("active");
      haveSavedBtn.classList.remove("active");
    });
  </script>
</asp:Content>

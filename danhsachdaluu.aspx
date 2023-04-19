<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master"
AutoEventWireup="true" CodeBehind="danhsachdaluu.aspx.cs"
Inherits="BTL_Web_TinTuc_NangCao.danhsachdaluu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <link
    rel="stylesheet"
    href="./src/assets/css/trangchu_theloai_search/trangchu.css"
  />
  <h2>Danh sách báo đã lưu</h2>
      <span id="isEmpty" runat="server" style="color:gray;"></span>

  <div class="content">
    
         <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
            <section class="item" id="abc">
             <a href="#">
        <img
          src="<%#Eval("sURLAnh") %>"
        />
        <div class="label">
          <p class="title">
           <%#Eval("sTenBao") %>
          </p>
          <p class="sub_title">
              <%# Eval("abstract") %> <a href="#" id="see_more"><i>...Xem thêm</i></a>
          </p>
        </div>
        <section class="description">
          <p class="time"><%#Eval("dNgayPhatHanh") %></p>
          <p class="category"><%#Eval("sTenTheLoai") %></p>
        </section>
      </a>
         </section>
        </ItemTemplate>
    </asp:Repeater>
     
   
  </div>
</asp:Content>

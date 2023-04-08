<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master"
AutoEventWireup="true" CodeBehind="theloai.aspx.cs"
Inherits="BTL_Web_TinTuc_NangCao.theloai" %>
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
  <h2 id="titleTheLoai" runat="server"></h2>
  <div class="content">
       <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
           <section class="item" id="abc">
      <a href="#">
        <img
          src="<%#Eval("sURLAnh") %>"
        />
        <div class="label">
          <p class="title" style="font-weight:bold;">
            <%#Eval("sTenBao") %>
          </p>
          <p class="sub_title">
            <%# Eval("sNoiDung").ToString().Substring(0, 100) %> <i>...Xem thêm</i>
              
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

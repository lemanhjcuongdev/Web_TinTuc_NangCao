<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master"
AutoEventWireup="true" CodeBehind="login.aspx.cs"
Inherits="BTL_Web_TinTuc_NangCao.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <link rel="stylesheet" href="./src/assets/css/login_register/login.css" />
  <div class="formdn">
    <h1>Đăng nhập</h1>
    <form id="formdn" method="post" action="#">
      <label>Tài khoản: </label>
      <input  type="text" class="taikhoan" name="inputTK" /><br />
      <div class="error"></div>
      <!-- Vui lòng nhập đủ tên đăng nhập! -->
      <br />
      <label>Mật khẩu: </label>
      <input type="password" class="matkhau" name="inputMK"  /><br />
      <div  id="error" class="error" style="color:red;" runat="server"></div>
      <!-- Vui lòng nhập đủ mật khẩu! -->
      <br />
      <button type="submit" id="btnDangNhap">ĐĂNG NHẬP</button>
    </form>
    <div class="error" ></div>
    <!-- Tên đăng nhập hoặc mật khẩu sai! -->
    <a href="register.aspx">Bạn chưa có tài khoản? Hãy tạo Tài khoản mới!</a>
  </div>
  <script>
    const tkDN = document.querySelector(".taikhoan");
    const mkDN = document.querySelector(".matkhau");

    var btnDN = document.querySelector("#btnDangNhap");

    const formDN = document.querySelector("#formdn");

   /* btnDN.addEventListener("click", function (e) {
      e.preventDefault();
      if (tkDN.value.trim() === "") {
        alert("Tài khoản không được trống");
      } else if (mkDN.value.trim() === "") {
        alert("Mật khẩu không được trống");
      } else {
          //formDN.submit();
          window.location.assign("login.aspx?name=" + tkDN.value + "&pass=" + mkDN.value + "");
      }
    });*/
  </script>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master"
AutoEventWireup="true" CodeBehind="register.aspx.cs"
Inherits="BTL_Web_TinTuc_NangCao.register" %>
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
    <form id="form2" method="post" action="#">
      <label>Tài khoản: </label>
      <input id="inputTKDK" type="text" class="taikhoan1" name="inputTKDK" /><br />
      <div class="error"></div>
      <!-- Vui lòng nhập đủ tên đăng nhập! -->
      <br />
      <label>Mật khẩu: </label>
      <input id="inputMKDK" type="password" class="matkhau1" name="inputMKDK" /><br />
      <div class="error"></div>
      <!-- Vui lòng nhập đủ mật khẩu! -->
      <br />
      <label>Nhập lại mật khẩu: </label>
      <input id="inputMKCheckDK" type="password" class="check" name="inputMKCheckDK" /><br />
      <br />
      <div id="errorMessage" class="error" style="color:red;" runat="server"></div>
      <!-- Mật khẩu nhập lại không khớp! -->
      <br />
      <button class="dangky" type="submit">ĐĂNG KÝ</button>
    </form>
    <div class="error"></div>
    <!-- Tên đăng nhập hoặc mật khẩu sai! -->
    <a href="login.aspx">Bạn đã có tài khoản? Hãy Đăng nhập!</a>
  </div>
  <script>
    const tkDK = document.querySelector(".taikhoan1");
    const mkDK = document.querySelector(".matkhau1");
    const checkDK = document.querySelector(".check");

    var btnDK = document.querySelector('button[class="dangky"]');

    const formDK = document.querySelector("#form2");

    mkDK.addEventListener("change", () => {
      //var regexp = /(?=.*[A-Z])/;
      var regexp = /(?=.*[0-9])/;
      //var regexp = /(?=.*[!@#$%^&*])/;
      console.log(mkDK.value);
      console.log(regexp.test(mkDK.value.trim()));
      console.log(mkDK.value.trim().match(regexp));
      //dùng match để tìm kiếm
    });

    /*btnDK.addEventListener("click", function (e) {
      e.preventDefault();
      if (tkDK.value.trim() === "") {
        alert("Tài khoản không được trống");
      } else if (mkDK.value.trim() === "") {
        alert("Mật khẩu không được trống");
      } else if (checkDK.value.trim() != mkDK.value.trim()) {
        alert("Mật khẩu không trùng khớp");
        checkDK.focus();
      } else {
          //formDK.submit();
          window.location.assign("register.aspx?name=" + tkDK.value + "&pass=" + mkDK.value + "");
      }
    });*/
  </script>
</asp:Content>

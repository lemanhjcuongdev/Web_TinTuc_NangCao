<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master"
AutoEventWireup="true" CodeBehind="dangbai.aspx.cs"
Inherits="BTL_Web_TinTuc_NangCao.dangbai" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <link rel="stylesheet" href="./src/assets/css/dangbai/dangbai.css" />
  <form
    class="dangbai"
    action="dangbai.aspx"
    method="post"
    enctype="multipart/form-data"
  >
    <fieldset>
      <legend>Nhập tiêu đề bài báo</legend>
      <!-- <br /> -->
      <textarea
        name="inputTitle"
        id="inputTitle"
        cols="180"
        rows="4"
        required="required"
      ></textarea>
    </fieldset>
    <br />
    <fieldset>
      <legend>Nhập nội dung bài báo</legend>
      <!-- <br /> -->
      <textarea
        name="inputContent"
        id="inputContent"
        cols="180"
        rows="18"
        required="required"
      ></textarea>
    </fieldset>
    <br />
    <fieldset>
      <legend>Chọn ảnh cho bài báo:</legend>
      <input type="file" name="inputImage" id="inputImage" accept="image/*" />
    </fieldset>
    <br />
    <fieldset>
      <legend>Chọn thể loại:</legend>
      <select name="inputCategory" class="category">
        <option value="Khoa học & Công nghệ">Khoa học & Công nghệ</option>
        <option value="Xã hội">Xã hội</option>
        <option value="E-sport">Thể thao</option>
      </select>
    </fieldset>
    <br />
    <!-- <input id="submit" type="submit" value="ĐĂNG BÀI" /> -->
    <button id="submit" type="submit">ĐĂNG BÀI</button>
  </form>
  <h2>Danh sách báo đã thêm</h2>
  <table>
    <tr>
      <th>Tiêu đề</th>
      <th>Nội dung</th>
      <th>Ảnh</th>
      <th>Thể loại</th>
      <th>Thời gian đăng</th>
    </tr>
    <tr>
      <td>
        <a href="trangconchitiet.aspx?id=18062002">
          <b>Tiêu đề mẫu 1</b>
        </a>
      </td>
      <td>
        Nội dung Lorem ipsum dolor sit amet consectetur adipisicing elit...
      </td>
      <td>
        <a
          href="https://wallpapers.ispazio.net/wp-content/uploads/2021/04/hello-iphone-1.png"
          >https://wallpapers.ispazio.net/wp-content/uploads/2021/04/hello-iphone-1.png</a
        >
      </td>
      <td>Khoa học & Công nghệ</td>
      <td>26/03/2023 lúc 10:10</td>
    </tr>
  </table>
  <script>
    const cate_Select = document.querySelector(".category");
    const inputTitle = document.querySelector("#inputTitle");
    const inputContent = document.querySelector("#inputContent");
    const btnSubmit = document.querySelector("#submit");
    const formDangBai = document.querySelector(".dangbai");
    const inputImage = document.querySelector("#inputImage");

    inputImage.addEventListener("change", function () {
      console.log(inputImage.files[0].size);
      if (inputImage.files[0].size > 1000000) {
        alert("Kích thước tệp phải nhỏ hơn 1MB");
      }
    });

    inputTitle.addEventListener("change", function () {
      var itemArray = inputTitle.value.split(" ");
      console.log(itemArray);
      if (itemArray.length < 3) {
        alert("Tiêu đề tối thiểu phải có 3 từ!");
      }
    });
  </script>
</asp:Content>

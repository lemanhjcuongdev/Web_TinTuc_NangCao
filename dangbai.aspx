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
  <form runat="server"
    class="dangbai"
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
          <asp:DropDownList  ID="ddlTheLoai" ClientIDMode="Static" runat="server"></asp:DropDownList>
    </fieldset>
    <br />
      <div id="parentSubmit">
            <button id="submit" type="button" onclick="actionSubmit(0)">ĐĂNG BÀI</button>
      </div>
    
  </form>

  <h2>Danh sách báo đã thêm</h2>
    <table id="table">
    <asp:Repeater ID="rptBao_user" ClientIDMode="Static" runat="server">
    <HeaderTemplate >
        
            <tr>
              <th>Tiêu đề</th>
              <th>Thể loại</th>
              <th>Thời gian đăng</th>
                <th>ảnh</th>
              <th>Hành động</th>
            </tr>
        <tr id="tr"></tr>
    </HeaderTemplate>
    
    <ItemTemplate>   
        <tr id="<%#Eval("iMaBao") %>">
            <td><a href="trangconchitiet.aspx?id=<%#Eval("iMaBao") %>"> <b><%#Eval("sTenbao") %></b></a></td>
            <td><%#Eval("sTenTheLoai") %></td>
            <td><%#Eval("ngay") %></td>
            <td><img alt="<%# Eval("stenbao") %>" src="<%#Eval("sURLAnh") %>" /> </td>
            <td><button class="editBtn" onclick="actionAlter(<%#Eval("iMaBao") %>)()" >Sửa</button>
            <button class="deleteBtn" onclick="actionDelete(<%#Eval("iMaBao") %>)()">Xóa</button></td>
            
        </tr>
    </ItemTemplate>
    
    </asp:Repeater>
        </table>
  <script>

    inputTitle.addEventListener("change", function () {
      var itemArray = inputTitle.value.split(" ");
      console.log(itemArray);
      if (itemArray.length < 3) {
        alert("Tiêu đề tối thiểu phải có 3 từ!");
      }
    });
      function actionSubmit(id) {
          const cate_Select = document.querySelector(".category");
          const inputTitle = document.getElementById("inputTitle");
          const inputContent = document.getElementById("inputContent");
          const btnSubmit = document.querySelector("#submit");
          const formDangBai = document.querySelector(".dangbai");

          const ddlTheLoai = document.getElementById("ddlTheLoai");
          const editBtn = document.querySelector(".editBtn");
          const deleteBtn = document.querySelector(".deleteBtn");
          const inputImage = document.getElementById("inputImage");

          if (inputImage.value.length == 0) {
              alert('Chưa nhập ảnh!');
              return;
          }
          var formData = new FormData();

          formData.append("id", id);
          formData.append("inputImage", inputImage.files[0]);
          formData.append("inputTitle", inputTitle.value);
          formData.append("inputContent", encodeURIComponent(inputContent.value));
          formData.append("inputTheLoai", ddlTheLoai.value);
          var xhttp = new XMLHttpRequest();
          xhttp.onreadystatechange = function () {
              if (xhttp.readyState == 4 && xhttp.status == 200) {
                  if (xhttp.responseText == "Fail") {
                      alert('Chỉnh sửa thất bại!');
                      return;
                  }
                  if (id == 0) {
                      alert('Đăng bài thành công!');
                      showData(xhttp.responseText);
                  }
                  if (id != 0) {
                      
                      replaceData(xhttp.responseText)
                  }
                  
                  
              }    
          }
          xhttp.open("Post", "ajaxDangBao.aspx" , true);
          xhttp.send(formData);
      }

      function actionAlter(id) {
          const cate_Select = document.querySelector(".category");
          const inputTitle = document.getElementById("inputTitle");
          const inputContent = document.getElementById("inputContent");
          const btnSubmit = document.querySelector("#submit");
          const formDangBai = document.querySelector(".dangbai");

          const ddlTheLoai = document.getElementById("ddlTheLoai");
          const editBtn = document.querySelector(".editBtn");
          const deleteBtn = document.querySelector(".deleteBtn");
          const inputImage = document.getElementById("inputImage");
          var formData = new FormData();
          formData.append("id", id);
          var xhttp = new XMLHttpRequest();
          xhttp.onreadystatechange = function () {
              if (xhttp.readyState == 4 && xhttp.status == 200) {
                  alert('Nhập những gì thay đổi!');
                  var bao = JSON.parse(xhttp.responseText);
                  inputTitle.focus();
                  inputContent.value = bao.noidung;
                  inputTitle.value = bao.tenbao;
                  ddlTheLoai.value = bao.idTheLoai;         
                  btnSubmit.setAttribute("onclick", "actionSubmit('" + id + "')");
              }
          }
          xhttp.open("Post", "ajaxDangBao.aspx", true);
          xhttp.send(formData);
      }

      function replaceData(resJson) {
          var bao = JSON.parse(resJson);
          var shtml = '<td>';
          shtml += '<a href="trangconchitiet.aspx?id=' + bao.idBao + '"> <b>' + bao.tenbao + '</b> </a>';
          shtml += '</td>';
          shtml += '<td>';
          shtml += ddlTheLoai.options[ddlTheLoai.selectedIndex].text;
          shtml += '</td>';
          shtml += '<td>';
          shtml += bao.ngay;
          shtml += '</td>';
          shtml += '<td>';
          shtml += '<img alt="' + bao.tenbao + '" src="' + bao.url + '"/>';
          shtml += '</td>';
          shtml += '<td>';
          shtml += '<button class="editBtn" onclick="actionAlter(' + bao.idBao + ')()" >Sửa</button>';
          shtml += '<button class="deleteBtn" onclick="actionDelete(' + bao.idBao + ')()" >Xóa</button>';
          shtml += '</td>';
          if (bao.idBao != 0) {
              var oldDiv = document.getElementById(bao.idBao);
              oldDiv.remove();
              var parentElement = document.getElementById("table");
              var newElement = document.createElement("tr");
              newElement.id = bao.idBao;
              newElement.innerHTML = shtml;
              parentElement.appendChild(newElement);
              var btnSubmit = document.querySelector("#submit");
              btnSubmit.setAttribute("onclick", "actionSubmit(0)");
              alert('Sửa lại thành công !');
              inputContent.value = null;
              inputTitle.value = null;
              ddlTheLoai.value = null;
          }
      }


      function showData(resJson) {
          var bao = JSON.parse(resJson);
          /*var dateString = bao.ngay;
          let currentDate = new Date(dateString);
          let day = String(currentDate.getDate()).padStart(2, '0');
          let month = String(currentDate.getMonth() + 1).padStart(2, '0');
          let year = currentDate.getFullYear();
          let formattedDate = `${day}/${month}/${year}`;
*/
          var shtml = '<td>';
          shtml += '<a href="trangconchitiet.aspx?id=' + bao.idBao + '"> <b>' + bao.tenbao +'</b> </a>';
          shtml += '</td>';
          shtml += '<td>';
          shtml += ddlTheLoai.options[ddlTheLoai.selectedIndex].text;
          shtml += '</td>';
          shtml += '<td>';
          shtml += bao.ngay;
          shtml += '</td>';
          shtml += '<td>';
          shtml += '<img alt="' + bao.tenbao + '" src="' + bao.url + '"/>';
          shtml += '</td>';
          shtml += '<td>';
          shtml += '<button class="editBtn" onclick="actionAlter('+bao.idBao+')()" >Sửa</button>';
          shtml += '<button class="deleteBtn" onclick="actionDelete(' + bao.idBao +')()">Xóa</button>';
          shtml += '</td>';
          var parentElement = document.getElementById("table");
          var newElement = document.createElement("tr");
          newElement.id = bao.idBao;
          newElement.innerHTML = shtml;
          parentElement.appendChild(newElement); 
      }

      function actionDelete(id) {
          if (!confirm("Bạn muốn xóa chứ ?")) {
              return;
          }
          const btnSubmit = document.querySelector("#submit");
          var formData = new FormData();
          formData.append("delete", id);
          formData.append("isdelete", "yes");
          //ajax quân
          var xhttp = new XMLHttpRequest(); // tạo đối tượng 
          xhttp.onreadystatechange = function () { // xử lý khi dữ liệu trả về từ server ajaxDangBao
              if (xhttp.readyState == 4 && xhttp.status == 200) {
                  alert(xhttp.responseText);
                  var oldDiv = document.getElementById(id);
                  oldDiv.remove();
                  document.getElementById("inputTitle").value = null;
                  document.getElementById("inputContent").value = null;
                  document.getElementById("inputImage").value = null;
                  document.getElementById("inputTitle").focus();
                  btnSubmit.setAttribute("onclick", "actionSubmit(0)");
              }
          }
          xhttp.open("Post", "ajaxDangBao.aspx", true); // truyền dữ liệu 
          xhttp.send(formData);
      }
    
  </script>
</asp:Content>

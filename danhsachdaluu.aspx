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
            <section class="item" id="<%# Eval("iMaBao") %>" data-id="<%# Eval("iMaBao") %>">
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
                      <%# Eval("abstract") %> <em>...Xem thêm</em>
                    </p>
                    <section class="description">
                      <p class="time"><%#Eval("ngay") %></p>
                      <p class="category"><%#Eval("sTenTheLoai") %></p>
                    </section>
                  </div>
                   <%-- icon click lưu báo--%>
                  <i data-value="<%# IsSaved(Eval("iMaBao").ToString()) %>" class="fa-regular fa-bookmark" title="Thêm hoặc xóa bài báo trong danh sách đọc sau"></i>
                </div>
              </a>
            </section>
        </ItemTemplate>
    </asp:Repeater>

  </div>
      <script>
      const notSaveBtns = document.querySelectorAll(".fa-regular"); //lấy tất cả button chưa save

      //check đăng nhập
      let isLoggedIn = document.cookie.toString().slice(0,4)=== "user"

          function renderDSBao() {
              var id = document
              var xhr = new XMLHttpRequest();
            
          }

          notSaveBtns.forEach((btn) => {
            
          //duyệt mảng các nút save
        let saved = btn.dataset.value === "True" ? true : false ;
        if(saved){
            btn.classList.remove("fa-regular")
            btn.classList.add("fa-solid")
          }
          else{
            btn.classList.remove("fa-solid")
            btn.classList.add("fa-regular")
          }

        btn.addEventListener("click",(e)=>{
          e.preventDefault();
          //lấy id bài báo khi click icon lưu
            if (!confirm("Bạn muốn xóa chứ ?")) {
                return;
            }
          const id = e.target.closest(".item").dataset.id
          if(isLoggedIn){
          saved = !saved

          if(saved){
            btn.classList.remove("fa-regular")
            btn.classList.add("fa-solid")
          }
          else{
            btn.classList.remove("fa-solid")
            btn.classList.add("fa-regular")
          }

        //call AJAX thêm vào hoặc xóa khỏi danh sách xem sau
             
              var xhr = new XMLHttpRequest();
              xhr.onreadystatechange = function () {
                  if (xhr.readyState == 4 && xhr.status == 200) {
                      var oldDiv = document.getElementById(id);
                      
                      oldDiv.remove();
                  }
              }

          xhr.open("GET", "trangchu.aspx?id="+ id, true)
              xhr.send()
             
          } else{
              window.location.href = "login.aspx"
            }

        })
        })

      </script>
</asp:Content>

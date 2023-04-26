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
            <section class="item" data-id="<%# Eval("iMaBao") %>">
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

        notSaveBtns.forEach((btn)=>{
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
              xhr.open("GET", "trangchu.aspx?id=" + id, true)
              xhr.send();
              
            }
            if (!isLoggedIn) {
                window.location.href = "login.aspx"
            }
        })
      })
  </script>
</asp:Content>

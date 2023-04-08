<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master"
AutoEventWireup="true" CodeBehind="trangconchitiet.aspx.cs"
Inherits="BTL_Web_TinTuc_NangCao.trangconchitiet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <link
    rel="stylesheet"
    href="./src/assets/css/trangconchitiet/trangconchitiet.css"
  />
    <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
            </div>
                <div class="child_footer1">
               <i>Số lượt xem : <%#Eval("soluotxem") %></i> 
            </div>
            <br />
             <div class="head">
                <p class="theloai"><%#Eval("theloai") %></p>
                <h1 class="title">
                    <%#Eval("tenbao") %>
                </h1>
              </div>
            
              <div class="description">
                <img src="<%#Eval("url") %>"/>
                  <br /><br />
                <pre class="content">
                    <%#Eval("noidung") %>
                </pre>
              </div>

        </ItemTemplate>
    </asp:Repeater>
 
</asp:Content>

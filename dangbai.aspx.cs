using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class dangbai : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie myCookie = Request.Cookies["user"];
            
            if (myCookie != null)
            {
                if (myCookie.Value != "admin")
                {
                        Response.Write("<script>alert('Bạn ko có quyền đăng bài!')</script>");
                        Response.Flush();
                        Response.End();
                        return;        
                } 
                
            }
            else
            {
                Response.Write("<script>alert('Bạn ko có quyền đăng bài!')</script>");
                Response.Flush();
                Response.End();
                return;
            }
            Bao bao = new Bao();
            if (!IsPostBack)
            {
                DataTable data = bao.getAllTheLoaiBao();
                ddlTheLoai.DataSource = data;
                ddlTheLoai.DataTextField = "sTentheloai";
                ddlTheLoai.DataValueField = "iMaTheLoai";
                ddlTheLoai.DataBind();
                DataTable data_user = bao.getAllBao();
                rptBao_user.DataSource = data_user;
                rptBao_user.DataBind();
            }
        }
    }
}
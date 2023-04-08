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
            Bao bao = new Bao();
            if (!IsPostBack)
            {
                DataTable data = bao.getAllTheLoaiBao();
                ddlTheLoai.DataSource = data;
                ddlTheLoai.DataTextField = "sTentheloai";
                ddlTheLoai.DataValueField = "iMaTheLoai";
                ddlTheLoai.DataBind();
                DataTable data_user = bao.getBao_User("Hồng Quân");
                rptBao_user.DataSource = data_user;
                rptBao_user.DataBind();
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace BTL_Web_TinTuc_NangCao
{
    public partial class theloai : System.Web.UI.Page
    {
        string username;
        protected void Page_Load(object sender, EventArgs e)
        {
            string getbao;
            if (!IsPostBack)
            {
                int id = int.Parse(Request.QueryString["id"]);
                if (id == 1)
                {
                    getbao = "Giải trí";
                    titleTheLoai.InnerText = "Báo Giải trí mới nhất";
                    Bao bao = new Bao();
                    Repeater1.DataSource = bao.getTheLoaiBao_Ten(getbao);
                    Repeater1.DataBind();
                  //  Response.Write( Repeater1.Items.Count );
                    
                }
                else if (id == 2)
                {
                    getbao = "Đời sống";
                    titleTheLoai.InnerText = "Báo Xã hội mới nhất";
                    Bao bao = new Bao();
                    Repeater1.DataSource = bao.getTheLoaiBao_Ten(getbao);
                    Repeater1.DataBind();
                   // Response.Write(Repeater1.Items.Count);
                }
                else if (id == 3)
                {
                    getbao = "Thể thao";
                    titleTheLoai.InnerText = "Báo Thể thao mới nhất";
                    Bao bao = new Bao();
                    Repeater1.DataSource = bao.getTheLoaiBao_Ten(getbao);
                    Repeater1.DataBind();
                  //  Response.Write(Repeater1.Items.Count);
                }
               
            }
          
        }
        protected bool IsSaved(string id)
        {
            _ = Request.Cookies["user"] != null ? username = Request.Cookies["user"].Value : username = "";
            Bao bao = new Bao();
            DataTable allBaoDaLuu = bao.getBaodaluu_User(username);

            foreach (DataRow row in allBaoDaLuu.Rows)
            {
                if (row["iMaBao"].ToString() == id)
                {
                    return true;
                }
            }
            return false;
        }
    }
}
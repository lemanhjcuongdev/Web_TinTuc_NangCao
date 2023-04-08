using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class danhsachdaluu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Lấy cookie collection
            HttpCookieCollection cookies = Request.Cookies;
            // Kiểm tra cookie có tồn tại không
            if (cookies["user"] != null)
            {
                // Lấy giá trị của cookie
                string myCookieValue = cookies["user"].Value;
                // Sử dụng giá trị cookie ở đây
                Bao b = new Bao();
                Repeater1.DataSource = b.getBaodaluu_User(myCookieValue);
                 Repeater1.DataBind();
                if (Repeater1.Items.Count == 0)
                {
                    isEmpty.InnerText = "Bạn chưa có bài báo nào được lưu!";
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
           
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Xóa cookie với tên đã cho
            HttpCookie cookie = new HttpCookie("user");
            cookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cookie);
            if (int.Parse(Application["numberWrong"].ToString()) > 0)
            {
                Application["numberWrong"] = (int)Application["numberWrong"] - 1;
            }
            Response.Redirect("trangchu.aspx");
        }
    }
}
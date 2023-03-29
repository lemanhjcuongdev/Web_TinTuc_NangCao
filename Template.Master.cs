using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class Template : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*HttpCookie user = new HttpCookie("user");
            user.Value = "adadad";
            user.Expires = DateTime.Now.AddSeconds(10);
            HttpContext.Current.Response.Cookies.Add(user);*/
        }
    }
}
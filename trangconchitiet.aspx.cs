using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Web.Script.Serialization;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class trangconchitiet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (int.Parse(Request.QueryString["id"]) != 0)
            {
                Bao bao = new Bao();
                bao.UpSoluotxem(int.Parse(Request.QueryString["id"])); // tăng số lượt xem
                bao.getBaoID(int.Parse(Request.QueryString["id"])); // lấy thông tin báo 
                List<Bao> lst = new List<Bao>();
                lst.Add(bao);
                Repeater1.DataSource = lst;
                Repeater1.DataBind();
            }
        }
    }
}
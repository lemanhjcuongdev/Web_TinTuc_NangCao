using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class login : System.Web.UI.Page
    {
        string cnnstr = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string name = Request.QueryString["name"];
                string pass = Request.QueryString["pass"];

                if (name!=null && pass != null)
                {
                    try
                    {
                            using (SqlConnection cnn = new SqlConnection(cnnstr))
                            {
                                using (SqlCommand cmd = new SqlCommand())
                                {
                                    cmd.Connection = cnn;
                                    cnn.Open();
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "select * from tblUser where sTenTaiKhoan = '" + name + "'and sMatKhau='" + pass + "'";
                                    SqlDataReader reader = cmd.ExecuteReader();
                                    if (reader.Read())
                                    {
                                    HttpCookie user = new HttpCookie("user");
                                    user.Value = name;
                                    user.Expires = DateTime.Now.AddSeconds(10);
                                    HttpContext.Current.Response.Cookies.Add(user);

                                    Response.Redirect("trangchu.aspx");
                                    }
                                    else
                                    {
                                     error.InnerHtml = "thông tin đăng nhập không chính xác!";
                                    }
                                    cnn.Close();
                                }
                            }
                    }   
                    catch (Exception ex)
                    {
                        Response.Write("ERORR:" + ex.Message);
                    }
                }
            }
        }
    }
}
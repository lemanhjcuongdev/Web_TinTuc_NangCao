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
                // lấy tk mk khi người dùng click đăng nhập
                string name = Request.Form["inputTK"];
                string pass = Request.Form["inputMK"];
                // check null hay không
                if (name!=null && pass != null)
                {
                    // không null
                    try
                    {
                        // select xem trong cơ sở dữ liệu nếu có tồn tại thì get ra
                            using (SqlConnection cnn = new SqlConnection(cnnstr))
                            {
                                using (SqlCommand cmd = new SqlCommand("getUser",cnn))
                                {
                                    cmd.Connection = cnn;
                                    cnn.Open();
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.AddWithValue("@name", name);
                                    cmd.Parameters.AddWithValue("@pass", pass);
                                SqlDataReader reader = cmd.ExecuteReader();
                                    if (reader.Read())
                                    {
                                    HttpCookie user = new HttpCookie("user");
                                    user.Value = name;
                                    user.Expires = DateTime.Now.AddMinutes(20);
                                    HttpContext.Current.Response.Cookies.Add(user);
                                    Application["numberWrong"] = (int)Application["numberWrong"] + 1;
                                    Response.Redirect("trangchu.aspx");
                                    }
                                    // nếu không sẽ thông báo
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
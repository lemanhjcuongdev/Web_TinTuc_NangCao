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
    public partial class register : System.Web.UI.Page
    {
        //Lấy chuỗi kết nối lưu trong file Web.config
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnnstr = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            if (!IsPostBack)
            {
                // get dữ liệu qua metthob post
                string name = Request.Form["inputTKDK"];
                string pass = Request.Form["inputMKDK"];
                string re_pass = Request.Form["inputMKCheckDK"];
                //check null
                if (name != null && pass != null && re_pass != null)
                {
                    // check trùng
                    if (pass != re_pass)
                    {
                        errorMessage.InnerHtml = "Mật khẩu không trùng nhau";
                    }
                    // thêm mới
                    else
                    {
                        try
                        {
                            using (SqlConnection cnn = new SqlConnection(cnnstr))
                            {
                                using (SqlCommand cmd = new SqlCommand("getUser", cnn))
                                {
                                    cmd.Connection = cnn;
                                    cnn.Open();
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.AddWithValue("@name",name);
                                    cmd.Parameters.AddWithValue("@pass", pass);
                                    SqlDataReader reader = cmd.ExecuteReader();
                                    if (!reader.Read())
                                    {
                                        reader.Close();
                                        HttpCookie user = new HttpCookie("user");
                                        user.Value = name;
                                        user.Expires = DateTime.Now.AddSeconds(30);
                                        HttpContext.Current.Response.Cookies.Add(user);
                                        using (SqlCommand cmda = new SqlCommand("insertUser",cnn))
                                        {
                                            cmda.CommandType = CommandType.StoredProcedure;
                                            cmda.Parameters.AddWithValue("@name", name);
                                            cmda.Parameters.AddWithValue("@pass", pass);
                                            cmda.ExecuteNonQuery();
                                            Application["numberWrong"] = (int)Application["numberWrong"] + 1;
                                            Response.Redirect("trangchu.aspx");
                                        }
                                    }
                                    else
                                    {
                                        errorMessage.InnerHtml = "tài khoản đã tồn tại!";
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
}

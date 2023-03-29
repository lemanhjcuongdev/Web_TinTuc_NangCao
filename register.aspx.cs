﻿using System;
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
                string name = Request.QueryString["name"];
                string pass = Request.QueryString["pass"];

                if (name != null && pass != null)
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
                                if (!reader.Read())
                                {
                                    reader.Close();
                                    Session["name"] = name;
                                    Session["login"] = true;
                                    Session["admin"] = "";
                                    cmd.CommandText = "insert into tblUser(sTenTaiKhoan,sMatKhau) values('"+ name + "','"+ pass + "')";
                                    cmd.ExecuteNonQuery();
                                    Response.Redirect("trangchu.aspx");
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
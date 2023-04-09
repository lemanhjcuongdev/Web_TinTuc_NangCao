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
            HttpCookie myCookie = Request.Cookies["user"];
            
            if (myCookie != null)
            {
                if (myCookie.Value != "admin")
                {
                        Response.Write("<script>alert('Bạn ko có quyền đăng bài!')</script>");
                        Response.Flush();
                        Response.End();
                        return;        
                } 
                
            }
            else
            {
                Response.Write("<script>alert('Bạn ko có quyền đăng bài!')</script>");
                Response.Flush();
                Response.End();
                return;
            }
            Bao baos = new Bao();
            if (!IsPostBack)
            {
                DataTable data = new DataTable();
                data = baos.getAllTheLoaiBao();
                ddlTheLoai.DataSource = data;
                ddlTheLoai.DataTextField = "sTentheloai";
                ddlTheLoai.DataValueField = "iMaTheLoai";
                ddlTheLoai.DataBind();
                List<Bao> lst = new List<Bao>();
                DataTable dataFull = new DataTable();
                dataFull = baos.getAllBao();
                foreach (DataRow row in dataFull.Rows)
                {
                    Bao bao = new Bao();
                    bao.idBao = int.Parse(row["iMaBao"].ToString());
                    bao.tenbao = row["sTenBao"].ToString();
                    bao.noidung = row["sNoiDung"].ToString();
                    bao.idTheLoai = int.Parse(row["iMaTheLoai"].ToString());
                    bao.url = row["sURLanh"].ToString();
                    bao.soluotxem = int.Parse(row["isoluotxem"].ToString());
                    bao.ngayphathanh = DateTime.Parse(row["dNgayPhatHanh"].ToString());
                    bao.ngay = bao.ngayphathanh.ToString("dd-MM-yyyy");
                    lst.Add(bao);
                }
                rptBao_user.DataSource = lst;
                rptBao_user.DataBind();
            }
        }
    }
}
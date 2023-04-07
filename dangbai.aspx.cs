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
            Bao bao = new Bao();
            if (!IsPostBack)
            {
                DataTable data = bao.getAllTheLoaiBao();
                ddlTheLoai.DataSource = data;
                ddlTheLoai.DataTextField = "sTentheloai";
                ddlTheLoai.DataValueField = "iMaTheLoai";
                ddlTheLoai.DataBind();
                DataTable data_user = bao.getBao_User("Hồng Quân");
                rptBao_user.DataSource = data_user;
                rptBao_user.DataBind();
            }
                
            //if (IsPostBack)
            //{
            //    if (Request.HttpMethod == "POST")
            //    {
            //        bao.tacgia = "Hồng Quân";
            //        bao.idTheLoai = Int32.Parse(ddlTheLoai.SelectedValue);
            //        bao.ngayphathanh = DateTime.Now;
            //        bao.tenbao = Request.Form["inputTitle"];
            //        bao.noidung = Request.Form["inputContent"];
            //        HttpPostedFile file = Request.Files["inputImage"];
   
            //        if (file.ContentLength == 0)
            //        {
            //            Response.Write("<script>alert('Chưa có ảnh')</script>");
            //            return;
            //        }
            //        int counter = 10;
            //        string saveDir = "assets/";
            //        string fileName = "anh10.jpg";
            //        string pathToCheck = Server.MapPath("~/" + saveDir + fileName);
            //        string templeName = "";
            //        if (System.IO.File.Exists(pathToCheck))
            //        {
            //            while (System.IO.File.Exists(pathToCheck))
            //            {
            //                templeName = "anh" + counter.ToString() + ".jpg";
            //                pathToCheck = Server.MapPath("~/" + saveDir + templeName);
            //                counter++;
            //            }
            //            fileName = templeName;
            //        }
            //        bao.url = saveDir + fileName;
            //        file.SaveAs(Server.MapPath(saveDir + fileName));
            //        Bao baos = new Bao();
            //        baos.addBao(bao);
                    
            //    }               
            //}
        }
    }
}
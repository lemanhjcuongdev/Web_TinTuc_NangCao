using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Web.Script.Serialization ;
using System.IO;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class ajax : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Bao bao = new Bao();
            //xóa báo
            if (Request.Form["delete"] != null)
            {
                int id = int.Parse(Request.Form["delete"]);   
                if (bao.removeBao(id))
                {
                    Response.Flush();
                    Response.Write("Xóa thành công!");
                    Response.End();
                    return;
                }
                else
                {
                    Response.Flush();
                    Response.Write("Xóa thất bại!");
                    Response.End();
                    return;
                }
            }

            // lấy giá trị truyền vào input
            if (Request.Form["id"] != null & Request.Form["inputTitle"] == null)
            {
                bao.idBao = int.Parse(Request.Form["id"]);
               bao.getBaoID(bao.idBao); // lấy thông tin báo theo id truyền vào từ nút sửa
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string json = serializer.Serialize(bao);    // đóng gói thành json và truyền về Client
                Response.Write(json);
                Response.ContentType = "application/json; charset=utf-8";
                Response.End();
                return;
            }

            // gán data vào Báo 
            bao.tacgia = "admin";
            bao.ngayphathanh = DateTime.Now;
            bao.ngay = bao.ngayphathanh.ToString("dd-MM-yyyy");
            bao.tenbao = Request.Form["inputTitle"];
            bao.noidung = HttpUtility.UrlDecode(Request.Form["inputContent"].ToString());
            bao.idTheLoai = int.Parse(Request.Form["inputTheLoai"]);

            // xử lý lưu ảnh tránh trùng tên
            HttpPostedFile file = Request.Files["inputImage"];
            int counter = 1;
            string saveDir = "assets/";
            string fileName = "anh1.jpg";
            string pathToCheck = Server.MapPath("~/" + saveDir + fileName);
            string temptName = "";
            if (File.Exists(pathToCheck))
            {
                while (File.Exists(pathToCheck))
                {
                    temptName = "anh" + counter.ToString() + ".jpg";
                    pathToCheck = Server.MapPath("~/" + saveDir + temptName);
                    counter++;
                }
                fileName = temptName;
            }
            bao.url = saveDir + fileName;
            file.SaveAs(Server.MapPath(saveDir + fileName));

            // sửa báo
            if (Request.Form["id"]!=null && int.Parse(Request.Form["id"]) != 0) // 0 là id ảo dành cho trường hợp đăng báo
                {
                    bao.idBao = int.Parse(Request.Form["id"]);
                    
                    if (bao.updateBao(bao))
                    {
                        bao.idBao = int.Parse(Request.Form["id"]);
                        //bao.getBaoID(int.Parse(Request.Form["id"]));
                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        string json = serializer.Serialize(bao);
                        Response.Write(json);
                        Response.ContentType = "application/json; charset=utf-8";
                        Response.End();
                    }
                    if (!bao.updateBao(bao))
                    {
                        Response.Write("Fail");
                        Response.End();
                        return;
                    }
                }

            
            //đăng báo
            if (Request.Form["id"] != null && int.Parse(Request.Form["id"]) == 0) // Trường hợp khi id =0 thì xác định là đăng báo , coi 0 là id ảo vì ko lấy giá trị này 
            {
                bao.addBao(bao); // thêm báo
                bao.getIDBao(); // lấy id báo vừa thêm
                bao.getBaoID(bao.idBao);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string json = serializer.Serialize(bao);
                Response.Write(json);
                Response.ContentType = "application/json; charset=utf-8";
                Response.End();
            }


        }
        }
    }
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
            // lấy giá trị truyền vào input
            if (Request.Form["id"] != null & Request.Form["inputTitle"]==null)
                {
                    bao.idBao = int.Parse(Request.Form["id"]);
                    bao = bao.getBaoID(bao.idBao);
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    string json = serializer.Serialize(bao);
                    Response.Write(json);
                    Response.ContentType = "application/json; charset=utf-8";
                    Response.End();
                    return;
                }
                //xóa
                if(Request.Form["delete"] != null)
                {
                    int id =  int.Parse(Request.Form["delete"]);
                    bao = bao.getBaoID(id);
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
                bao.tacgia = "admin";
                bao.ngayphathanh = DateTime.Now;
                bao.ngay = bao.ngayphathanh.ToString("MM-dd-yyyy");
                bao.tenbao = Request.Form["inputTitle"];
                bao.noidung = Request.Form["inputContent"];
                bao.idTheLoai = int.Parse(Request.Form["inputTheLoai"]);
                HttpPostedFile file = Request.Files["inputImage"];
                int counter = 10;
                string saveDir = "assets/";
                string fileName = "anh10.jpg";
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
                if(int.Parse(Request.Form["id"]) != 0)
                {
                    bao.idBao = int.Parse(Request.Form["id"]);
                    
                    if (bao.updateBao(bao))
                    {
                        bao.idBao = int.Parse(Request.Form["id"]);
                        bao.getBaoID(int.Parse(Request.Form["id"]));
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
                if (int.Parse(Request.Form["id"]) == 0)
                {
                    
                    bao.addBao(bao);
                    bao.idBao = bao.getID();
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
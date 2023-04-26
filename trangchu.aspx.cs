using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace BTL_Web_TinTuc_NangCao
{
    public partial class trangchu : System.Web.UI.Page
    {
        int id;
        string username;
        protected void Page_Load(object sender, EventArgs e)
        {
            //lấy cookie để lấy username
            _ = Request.Cookies["user"] != null ? username = Request.Cookies["user"].Value : username = "";

            //bind data
            Bao bao = new Bao();
            DataTable dtAllBao = bao.getAllBao();
            // sắp xếp báo theo mới nhất
           // dtAllBao = dtAllBao.AsEnumerable().OrderByDescending(row => row["dNgayPhatHanh"]).CopyToDataTable();
            rptBaoTrangChu.DataSource = dtAllBao;
            rptBaoTrangChu.DataBind();

            //xử lý lúc ajax thêm vào danh sách xem sau
            if (Request.QueryString["id"]!=null && username != "")
            {
                id = int.Parse(Request.QueryString["id"].ToString());

                Bao updateLuuBao = new Bao();
                updateLuuBao.updateBaoDaLuu_User(id, username);
            }
        }

        //check đã lưu vào danh sách xem sau chưa
        protected bool IsSaved(string id)
        {
            _ = Request.Cookies["user"] != null ? username = Request.Cookies["user"].Value : username = "";
            Bao bao = new Bao();
            DataTable allBaoDaLuu = bao.getBaodaluu_User(username);

            foreach(DataRow row in allBaoDaLuu.Rows)
            {
                if(row["iMaBao"].ToString() == id)
                {
                    return true;
                }
            }
            return false;
        }
    }
}
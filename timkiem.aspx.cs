using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


namespace BTL_Web_TinTuc_NangCao
{
    public partial class timkiem : System.Web.UI.Page
    {

        string username, searchValue;
        protected void Page_Load(object sender, EventArgs e)
        {
            //lấy cookie để lấy username
            _ = Request.Cookies["user"] != null ? username = Request.Cookies["user"].Value : username = "";

            if (Request.QueryString["inputSearch"] != null)
            {
                searchValue = Request.QueryString["inputSearch"].ToString();
                //bind data
                Bao bao = new Bao();
                rptTimKiem.DataSource = bao.timkiemBao(searchValue);
                rptTimKiem.DataBind();

                //hiện thông tin kết quả
                DataTable dsBaoTimKiem = new DataTable();
                dsBaoTimKiem = bao.timkiemBao(searchValue);
                result.InnerText = "Có '"+ dsBaoTimKiem.Rows.Count.ToString() + "' tin tức về '"+ searchValue + "'";
            }
        }
        //check đã lưu vào danh sách xem sau chưa
        protected bool IsSaved(string id)
        {
            //lấy cookie user
            _ = Request.Cookies["user"] != null ? username = Request.Cookies["user"].Value : username = "";
            Bao bao = new Bao();
            DataTable allBaoDaLuu = bao.getBaodaluu_User(username);

            foreach (DataRow row in allBaoDaLuu.Rows)
            {
                if (row["iMaBao"].ToString() == id)
                {
                    return true;
                }
            } 
            return false;
        }
    }
}
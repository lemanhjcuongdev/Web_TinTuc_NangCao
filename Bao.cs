using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
namespace BTL_Web_TinTuc_NangCao
{
    public class Bao
    {
        public int idBao { get; set; }
        public string tenbao { get; set; }
        public string noidung { get; set; }
        public string url { get; set; }
        public DateTime ngayphathanh { get; set; }
        public string ngay { get; set; }
        public string tacgia { get; set; }
        public int idTheLoai { get; set; }
        public string theloai { get; set; }
        public int soluotxem { get; set; }


        public Bao()
        {
            ngay = ngayphathanh.ToString("MM-dd-yyyy");
        }

        string constr = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString.ToString();

        public DataTable getAllBao()
        {
            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getAllBao", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using(SqlDataAdapter sqlData = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        
                        sqlData.Fill(dt);
                        dt.Columns.Add("ngay", (typeof(string)));
                        dt.Columns.Add("abstract", (typeof(string)));
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if(dt.Rows[i]["sNoidung"].ToString().Length > 100)
                            {
                                dt.Rows[i]["abstract"] = dt.Rows[i]["sNoidung"].ToString().Substring(0, 100);
                            }
                            else
                            {
                                dt.Rows[i]["abstract"] = dt.Rows[i]["sNoidung"].ToString();
                            }
                            dt.Rows[i]["ngay"] = (string)((DateTime)dt.Rows[i]["dNgayPhatHanh"]).ToString("dd-MM-yyyy");
                        }
                        return dt;
                    }
                }
            }
        }

        public DataTable getTheLoaiBao_Ten(string username)
        {

            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getTheLoaiBao_Ten", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@tentheloai ", username);
                    using (SqlDataAdapter sqlData = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sqlData.Fill(dt);
                        dt.Columns.Add("ngay", (typeof(string)));
                        dt.Columns.Add("abstract", (typeof(string)));
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["sNoidung"].ToString().Length > 100)
                            {
                                dt.Rows[i]["abstract"] = dt.Rows[i]["sNoidung"].ToString().Substring(0, 100);
                            }
                            else
                            {
                                dt.Rows[i]["abstract"] = dt.Rows[i]["sNoidung"].ToString();
                            }
                            dt.Rows[i]["ngay"] = (string)((DateTime)dt.Rows[i]["dNgayPhatHanh"]).ToString("dd-MM-yyyy");
                        }
                        return dt;
                    }
                }
            }
        }

        public Bao getBaoID(int id)
        {
            Bao bao = new Bao();
            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getBao_ID", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", id);
                    using (SqlDataAdapter sqlData = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sqlData.Fill(dt);
                        foreach (DataRow row in dt.Rows)
                        {
                            bao.idBao = id;
                            bao.tenbao = row["sTenBao"].ToString();
                            bao.noidung = row["sNoiDung"].ToString();
                            bao.idTheLoai = int.Parse(row["iMaTheLoai"].ToString());
                            bao.url = row["sURLanh"].ToString();
                            bao.soluotxem = int.Parse(row["isoluotxem"].ToString());
                            bao.ngayphathanh = DateTime.Parse(row["dNgayPhatHanh"].ToString());
                            bao.ngay = bao.ngayphathanh.ToString("MM-dd-yyyy");
                        }
                    }
                }
            }
            return bao;
        }

        public int getID()
        {
            int id = 0;
            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getIDBao", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                            id= int.Parse(rd["iMaBao"].ToString());
                    }
                }
            }

            return id;
        }

        public string getTheloai(int id)
        {
            string theloai= "";
            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getTheLoaiBao", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", id);
                    SqlDataReader rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        theloai = rd["sTenTheLoai"].ToString();
                    }
                }
            }

            return theloai;
        }

        public bool updateBao(Bao bao)
        {
            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_updateBao", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", bao.idBao);
                    cmd.Parameters.AddWithValue("@sTenBao", bao.tenbao);
                    cmd.Parameters.AddWithValue("@sNoiDung", bao.noidung);
                    cmd.Parameters.AddWithValue("@sURLAnh", bao.url);
                    cmd.Parameters.AddWithValue("@iMaTheLoai", bao.idTheLoai);
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        public DataTable getBao_User(string username)
        {

            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getBao_User", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@stentaikhoan ",username);
                    using (SqlDataAdapter sqlData = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sqlData.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public DataTable getBaodaluu_User(string username)
        {

            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getBaodaluu_User", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@stenUser ", username);
                    using (SqlDataAdapter sqlData = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sqlData.Fill(dt);
                        dt.Columns.Add("ngay", (typeof(string)));
                        dt.Columns.Add("abstract", (typeof(string)));
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["sNoidung"].ToString().Length > 100)
                            {
                                dt.Rows[i]["abstract"] = dt.Rows[i]["sNoidung"].ToString().Substring(0, 100);
                            }
                            else
                            {
                                dt.Rows[i]["abstract"] = dt.Rows[i]["sNoidung"].ToString();
                            }
                            dt.Rows[i]["ngay"] = (string)((DateTime)dt.Rows[i]["dNgayPhatHanh"]).ToString("dd-MM-yyyy");
                        }
                        return dt;
                    }
                }
            }
        }

        public void updateBaoDaLuu_User(int id, string username)
        {
            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("pr_updateBaoDaLuu_user", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@username ", username);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public DataTable getAllTheLoaiBao()
        {

            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getAllTheLoaiBao", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter sqlData = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sqlData.Fill(dt);
                        return dt;
                    }
                }
            }
        }
        
        public bool addBao(Bao bao )
        {

            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_AddBao", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@sTenBao", bao.tenbao);
                    cmd.Parameters.AddWithValue("@sNoiDung", bao.noidung);
                    cmd.Parameters.AddWithValue("@dNgayPhatHanh", DateTime.Now);
                    cmd.Parameters.AddWithValue("@sURLAnh", bao.url);
                    cmd.Parameters.AddWithValue("@sTenTacgia", bao.tacgia);
                    cmd.Parameters.AddWithValue("@iMaTheLoai", bao.idTheLoai);
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if(rowsAffected > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        public bool removeBao(int id)
        {

            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_DeleteBao", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", id);    
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        public void UpSoluotxem(int id)
        {

            using (SqlConnection connection = new SqlConnection(constr))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_UPluotxem", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", id);
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        
                        return ;
                    }
                    else
                    {
                        return ;
                    }
                }
            }
        }
    }
}
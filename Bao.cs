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

        public Bao()
        {
        }

        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString.ToString();

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


    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class assessmentPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                getcl();
                getdata();
                lblkno.Text = Session["KNO"].ToString() + fcl;
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string jo
        {
            get
            {
                return Session["JO"].ToString();
            }
        }
        private string kno
        {
            get
            {
                return Session["KNO"].ToString();
            }
        }
        private string fcl
        {
            get
            {
                if (Session["FCL"] == null)
                {
                    return "";
                }
                else
                {
                    return Session["FCL"].ToString();
                }
            }
        }
        private string scl
        {
            get
            {
                if (Session["SCL"] == null)
                {
                    return "";
                }
                else
                {
                    return Session["SCL"].ToString();
                }
            }
        }
        private void getcl()
        {
            string cs = ConfigurationManager.ConnectionStrings["sqlcon1"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select clno from kmdi_fabrication_tb where KMDI_NO='" + kno + "'", sqlcon);
                using (SqlDataReader rd = sqlcmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        ViewState["FCL"] = rd[0].ToString();
                    }
                }


                SqlCommand sqlcmd1 = new SqlCommand("select clno from KMDI_SCREENFAB_TB where KMDI_NO='" + kno + "'", sqlcon);
                using (SqlDataReader rd1 = sqlcmd1.ExecuteReader())
                {
                    while (rd1.Read())
                    {
                        ViewState["SCL"] = rd1[0].ToString();
                    }
                }

            }

        }
        private void getdata()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    DataSet ds = new DataSet();
                    ds.Clear();
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "stpmaterialsused";
                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@kno", kno);
                    sqlcmd.Parameters.AddWithValue("@fcl", fcl);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "tb");
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

        }

        protected void btnreload_Click(object sender, EventArgs e)
        {
            getcl();
        }
    }

}
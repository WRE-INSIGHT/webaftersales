using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;


namespace webaftersales.AFTERSALESPROJ
{
    public partial class Stock_Used_Summary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {

                if (!IsPostBack)
                {
                    getdata();
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/loginPage.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void getdata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.CommandText = "Stock_Used_Stp";
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@Stock_Used", ddlStockUsed.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds, "tb");

                        gv.DataSource = ds;
                        gv.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }


        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getdata();
        }
    }
}
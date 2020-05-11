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
    public partial class importparts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        getdata();
                        getpricelist();
                    }
                }
                else
                {
                    Response.Redirect("~/AFTERSALESPROJ/invalidaccessPage.aspx");
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/loginPage.aspx");
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
        private string iid
        {
            get
            {
                return Session["IID"].ToString();
            }
        }
        private void getpricelist()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                DataSet ds = new DataSet();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    string str = "select ID, " +
                   "       SPECIFICATION," +
                   "       ARTICLENO as [ARTICLE NO]," +
                   "       DESCRIPTION," +
                   "       UNIT," +
                   "       UNITPRICE AS[UNIT PRICE]," +
                   "       REMARKS" +
                   "       from ACCESSORIESTB" +
                   "       where " +
                   "       description like @searchkey or" +
                   "       articleno like @searchkey or" +
                   "       specification like @searchkey";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@searchkey", "%" + searchtbox.Text + "%");
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView2.DataSource = ds;
                        GridView2.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void getdata()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                DataSet ds = new DataSet();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    string str = "select * from partstb where iid = @iid";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }


        protected void tboxunitprice_TextChanged(object sender, EventArgs e)
        {
            if (tboxunitprice.Text != "" && tboxqty.Text != "" && tboxmarkup.Text != "")
            {
                double netamount, v, w, x, y, z;
                w = double.Parse(tboxmarkup.Text);
                x = double.Parse(tboxqty.Text);
                y = double.Parse(tboxunitprice.Text);

                z = x * y;
                v = z * (w * 0.01);
                netamount = z + v;
                tboxnetprice.Text = Convert.ToString(netamount);
            }
            else
            {
                tboxnetprice.Text = "0";
            }
        }

        protected void insertbtn_Click(object sender, EventArgs e)
        {
            addfunction(tboxarticle.Text, tboxdescription.Text, tboxmarkup.Text, tboxunitprice.Text, tboxqty.Text, tboxnetprice.Text);
        }
        private void addfunction(string articleno, string description, string markup, string unitprice, string qty, string netprice)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "  declare @id as integer = (select isnull(max(id),0)+1 from partstb) " +
                  "  insert into partstb(id, iid, articleno, description, markup, unitprice, qty, netamount) " +
                  "  values(@id, @iid, @articleno, @description, @markup, @unitprice, @qty, @netamount)";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        sqlcmd.Parameters.AddWithValue("@articleno", articleno);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@markup", markup);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@qty", qty);
                        sqlcmd.Parameters.AddWithValue("@netamount", netprice);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                getdata();
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            getpricelist();
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myimport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                ((Panel)row.FindControl("Panel3")).Visible = true;
            }
            if (e.CommandName == "myadd")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];

                double netamount, v, w, x, y, z;
                w = double.Parse(((TextBox)row.FindControl("importmarkuptbox")).Text);
                x = double.Parse(((TextBox)row.FindControl("importqtytbox")).Text);
                y = double.Parse(((Label)row.FindControl("lblunitprice")).Text);

                z = x * y;
                v = z * (w * 0.01);
                netamount = z + v;

                addfunction(((Label)row.FindControl("lblarticleno")).Text,
                    ((Label)row.FindControl("lbldescription")).Text,
                    w.ToString(),
                    y.ToString(),
                    x.ToString(), netamount.ToString());
            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                ((Panel)row.FindControl("Panel3")).Visible = false;
            }
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            getpricelist();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}
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
    public partial class quotation : System.Web.UI.Page
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
        private string cin
        {
            get
            {
                return Session["callinnumber"].ToString();
            }
        }
        private void getdata()
        {
            try
            {
                GridView1.SelectedIndex = -1;
                string str = "select ID," +
                          "   CIN," +
                          "   ASENO," +
                          "   case when isdate(QDATE)=1 then format(cast(qdate as date),'MMM-dd-yyyy') else qdate end as [DATE]," +
                          "   format(OTHERCHARGES, 'n2') as [OTHER CHARGES]," +
                          "   PARTICULAR," +
                          "   case when isdate(ACCEPTED)=1 then format(cast(ACCEPTED as date),'MMM-dd-yyyy') else ACCEPTED end as ACCEPTED," +
                          "   format(NETPRICE, 'n2') as NETPRICE," +
                          "   format(Actualprice, 'n2') as [ACTUAL PRICE]" +
                          "   from quotationtb where cin = @cin";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        DataSet ds = new DataSet();
                        sqlcmd.Parameters.AddWithValue("@CIN", cin);
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        protected void newbtn_click(object sender, EventArgs e)
        {
            try
            {
                if (othertbox.Text == "")
                {
                    othertbox.Text = "0";
                }

                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    bool duplicate;
                    string find = " select * from quotationtb where ASENO = @aseno";
                    SqlCommand cmd = new SqlCommand(find, sqlcon);
                    cmd.Parameters.AddWithValue("@aseno", asetbox.Text);
                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.HasRows)
                        {
                            duplicate = true;
                            CustomValidator err = new CustomValidator();
                            err.ValidationGroup = "newval";
                            err.IsValid = false;
                            err.ErrorMessage = "duplicate record";
                            Page.Validators.Add(err);
                            return;
                        }
                        else
                        {
                            duplicate = false;
                        }

                    }
                    if (!duplicate)
                    {
                        string str = " declare @id as integer = (select isnull(max(id), 0) + 1 from quotationtb)" +
                          " insert into quotationtb (id, cin, aseno, qdate, particular, othercharges)values(@id, @cin, @aseno, @qdate, @particular, @othercharges)";
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcmd.Parameters.AddWithValue("@cin", cin);
                            sqlcmd.Parameters.AddWithValue("@qdate", datetbox.Text);
                            sqlcmd.Parameters.AddWithValue("@aseno", asetbox.Text);
                            sqlcmd.Parameters.AddWithValue("@othercharges", othertbox.Text);
                            sqlcmd.Parameters.AddWithValue("@particular", particulartbox.Text);
                            sqlcmd.ExecuteNonQuery();

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                getdata();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = rowindex;
                ((Panel)row.FindControl("Panel1")).Visible = true;
                string x;
                if (((Label)row.FindControl("acceptedlbl")).Text == "Pending")
                {
                    x = "";
                }
                else
                {
                    x = ((Label)row.FindControl("acceptedlbl")).Text;
                    DateTime value;
                    if (DateTime.TryParse(x, out value))
                    {
                        x = Convert.ToDateTime(x).ToString("MM-dd-yyyy");
                    }
                }


                ((TextBox)row.FindControl("editaccepteddatetbox")).Text = x;
                DateTime v;
                if (DateTime.TryParse(((Label)row.FindControl("datelbl")).Text, out v))
                {
                    ((Label)row.FindControl("datelbl")).Text = Convert.ToDateTime(((Label)row.FindControl("datelbl")).Text).ToString("MM-dd-yyyy");
                }
                ((TextBox)row.FindControl("editdatetbox")).Text = ((Label)row.FindControl("datelbl")).Text;
                ((TextBox)row.FindControl("editasenotbox")).Text = ((Label)row.FindControl("asenolbl")).Text;
                ((TextBox)row.FindControl("editparticulartbox")).Text = ((Label)row.FindControl("particularlbl")).Text;
                ((TextBox)row.FindControl("editothertbox")).Text = ((Label)row.FindControl("otherlbl")).Text;
            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = -1;
                ((Panel)row.FindControl("Panel1")).Visible = false;
            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatefunction(((Label)row.FindControl("idlbl")).Text,
                ((TextBox)row.FindControl("editaccepteddatetbox")).Text,
                ((TextBox)row.FindControl("editdatetbox")).Text,
                ((TextBox)row.FindControl("editasenotbox")).Text,
                ((TextBox)row.FindControl("editparticulartbox")).Text,
                ((TextBox)row.FindControl("editothertbox")).Text);
            }
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunction(((Label)row.FindControl("idlbl")).Text);
            }
        }

        private void updatefunction(string id, string accepted, string qdate, string aseno, string paritular, string othercharges)
        {
            try
            {

                string str = " update quotationtb set accepted=@accepted, aseno=@aseno, qdate =@qdate, particular=@particular, othercharges=@othercharges where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@accepted", accepted);
                        sqlcmd.Parameters.AddWithValue("@qdate", qdate);
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        sqlcmd.Parameters.AddWithValue("@particular", paritular);
                        sqlcmd.Parameters.AddWithValue("@othercharges", othercharges);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                getdata();
            }
        }

        private void deletefunction(string id)
        {
            try
            {

                string str = " delete from quotationtb where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                getdata();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}
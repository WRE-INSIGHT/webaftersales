using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class requestedquotation : System.Web.UI.Page
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
            }
        }
        private string cin
        {
            get
            {
                return Session["CIN"].ToString();
            }
        }
        private void getdata()
        {
            GridView1.DataSource = dal.requknumber.getkno(sid);
            GridView1.DataBind();
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
                            err.ErrorMessage = "duplicate record ase# already exist!";
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
                          " insert into quotationtb (id, cin,sid, aseno, qdate, particular, othercharges)values(@id, @cin,@sid, @aseno, @qdate, @particular, @othercharges)";
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcmd.Parameters.AddWithValue("@sid", sid);
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
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                if (IsValid)
                {
                    reviseitems(sid);
                }
         
            }
        }
        private void reviseitems(string sid)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon1 = new SqlConnection(cs))
                {
                    sqlcon1.Open();
                    string finditem = "select * into #tbl from(select distinct iid from                   " +
                                     "[quotationrequesttbl]												  " +
                                     "where iid in (select id from reporttb where sid = @sid)) as tbl	  " +
                                     "select * from reporttb where id in (select * from #tbl)			  ";

                    using (SqlCommand sqlcmd = new SqlCommand(finditem, sqlcon1))
                    {
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {


                            while (rd.Read())
                            {
                                string itemid = "";
                                string insertitem = " declare @itemid as integer = (select isnull(max(id),0)+1 from itemtb)" +
                                                    " insert into itemtb(id, aseno, ITEM, kno, wdwloc,kid)" +
                                                    " values(@itemid, @aseno, @item, @kno, @loc, @kid)" +
                                                    " select @itemid";
                                using (SqlConnection sqlcon = new SqlConnection(cs))
                                {
                                    using (SqlCommand cmd = new SqlCommand(insertitem, sqlcon))
                                    {
                                        sqlcon.Open();
                                        cmd.Parameters.AddWithValue("@sid", sid);
                                        cmd.Parameters.AddWithValue("@aseno", asetbox.Text);
                                        cmd.Parameters.AddWithValue("@kid", rd["id"].ToString());
                                        cmd.Parameters.AddWithValue("@item", rd["itemno"].ToString());
                                        cmd.Parameters.AddWithValue("@kno", rd["kno"].ToString());
                                        cmd.Parameters.AddWithValue("@loc", rd["location"].ToString());
                                        using (SqlDataReader read = cmd.ExecuteReader())
                                        {
                                            while (read.Read())
                                            {
                                                itemid = read[0].ToString();
                                            }
                                        }
                                    }
                                }


                                string selectparts = "select * from  quotationrequesttbl as b where b.iid = @kid";
                                using (SqlConnection selectpartssqlcon = new SqlConnection(cs))
                                {
                                    using (SqlCommand selectpartscmd = new SqlCommand(selectparts, selectpartssqlcon))
                                    {
                                        selectpartssqlcon.Open();
                                        selectpartscmd.Parameters.AddWithValue("@kid", rd["id"].ToString());
                                        using (SqlDataReader selectpartsread = selectpartscmd.ExecuteReader())
                                        {
                                            while (selectpartsread.Read())
                                            {
                                                string insertparts = " declare @partsid as integer = (select isnull(max(id),0)+1 from partstb) " +
                                                        " insert into partstb (id, iid, articleno, description, unitprice, qty) values (@partsid,@iid,@articleno,@description,@unitprice,@qty)";
                                                using (SqlConnection insertpartssqlcon = new SqlConnection(cs))
                                                {
                                                    using (SqlCommand insertpartscmd = new SqlCommand(insertparts, insertpartssqlcon))
                                                    {

                                                        insertpartssqlcon.Open();
                                                        insertpartscmd.Parameters.AddWithValue("@iid", itemid);
                                                        insertpartscmd.Parameters.AddWithValue("@articleno", selectpartsread["articleno"].ToString());
                                                        insertpartscmd.Parameters.AddWithValue("@description", selectpartsread["description"].ToString());
                                                        insertpartscmd.Parameters.AddWithValue("@unitprice", selectpartsread["unitprice"].ToString());
                                                        insertpartscmd.Parameters.AddWithValue("@qty", selectpartsread["qty"].ToString());
                                                        insertpartscmd.ExecuteNonQuery();
                                                    }

                                                }
                                            }

                                        }
                                    }
                                }
                            }

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
                if (IsValid)
                {
                    Response.Redirect("~/AFTERSALESPROJ/quotation.aspx");
                }
            
            }
        }

    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

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
                        lblproject.Text = Session["PROJECT"].ToString();
                        lbladdress.Text = Session["ADDRESS"].ToString();
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
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
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
                          "   format(Actualprice, 'n2') as [ACTUAL PRICE],LOCK" +
                          "   from quotationtb where sid = @sid";
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        DataSet ds = new DataSet();
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
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
        protected void newbtn_click(object sender, EventArgs e)
        {
            try
            {
                if (othertbox.Text == "")
                {
                    othertbox.Text = "0";
                }

             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                getdata();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

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
                        x = Convert.ToDateTime(x).ToString("yyyy-MM-dd");
                    }
                }


                ((TextBox)row.FindControl("editaccepteddatetbox")).Text = x;
                DateTime v;
                if (DateTime.TryParse(((Label)row.FindControl("datelbl")).Text, out v))
                {
                    ((Label)row.FindControl("datelbl")).Text = Convert.ToDateTime(((Label)row.FindControl("datelbl")).Text).ToString("yyyy-MM-dd");
                }
                ((TextBox)row.FindControl("editdatetbox")).Text = ((Label)row.FindControl("datelbl")).Text;

                ((LinkButton)row.FindControl("updatelink")).Visible = true;
                ((LinkButton)row.FindControl("cancellink")).Visible = true;
                ((TextBox)row.FindControl("editdatetbox")).Visible = true;
                ((TextBox)row.FindControl("editaccepteddatetbox")).Visible = true;
                ((TextBox)row.FindControl("editasenotbox")).Visible = true;
                ((ValidationSummary)row.FindControl("editvalsummary")).Visible = true;

                ((LinkButton)row.FindControl("editlink")).Visible = false;
                ((LinkButton)row.FindControl("deletelink")).Visible = false;
                ((Label)row.FindControl("datelbl")).Visible = false;
                ((Label)row.FindControl("acceptedlbl")).Visible = false;
                ((Label)row.FindControl("asenolbl")).Visible = false;

            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("updatelink")).Visible = false;
                ((LinkButton)row.FindControl("cancellink")).Visible = false;
                ((TextBox)row.FindControl("editdatetbox")).Visible = false;
                ((TextBox)row.FindControl("editaccepteddatetbox")).Visible = false;
                ((TextBox)row.FindControl("editasenotbox")).Visible = false;
                ((ValidationSummary)row.FindControl("editvalsummary")).Visible = false;

                ((LinkButton)row.FindControl("editlink")).Visible = true;
                ((LinkButton)row.FindControl("deletelink")).Visible = true;
                ((Label)row.FindControl("datelbl")).Visible = true;
                ((Label)row.FindControl("acceptedlbl")).Visible = true;
                ((Label)row.FindControl("otherlbl")).Visible = true;


            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatefunction(((Label)row.FindControl("idlbl")).Text,
                ((TextBox)row.FindControl("editaccepteddatetbox")).Text,
                ((TextBox)row.FindControl("editdatetbox")).Text,
                ((TextBox)row.FindControl("editasenotbox")).Text);
            }
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunction(((Label)row.FindControl("idlbl")).Text, ((Label)row.FindControl("asenolbl")).Text);
            }
            if (e.CommandName == "myitem")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["aseno"] = ((Label)row.FindControl("asenolbl")).Text;
                Response.Redirect("~/AFTERSALESPROJ/quotationitem.aspx");
            }
            if (e.CommandName == "report")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["aseno"] = ((Label)row.FindControl("asenolbl")).Text;
                Session["qu_report_sender"] = "qu_sender_qu";
                Response.Redirect("~/AFTERSALESPROJ/quotationreport.aspx");
            }
            if (e.CommandName == "pdffile")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["aseno"] = ((Label)row.FindControl("asenolbl")).Text;
                Response.Redirect("~/AFTERSALESPROJ/pdfuploads.aspx");
            }
            if (e.CommandName == "myrevise")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                revisefunction(((Label)row.FindControl("idlbl")).Text, ((Label)row.FindControl("asenolbl")).Text);
            }

        }
        private void revisefunction(string id, string aseno)
        {
            try
            {
                string str = "declare @id as integer = (select isnull(max(id),0)+1 from quotationtb) " +
                                "insert into quotationtb  					  " +
                                "      ([ID]									  " +
                                "      ,[CIN]								  " +
                                "      ,[ASENO]								  " +
                                "      ,[QDATE]								  " +
                                "      ,[PARTICULAR]							  " +
                                "      ,[OTHERCHARGES]						  " +
                                "      ,[ACCEPTED]							  " +
                                "      ,[UNITPRICE]							  " +
                                "      ,[NETPRICE]							  " +
                                "      ,[ACTUALPRICE]						  " +
                                "      ,[SID]								  " +
                                "      ,[MOBILIZATION]						  " +
                                "      ,[FOC])								  " +
                                "	  select								  " +
                                "	  @id									  " +
                                "      ,[CIN]								  " +
                                "      ,[ASENO]+'(rev)'								  " +
                                "      ,[QDATE]								  " +
                                "      ,[PARTICULAR]							  " +
                                "      ,[OTHERCHARGES]						  " +
                                "      ,[ACCEPTED]							  " +
                                "      ,[UNITPRICE]							  " +
                                "      ,[NETPRICE]							  " +
                                "      ,[ACTUALPRICE]						  " +
                                "      ,[SID]								  " +
                                "      ,[MOBILIZATION]						  " +
                                "      ,[FOC]								  " +
                                "  FROM [QUOTATIONTB] where id = @myid 		  " +
                                " UPDATE QUOTATIONTB SET LOCK = '1' WHERE ID = @myid";
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@myid", id);
                        sqlcmd.ExecuteNonQuery();
                    }


                }


            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                reviseitems(aseno);
            }
        }
        private void reviseitems(string aseno)
        {
            try
            {
             
                using (SqlConnection sqlcon1 = new SqlConnection(sqlconstr))
                {
                    sqlcon1.Open();
                    string finditem = "select * from itemtb where aseno = @aseno";

                    using (SqlCommand sqlcmd = new SqlCommand(finditem, sqlcon1))
                    {
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {


                            while (rd.Read())
                            {
                                string itemid = "";
                                string insertitem = " declare @itemid as integer = (select isnull(max(id),0)+1 from itemtb)" +
                                                    "  insert into itemtb(id, aseno, ITEM, kno, wdwloc,unitprice,qty,netprice,kid)" +
                                                    "  values(@itemid, @aseno+'(rev)', @item, @kno, @loc,@unitprice,@qty,@netprice,@kid)"+
                                                    " select @itemid";
                                //                                "  declare @partsid as integer = (select isnull(max(id),0)+1 from partstb) " +
                                //"  insert into partstb(id, iid, articleno, description, markup, unitprice, qty, netamount) select @partsid,@itemid,articleno, description, markup, unitprice, qty, netamount from partstb where iid = @iid ";
                                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                                {
                                    using (SqlCommand cmd = new SqlCommand(insertitem, sqlcon))
                                    {
                                        sqlcon.Open();
                                        cmd.Parameters.AddWithValue("@iid", rd["id"].ToString());
                                        cmd.Parameters.AddWithValue("@aseno", aseno);
                                        cmd.Parameters.AddWithValue("@item", rd["item"].ToString());
                                        cmd.Parameters.AddWithValue("@kno", rd["kno"].ToString());
                                        cmd.Parameters.AddWithValue("@loc", rd["wdwloc"].ToString());
                                        cmd.Parameters.AddWithValue("@unitprice", Convert.ToDouble(rd["unitprice"].ToString()));
                                        cmd.Parameters.AddWithValue("@qty", Convert.ToDouble(rd["qty"].ToString()));
                                        cmd.Parameters.AddWithValue("@netprice", Convert.ToDouble(rd["netprice"].ToString()));
                                        cmd.Parameters.AddWithValue("@kid", rd["kid"].ToString());
                                        using (SqlDataReader read = cmd.ExecuteReader())
                                        {
                                            while (read.Read())
                                            {
                                                itemid = read[0].ToString();
                                            }
                                        }
                                    }
                                }

                                string selectparts = "select * from  partstb where iid = @kid";
                                using (SqlConnection selectpartssqlcon = new SqlConnection(sqlconstr))
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
                                                        " insert into partstb (id, iid, articleno, description, markup, unitprice, qty, netamount)  values (@partsid,@iid,@articleno,@description,@markup,@unitprice,@qty,@netamount)";
                                                using (SqlConnection insertpartssqlcon = new SqlConnection(sqlconstr))
                                                {
                                                    using (SqlCommand insertpartscmd = new SqlCommand(insertparts, insertpartssqlcon))
                                                    {

                                                        insertpartssqlcon.Open();
                                                        insertpartscmd.Parameters.AddWithValue("@iid", itemid);
                                                        insertpartscmd.Parameters.AddWithValue("@articleno", selectpartsread["articleno"].ToString());
                                                        insertpartscmd.Parameters.AddWithValue("@description", selectpartsread["description"].ToString());
                                                        insertpartscmd.Parameters.AddWithValue("@unitprice", selectpartsread["unitprice"].ToString());
                                                        insertpartscmd.Parameters.AddWithValue("@netamount", selectpartsread["netamount"].ToString());
                                                        insertpartscmd.Parameters.AddWithValue("@markup", selectpartsread["markup"].ToString());
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
                Response.Write(ex.ToString());
            }
            finally
            {
                getdata();
            }
        }

        private void updatefunction(string id, string accepted, string qdate, string aseno)
        {
            try
            {
                string find = "select * from quotationtb where not id = @id and aseno = @aseno";
                string str = " update quotationtb set accepted=@accepted, aseno=@aseno, qdate =@qdate where id = @id";
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    bool x;

                    using (SqlCommand cmd = new SqlCommand(find, sqlcon))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.Parameters.AddWithValue("@aseno", aseno);
                        using (SqlDataReader rd = cmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                x = true;
                            }
                            else
                            {
                                x = false;
                            }
                        }
                    }

                    if (x == true)
                    {
                        CustomValidator err = new CustomValidator();
                        err.ValidationGroup = "editval";
                        err.IsValid = false;
                        err.ErrorMessage = "duplicate ASE NO!";
                        Page.Validators.Add(err);
                    }
                    else
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcmd.Parameters.AddWithValue("@id", id);
                            sqlcmd.Parameters.AddWithValue("@accepted", accepted);
                            sqlcmd.Parameters.AddWithValue("@qdate", qdate);
                            sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                            sqlcmd.ExecuteNonQuery();
                            getdata();
                        }
                    }



                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }

        private void deletefunction(string id, string aseno)
        {
            try
            {

                string str = " delete from quotationtb where id = @id" +
                    " delete from partstb where iid in (select id from itemtb where aseno = @aseno) " +
                    " delete from itemtb where aseno = @aseno" +
                    " update quotationtb set lock=0 where aseno = replace(@aseno,'(rev)','')";
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            if (Session["quotationsender"].ToString() == "report")
            {
                Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
            }
            else if (Session["quotationsender"].ToString() == "joborder")
            {
                Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AFTERSALESPROJ/requestedquotation.aspx");
        }
    }
}
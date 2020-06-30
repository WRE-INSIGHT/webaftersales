using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class CallinPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                    
                        getprovinces();

                        if (Session["callinserachkey"] != null)
                        {
                            callinkey.Text = Session["callinserachkey"].ToString();
                            provinceddl.Text= Session["provincekey"].ToString();
                        }
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
        private void getprovinces()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon1"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("select distinct province from addendum_to_contract_tb order by province asc", sqlcon))
                    {
                        sqlcon.Open();
                        provinceddl.DataSource = sqlcmd.ExecuteReader();
                        provinceddl.DataTextField = "PROVINCE";
                        provinceddl.DataBind();
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void getdata()
        {
            try
            {
               
                    DataSet ds = new DataSet();
                    ds.Clear();
                    string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                    using (SqlConnection sqlcon = new SqlConnection(cs))
                    {
                        using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                        {
                            sqlcon.Open();
                            sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                            sqlcmd.CommandText = "stdCallin";
                            sqlcmd.Parameters.AddWithValue("@key", callinkey.Text);
                            sqlcmd.Parameters.AddWithValue("@province", provinceddl.Text);
                            SqlDataAdapter da = new SqlDataAdapter();
                            da.SelectCommand = sqlcmd;
                            da.Fill(ds, "tb");

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
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["callinserachkey"] = callinkey.Text;
            Session["provincekey"] = provinceddl.Text;
            Cache.Remove("callintb");
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Session["callinserachkey"] = callinkey.Text;
            Session["provincekey"] = provinceddl.Text;
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["managecallinsender"] = "New";
            Response.Redirect("~/AFTERSALESPROJ/newcallin.aspx");
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                Session["callinTelno"] = ((Label)row.FindControl("telnolbl")).Text;
                Session["callinEmail"] = ((Label)row.FindControl("emaillbl")).Text;
                Session["callinViber"] = ((Label)row.FindControl("viberlbl")).Text;
                Session["callinWhatsapp"] = ((Label)row.FindControl("whatsapplbl")).Text;
                Session["callinFaxno"] = ((Label)row.FindControl("faxnolbl")).Text;
                Session["callinDate"] = ((Label)row.FindControl("datelbl")).Text;
                Session["callinCaller"] = ((Label)row.FindControl("callerlbl")).Text;
                Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                Session["callinJo"] = ((Label)row.FindControl("jolbl")).Text;
                Session["callinContactperson"] = ((Label)row.FindControl("contactpersonlbl")).Text;
                Session["callinConcern"] = ((Label)row.FindControl("concernlbl")).Text;
                Session["callinConversation"] = ((Label)row.FindControl("conversationlbl")).Text;
                Session["managecallinsender"] = "Edit";
                Response.Redirect("~/AFTERSALESPROJ/newcallin.aspx");
            }
            else if (e.CommandName == "myphotos")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                Response.Redirect("~/AFTERSALESPROJ/callinphotos.aspx");
            }
            else if (e.CommandName == "myservicing")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["servicingsource"] = "callin";
                if (((Label)row.FindControl("turnoverlbl")).Text == "Yes")
                {

                    Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                    Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                    Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                    Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
                }
                else
                {
                    if (Convert.ToDecimal(((Label)row.FindControl("paymentperlbl")).Text) >= 100)
                    {
                        Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                        Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                        Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                        Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
                    }
                    else
                    {
                        if (((Label)row.FindControl("lblrstatus")).Text == "Approved")
                        {
                            Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                            Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                            Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                            Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "alert('Sorry unable to open JO, account is not fully paid')", true);
                        }

                    }
                }

            }
            else if (e.CommandName == "requestcollection")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                insertrequest(((Label)row.FindControl("callinlbl")).Text);
            }
        }
        private void insertrequest(string cin)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string find = " select * from RequestCollectionApproval where cin = @cin";
                string str = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from RequestCollectionApproval)" +
                                " insert into RequestCollectionApproval     "+
                                " (ID                                         "+
                                " , CIN                                      "+
                                " , REQUESTED                                "+
                                " , APPROVED                                 "+
                                " , DISAPPROVED                              "+
                                " ,[MESSAGE])                                "+
                                " values                                     "+
                                "  (@id                                      "+
                                " , @cin                                     "+
                                " , getdate()                               "+
                                " , ''                                "+
                                " , ''                             "+
                                " , '')                           ";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    bool bol = false;
                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@cin", cin);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                bol = true;
                            }
                            else
                            {
                                bol = false;
                            }
                        }
                    }
                    if (bol==false)
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcmd.Parameters.AddWithValue("@cin", cin);
                            
                            sqlcmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "alert('Sorry unable to process your request, you already requested a collection review for this callin ')", true);
                    }

                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                getdata();
            }
        }
    }
}
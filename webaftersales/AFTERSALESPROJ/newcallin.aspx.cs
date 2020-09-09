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
    public partial class newcallin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["managecallinsender"].ToString() == "Edit")
                        {
                            Button1.Text = "save";
                            cin.Text = Session["callinnumber"].ToString();
                            contactpersontbox.Text= Session["callinContactperson"].ToString();
                            telno.Text = Session["callinTelno"].ToString();
                            emailtbox.Text = Session["callinEmail"].ToString();
                            vibertbox.Text = Session["callinViber"].ToString();
                            whatsapptbox.Text = Session["callinWhatsapp"].ToString();
                            faxno.Text = Session["callinFaxno"].ToString();
                            DateTime value;
                            if (DateTime.TryParse(Session["callinDate"].ToString(), out value))
                            {
                                Session["callinDate"] = Convert.ToDateTime(Session["callinDate"].ToString()).ToString("yyyy-MM-dd");
                            }

                            calldate.Text = Session["callinDate"].ToString();
                            callername.Text = Session["callinCaller"].ToString();
                            projectname.Text = Session["callinProject"].ToString();
                            address.Text = Session["callinAddress"].ToString();
                            jo.Text = Session["callinJo"].ToString();
                            for (int i = 0; i <= CheckBoxList1.Items.Count - 1; i++)
                            {
                                if (Session["callinConcern"].ToString().Contains(CheckBoxList1.Items[i].Value.ToString()))
                                {
                                    CheckBoxList1.Items[i].Selected = true;
                                }
                            }
                            conversation.Text = Session["callinConversation"].ToString();
                        }
                        else if (Session["managecallinsender"].ToString() == "New")
                        {
                            cin.Enabled = false;
                            Button1.Text = "add";
                        }
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
        protected void Button1_Click(object sender, EventArgs e)
        {
            cleantext(calldate);
            cleantext(callername);
            cleantext(telno);
            cleantext(faxno);
            cleantext(conversation);
            string concern = "";
            foreach (ListItem li in CheckBoxList1.Items)
            {
                if (li.Selected)
                {
                    concern += " *" + li.Value.ToString();
                }
            }

            if (Button1.Text == "save")
            {
                updatefunction(concern);
            }
            else if (Button1.Text == "add")
            {
                addfunction(concern);
            }
        }
        private void cleantext(object sender)
        {
            ((TextBox)sender).Text.Replace("'", "`");
            ((TextBox)sender).Text.Replace(@"""", "``");
        }
        private void addfunction(string concern)
        {
            if (jo.Text == "")
            {
                errorrmessage("please select a project");
                return;
            }
       
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                try
                {
                    string str = "Declare @autonum as integer = (select isnull(max(autonum), 0) + 1 from callintb)" +
                               " insert into callintb" +
                               " (autonum, " +
                               " cdate, " +
                               " cin, " +
                               " caller, " +
                               " jo, " +
                               " contactperson, " +
                               " TELNO, " +
                               " email, " +
                               " viber, " +
                               " whatsapp, " +
                               " FAXNO, " +
                               " concern, " +
                               " conversation)" +
                               " values" +
                               " (@autonum, " +
                               " @cdate, " +
                               " ((left(CONVERT([varchar](7), @autonum), (2)) + '-')+right(CONVERT([varchar](7), @autonum),(5))),  " +
                               " @caller," +
                               " @jo," +
                               " @contactperson," +
                               " @TELNO," +
                               " @email," +
                               " @viber," +
                               " @whatsapp," +
                               " @FAXNO," +
                               " @concern," +
                               " @conversation)";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@jo", jo.Text);
                        sqlcmd.Parameters.AddWithValue("@contactperson", contactpersontbox.Text);
                        sqlcmd.Parameters.AddWithValue("@cdate", calldate.Text);
                        sqlcmd.Parameters.AddWithValue("@caller", callername.Text);
                        sqlcmd.Parameters.AddWithValue("@TELNO", telno.Text);
                        sqlcmd.Parameters.AddWithValue("@email", emailtbox.Text);
                        sqlcmd.Parameters.AddWithValue("@viber", vibertbox.Text);
                        sqlcmd.Parameters.AddWithValue("@whatsapp", whatsapptbox.Text);
                        sqlcmd.Parameters.AddWithValue("@FAXNO", faxno.Text);
                        sqlcmd.Parameters.AddWithValue("@concern", concern);
                        sqlcmd.Parameters.AddWithValue("@conversation", conversation.Text);
                        sqlcmd.ExecuteNonQuery();
                        CustomValidator err = new CustomValidator();
                        err.ValidationGroup = "val1";
                        err.IsValid = false;
                        err.ErrorMessage = "Data saved successfully!";
                        Page.Validators.Add(err);
                        ValidationSummary1.CssClass = "alert alert-success";
                    }
                }
                catch (Exception ex)
                {
                    errorrmessage(ex.Message.ToString());
                }
            }
        }
        private void updatefunction(string concern)
        {
            if (jo.Text == "")
            {
                errorrmessage("please select a project");
                return;
            }
       
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                try
                {
                    sqlcon.Open();
                    bool bol;
                    string anum = cin.Text.Replace("-", "");
                    string find = "select * from callintb where cin=@newcin and not cin=@cin";
                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("cin", Session["callinnumber"]);
                        sqlcmd.Parameters.AddWithValue("newcin", cin.Text);
                        using (SqlDataReader rrd = sqlcmd.ExecuteReader())
                        {
                            if (rrd.HasRows)
                            {
                                bol = true;
                            }
                            else
                            {
                                bol = false;
                            }
                        }
                    }
                    if (bol == true)
                    {
                        errorrmessage("Duplicate call-in number");
                        return;
                    }

                    string str = " update callintb set" +
                         " cdate = @cdate," +
                         " caller = @caller," +
                         " jo = @jo," +
                         " contactperson = @contactperson," +
                         " TELNO = @TELNO," +
                         " email = @email," +
                         " viber = @viber," +
                         " whatsapp = @whatsapp," +
                         " FAXNO = @FAXNO," +
                         " concern = @concern," +
                         " conversation = @conversation" +
                         " where cin = @cin" +
                         " update callintb set cin = @newcin, autonum = @anum where cin = @cin" +
                         " update quotationtb set cin = @newcin where cin = @cin" +
                         " update servicingtb set cin = @newcin where cin = @cin";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@cdate", calldate.Text);
                        sqlcmd.Parameters.AddWithValue("@caller", callername.Text);
                        sqlcmd.Parameters.AddWithValue("@jo", jo.Text);
                        sqlcmd.Parameters.AddWithValue("@contactperson", contactpersontbox.Text);
                        sqlcmd.Parameters.AddWithValue("@cin", Session["callinnumber"].ToString());
                        sqlcmd.Parameters.AddWithValue("@newcin", cin.Text);
                        sqlcmd.Parameters.AddWithValue("@anum", anum);
                        sqlcmd.Parameters.AddWithValue("@TELNO", telno.Text);
                        sqlcmd.Parameters.AddWithValue("@email", emailtbox.Text);
                        sqlcmd.Parameters.AddWithValue("@viber", vibertbox.Text);
                        sqlcmd.Parameters.AddWithValue("@whatsapp", whatsapptbox.Text);
                        sqlcmd.Parameters.AddWithValue("@FAXNO", faxno.Text);
                        sqlcmd.Parameters.AddWithValue("@concern", concern);
                        sqlcmd.Parameters.AddWithValue("@conversation", conversation.Text);
                        sqlcmd.ExecuteNonQuery();
                        CustomValidator err = new CustomValidator();
                        err.ValidationGroup = "val1";
                        err.IsValid = false;
                        err.ErrorMessage = "Data saved successfully!";
                        Page.Validators.Add(err);
                        ValidationSummary1.CssClass = "alert alert-success";
                    }
                }
                catch (Exception ex)
                {
                    errorrmessage(ex.Message.ToString());
                }
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
        protected void LinkButton2click(object sender, EventArgs e)
        {
            getdata();
        }
        private string sqlconstr1
        {
            get
            {
                return ConnectionString.sqlconstr1();
            }
        }
        private void getdata()
        {
            try
            {
                GridView1.SelectedIndex = -1;
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
                {
                    string field = "(PROJECT_LABEL like @pl OR" +
                " CLIENTS_NAME like @pl OR" +
                " JOB_ORDER_NO like @pl OR" +
                " SUB_JO like @pl OR" +
                " JOB_ORDER_NO_DATE like @pl OR" +
                " COMPANY_NAME like @pl OR" +
                " FULLADD like @pl OR" +
                " ACCT_EXEC_INCHARGE like @pl)";
                    string str = "select JOB_ORDER_NO AS JO, project_label as [PROJECT],FULLADD AS ADDRESS from addendum_to_contract_tb" +
                                  " where " + field + " and contract_type = 'original contract'";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@pl", "%" + keytbox.Text + "%");
                        DataSet ds = new DataSet();
                        ds.Clear();
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
        protected void faxno_TextChanged(object sender, EventArgs e)
        {

        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myselect")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = rowindex;
                projectname.Text = ((Button)row.FindControl("bindProject")).Text;
                address.Text = ((Label)row.FindControl("bindAddress")).Text;
                jo.Text = ((Label)row.FindControl("bindJo")).Text;
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            projectname.Text = "";
            address.Text = "";
            jo.Text = "";
        }
    }
}
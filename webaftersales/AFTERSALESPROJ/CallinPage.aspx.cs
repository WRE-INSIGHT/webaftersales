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
                        if (Session["callinserachkey"] != null)
                        {
                            callinkey.Text = Session["callinserachkey"].ToString();
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
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
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
            else if (e.CommandName == "myservicing")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
            }
        }
    }
}
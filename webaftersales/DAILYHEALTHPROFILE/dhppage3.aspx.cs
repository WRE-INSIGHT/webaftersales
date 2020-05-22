using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.DAILYHEALTHPROFILE
{
    public partial class dhppage3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["dhp_EMPNO"] != null)
            {

                if (!IsPostBack)
                {
                    lbldate.Text = Session["dhpdate"].ToString();
                    lblname.Text = Session["dhpname"].ToString();
                    lblempno.Text = Session["dhpempno"].ToString();
                    lblage.Text = Session["dhpage"].ToString();
                    lblbirthday.Text = Session["dhpbirthday"].ToString();
                    getdatatb1();
                }

            }
            else
            {
                Response.Redirect("~/DAILYHEALTHPROFILE/dhplogin.aspx");
            }
        }
        private string empno
        {
            get
            {
                return Session["dhp_EMPNO"].ToString();
            }
        }
        private string dhpid
        {
            get
            {
                return Session["dhp_id"].ToString();
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
        private void inserttbl1()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "declare @ID as integer = (select isnull(max(isnull(id,0)),0)+1 from dhpisolationmonitoring)  " +
                                "insert into dhpisolationmonitoring  " +
                                "(ID,								 " +
                                "EMPNO,								 " +
                                "DHPID,								 " +
                                "TIMERECORD,						 " +
                                "BODYTEMP,							 " +
                                "OXYGENSATURATION,					 " +
                                "CHILLS,							 " +
                                "STOMACHACHE,						 " +
                                "VOMITINGEPISODE,					 " +
                                "BOWELMOVEMENT)						 " +
                                "values								 " +
                                "(@ID,								 " +
                                "@EMPNO,							 " +
                                "@DHPID,							 " +
                                "@TIMERECORD,						 " +
                                "@BODYTEMP,							 " +
                                "@OXYGENSATURATION,					 " +
                                "@CHILLS,							 " +
                                "@STOMACHACHE,						 " +
                                "@VOMITINGEPISODE,					 " +
                                "@BOWELMOVEMENT)					 ";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        string temp = tboxbodytemp.Text;
                        if (temp == "")
                        {
                            temp = "0";
                        }
                     

                        sqlcmd.Parameters.AddWithValue("@EMPNO", empno);
                        sqlcmd.Parameters.AddWithValue("@DHPID", dhpid);
                        sqlcmd.Parameters.AddWithValue("@TIMERECORD", tboxtimerecord.Text);
                        sqlcmd.Parameters.AddWithValue("@BODYTEMP", temp);
                        sqlcmd.Parameters.AddWithValue("@OXYGENSATURATION", tboxoxygensaturation.Text);
                        sqlcmd.Parameters.AddWithValue("@CHILLS", dlchills.Text);
                        sqlcmd.Parameters.AddWithValue("@STOMACHACHE", dlstomachache.Text);
                        sqlcmd.Parameters.AddWithValue("@VOMITINGEPISODE", tboxvomiting.Text);
                        sqlcmd.Parameters.AddWithValue("@BOWELMOVEMENT", tboxbowelmovement.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "addval";
                err.IsValid = false;
                err.ErrorMessage = ex.Message.ToString();
                Page.Validators.Add(err);
            }
            finally
            {
                getdatatb1();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            inserttbl1();
        }
        private void getdatatb1()
        {
            try
            {
                DataTable tb = new DataTable();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "select * from dhpisolationmonitoring where empno=@EMPNO AND DHPID=@DHPID";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@EMPNO", empno);
                        sqlcmd.Parameters.AddWithValue("@DHPID", dhpid);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                editmode(row, false, true);

            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                editmode(row, true, false);
            }
            else if (e.CommandName == "myupdate")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                if (IsValid)
                {
                    updatefunctio(((Label)row.FindControl("lblid")).Text,
             ((TextBox)row.FindControl("tboxedittimerecord")).Text,
             ((TextBox)row.FindControl("tboxeditbodytemp")).Text,
             ((TextBox)row.FindControl("tboxeditoxygensaturation")).Text,
             ((DropDownList)row.FindControl("dleditchills")).Text,
             ((DropDownList)row.FindControl("dleditstomachache")).Text,
             ((TextBox)row.FindControl("tboxeditvomiting")).Text,
             ((TextBox)row.FindControl("tboxeditbowelmovement")).Text);
                }

            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunctio(((Label)row.FindControl("lblid")).Text);
            }
            else if (e.CommandName == "myinsert")
            {
                //insertfunction(GridView1);
                GridView1.Visible = false;
            }
       
        }
      
        private void insertfunction(GridView gv)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "declare @ID as integer = (select isnull(max(isnull(id,0)),0)+1 from dhpisolationmonitoring)  " +
                                "insert into dhpisolationmonitoring  " +
                                "(ID,								 " +
                                "EMPNO,								 " +
                                "DHPID,								 " +
                                "TIMERECORD,						 " +
                                "BODYTEMP,							 " +
                                "OXYGENSATURATION,					 " +
                                "CHILLS,							 " +
                                "STOMACHACHE,						 " +
                                "VOMITINGEPISODE,					 " +
                                "BOWELMOVEMENT)						 " +
                                "values								 " +
                                "(@ID,								 " +
                                "@EMPNO,							 " +
                                "@DHPID,							 " +
                                "@TIMERECORD,						 " +
                                "@BODYTEMP,							 " +
                                "@OXYGENSATURATION,					 " +
                                "@CHILLS,							 " +
                                "@STOMACHACHE,						 " +
                                "@VOMITINGEPISODE,					 " +
                                "@BOWELMOVEMENT)					 ";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                    
                        sqlcmd.Parameters.AddWithValue("@EMPNO", empno);
                        sqlcmd.Parameters.AddWithValue("@DHPID", dhpid);
                        sqlcmd.Parameters.AddWithValue("@TIMERECORD", ((TextBox)gv.FooterRow.FindControl("tboxinserttimerecord")).Text);
                        sqlcmd.Parameters.AddWithValue("@BODYTEMP", ((TextBox)gv.FooterRow.FindControl("tboxinsertbodytemp")).Text);
                        sqlcmd.Parameters.AddWithValue("@OXYGENSATURATION", ((TextBox)gv.FooterRow.FindControl("tboxinsertoxygensaturation")).Text);
                        sqlcmd.Parameters.AddWithValue("@CHILLS", ((DropDownList)gv.FooterRow.FindControl("dlinsertchills")).Text);
                        sqlcmd.Parameters.AddWithValue("@STOMACHACHE", ((DropDownList)gv.FooterRow.FindControl("dlinsertstomachache")).Text);
                        sqlcmd.Parameters.AddWithValue("@VOMITINGEPISODE", ((TextBox)gv.FooterRow.FindControl("tboxinsertvomiting")).Text);
                        sqlcmd.Parameters.AddWithValue("@BOWELMOVEMENT", ((TextBox)gv.FooterRow.FindControl("tboxinsertbowelmovement")).Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "addval";
                err.IsValid = false;
                err.ErrorMessage = ex.Message.ToString();
                Page.Validators.Add(err);
            }
            finally
            {
                getdatatb1();
            }
        }

        private void deletefunctio(string id)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "delete from dhpisolationmonitoring " +
                                "where id=@ID";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
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
                getdatatb1();
            }
        }

        private void updatefunctio(string id, string timerecord, string bodytemp, string oxygensaturation, string chills, string stomachache, string vomiting, string bowelmovement)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "update dhpisolationmonitoring set " +
                                "TIMERECORD=@TIMERECORD,						 " +
                                "BODYTEMP=@BODYTEMP,							 " +
                                "OXYGENSATURATION=@OXYGENSATURATION,					 " +
                                "CHILLS=@CHILLS,							 " +
                                "STOMACHACHE=@STOMACHACHE,						 " +
                                "VOMITINGEPISODE=@VOMITINGEPISODE,					 " +
                                "BOWELMOVEMENT=@BOWELMOVEMENT						 " +
                                "where id=@ID";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@TIMERECORD", timerecord);
                        sqlcmd.Parameters.AddWithValue("@BODYTEMP", bodytemp);
                        sqlcmd.Parameters.AddWithValue("@OXYGENSATURATION", oxygensaturation);
                        sqlcmd.Parameters.AddWithValue("@CHILLS", chills);
                        sqlcmd.Parameters.AddWithValue("@STOMACHACHE", stomachache);
                        sqlcmd.Parameters.AddWithValue("@VOMITINGEPISODE", vomiting);
                        sqlcmd.Parameters.AddWithValue("@BOWELMOVEMENT", bowelmovement);
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
                getdatatb1();
            }
        }

        private void editmode(GridViewRow row, bool t, bool f)
        {
            ((LinkButton)row.FindControl("btnedit")).Visible = t;
            ((LinkButton)row.FindControl("btndelete")).Visible = t;
            ((Label)row.FindControl("lbltimerecord")).Visible = t;
            ((Label)row.FindControl("lblbodytemp")).Visible = t;
            ((Label)row.FindControl("lbloxygensaturation")).Visible = t;
            ((Label)row.FindControl("lblchills")).Visible = t;
            ((Label)row.FindControl("lblstomachache")).Visible = t;
            ((Label)row.FindControl("lblvomiting")).Visible = t;
            ((Label)row.FindControl("lblbowelmovement")).Visible = t;

            ((RegularExpressionValidator)row.FindControl("RegularExpressionValidator33")).Visible = f;
            ((LinkButton)row.FindControl("btnupdate")).Visible = f;
            ((LinkButton)row.FindControl("btncancel")).Visible = f;
            ((TextBox)row.FindControl("tboxedittimerecord")).Visible = f;
            ((TextBox)row.FindControl("tboxeditbodytemp")).Visible = f;
            ((TextBox)row.FindControl("tboxeditoxygensaturation")).Visible = f;
            ((DropDownList)row.FindControl("dleditchills")).Visible = f;
            ((DropDownList)row.FindControl("dleditstomachache")).Visible = f;
            ((TextBox)row.FindControl("tboxeditvomiting")).Visible = f;
            ((TextBox)row.FindControl("tboxeditbowelmovement")).Visible = f;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            btnaddnewrecord.Visible = true;
        }

        protected void btnaddnewrecord_Click(object sender, EventArgs e)
        {
            btnaddnewrecord.Visible = false;
            Panel1.Visible = true;
        }
    }
}
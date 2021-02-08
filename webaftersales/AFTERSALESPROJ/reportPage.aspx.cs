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
    public partial class reportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    lblproject.Text = Session["PROJECT"].ToString();
                    lbladdress.Text = Session["ADDRESS"].ToString();
                    lbljo.Text = Session["JO"].ToString();
                    lblcolor.Text = Session["COLOR"].ToString();
                    lbldate.Text = "  " + Session["DATE"].ToString();
                    getdata();
                    getteam();
                    getstatus();
                
                }

            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void getstatus()
        {
            try
            {
                string str = "select [status],REMARKS,CIN from servicingtb where id = @sid";
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                lblstatus.Text = rd[0].ToString();
                                lblremarks.Text = rd[1].ToString();
                                Session["CIN"] = rd[2].ToString();
                            }
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
            }
        }
        private string teamid
        {
            get
            {
                return Session["TEAMID"].ToString();
            }
        }
        private void getdata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
                string str = "select * from reporttb where sid = @sid";
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }
        private void getteam()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.Parameters.AddWithValue("@TID", teamid);
                    sqlcmd.Parameters.AddWithValue("@sid", sid);
                    sqlcmd.CommandText = "stpgetteam";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    string teamname = "", personnel = "", servicing = "";
                    while (rd.Read())
                    {
                        teamname = rd[0].ToString();
                        personnel += rd[1].ToString() + "<br />";
                        servicing = rd[2].ToString();
                    }
                    lblteamname.Text = teamname;
                    lblpersonnel.Text = personnel;
                    lblservicing.Text = servicing;
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
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

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Session["link"] = "s2";
            Response.Redirect("~/AFTERSALESPROJ/reportviewPage.aspx");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["link"] = "s2";
            Response.Redirect("~/AFTERSALESPROJ/sidgalleryPage.aspx");
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((TextBox)row.FindControl("tboxitemno")).Text = ((Label)row.FindControl("lblitemno")).Text;
                ((TextBox)row.FindControl("tboxkno")).Text = ((Label)row.FindControl("lblkno")).Text;
                ((TextBox)row.FindControl("tboxlocation")).Text = ((Label)row.FindControl("lbllocation")).Text;
                ((TextBox)row.FindControl("tboxwidth")).Text = ((Label)row.FindControl("lblwidth")).Text;
                ((TextBox)row.FindControl("tboxheight")).Text = ((Label)row.FindControl("lblheight")).Text;
                ((DropDownList)row.FindControl("dlistspecification")).Text = ((Label)row.FindControl("lblspecification")).Text;

                ((TextBox)row.FindControl("tboxitemno")).Visible = true;
                ((Label)row.FindControl("lblitemno")).Visible = false;
                ((TextBox)row.FindControl("tboxkno")).Visible = true;
                ((Label)row.FindControl("lblkno")).Visible = false;;
                ((TextBox)row.FindControl("tboxlocation")).Visible = true;
                ((Label)row.FindControl("lbllocation")).Visible = false;
                ((TextBox)row.FindControl("tboxwidth")).Visible = true;
                ((Label)row.FindControl("lblwidth")).Visible = false;
                ((TextBox)row.FindControl("tboxheight")).Visible = true;
                ((Label)row.FindControl("lblheight")).Visible = false;
                ((DropDownList)row.FindControl("dlistspecification")).Visible = true;
                ((Label)row.FindControl("lblspecification")).Visible = false;

                ((LinkButton)row.FindControl("btnsave")).Visible = true;
                ((LinkButton)row.FindControl("btncancel")).Visible = true;
                ((LinkButton)row.FindControl("btnedit")).Visible = false;
                ((LinkButton)row.FindControl("btndelete")).Visible = false;
            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((TextBox)row.FindControl("tboxitemno")).Visible = false;
                ((Label)row.FindControl("lblitemno")).Visible = true;
                ((TextBox)row.FindControl("tboxkno")).Visible = false;
                ((Label)row.FindControl("lblkno")).Visible = true; ;
                ((TextBox)row.FindControl("tboxlocation")).Visible = false;
                ((Label)row.FindControl("lbllocation")).Visible = true;
                ((TextBox)row.FindControl("tboxwidth")).Visible = false;
                ((Label)row.FindControl("lblwidth")).Visible = true;
                ((TextBox)row.FindControl("tboxheight")).Visible = false;
                ((Label)row.FindControl("lblheight")).Visible = true;
                ((DropDownList)row.FindControl("dlistspecification")).Visible = false;
                ((Label)row.FindControl("lblspecification")).Visible = true;

                ((LinkButton)row.FindControl("btnsave")).Visible = false;
                ((LinkButton)row.FindControl("btncancel")).Visible = false;
                ((LinkButton)row.FindControl("btnedit")).Visible = true;
                ((LinkButton)row.FindControl("btndelete")).Visible = true;
                GridView1.SelectedIndex = -1;
            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ViewState["id"] = ((Label)row.FindControl("lblid")).Text.ToString();
                ViewState["itemno"] = ((TextBox)row.FindControl("tboxitemno")).Text;
                ViewState["kno"] = ((TextBox)row.FindControl("tboxkno")).Text;
                ViewState["location"] = ((TextBox)row.FindControl("tboxlocation")).Text;
                ViewState["width"] = ((TextBox)row.FindControl("tboxwidth")).Text;
                ViewState["height"] = ((TextBox)row.FindControl("tboxheight")).Text;
                ViewState["specification"] = ((DropDownList)row.FindControl("dlistspecification")).Text;
           
                myupdate(ViewState["id"].ToString(),
                           ViewState["itemno"].ToString(),
                           ViewState["kno"].ToString(),
                           ViewState["location"].ToString(),
                           ViewState["specification"].ToString(),
                           ViewState["width"].ToString(),
                           ViewState["height"].ToString());
            }
            if (e.CommandName == "myassessment")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["reportID"] = ((Label)row.FindControl("lblid")).Text.ToString();
                Session["KNO"] = ((Label)row.FindControl("lblkno")).Text.ToString();
                Session["LOCATION"] = ((Label)row.FindControl("lbllocation")).Text.ToString();
                Session["JOBORDERNO"] = ((Label)row.FindControl("lbljo")).Text.ToString();
                Response.Redirect("~/AFTERSALESPROJ/assessmentmade.aspx");
            }
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunction(((Label)row.FindControl("lblid")).Text.ToString());
            }
            if (e.CommandName == "myquotation")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["reportID"] = ((Label)row.FindControl("lblid")).Text.ToString();
                Session["KNO"] = ((Label)row.FindControl("lblkno")).Text.ToString();
                Session["LOCATION"] = ((Label)row.FindControl("lbllocation")).Text.ToString();
                Response.Redirect("~/AFTERSALESPROJ/requestquotation.aspx");
            }
            if (e.CommandName == "myphotos")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["link"] = "s2";
                Session["reportID"] = ((Label)row.FindControl("lblid")).Text.ToString();
                //Session["KNO"] = ((Label)row.FindControl("lblkno")).Text.ToString();
                //Session["LOCATION"] = ((Label)row.FindControl("lbllocation")).Text.ToString();
                Response.Redirect("~/AFTERSALESPROJ/reportPhotos.aspx");
            }

        }
        private void myupdate(string id, string itemno, string kno, string location, string specification, string width,string height)
        {
            try
            {
                string str = "update reporttb set itemno = @itemno, kno = @kno, location=@location, specification=@specification,width=@width,height=@height where id = @id";
            
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@itemno", itemno);
                        sqlcmd.Parameters.AddWithValue("@kno", kno);
                        sqlcmd.Parameters.AddWithValue("@location", location);
                        sqlcmd.Parameters.AddWithValue("@width", width);
                        sqlcmd.Parameters.AddWithValue("@height", height);
                        sqlcmd.Parameters.AddWithValue("@specification", specification);
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
                string str = "delete from reporttb where id = @id";
            
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                errorrmessage(ex.ToString());
            }
            finally
            {
                getdata();
            }
        }
        protected void newbtn_click(object sender, EventArgs e)
        {
            try
            {
              
                string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from reporttb) insert into reporttb (sid,id,itemno,kno,location,specification,width,height)values(@sid,@id,@item,@kno,@location,@specification,@width,@height)";
            
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        sqlcmd.Parameters.AddWithValue("@item", newtboxitemno.Text);
                        sqlcmd.Parameters.AddWithValue("@kno", newtboxkno.Text);
                        sqlcmd.Parameters.AddWithValue("@location", newtboxlocation.Text);
                        sqlcmd.Parameters.AddWithValue("@specification", newdlistspecification.Text);
                        sqlcmd.Parameters.AddWithValue("@width", newtboxwidth.Text);
                        sqlcmd.Parameters.AddWithValue("@height", newtboxheight.Text);
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

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            reasontbox.Text = lblremarks.Text;
           
            Panel2.Visible = true;
        }

        protected void closebtn_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string str = " update servicingtb set [status] = @status,REMARKS=@REMARKS where id = @sid";
            
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        sqlcmd.Parameters.AddWithValue("@status", statusddl.Text);
                        sqlcmd.Parameters.AddWithValue("@REMARKS", reasontbox.Text);
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
                updatestatus();
                Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
            }
        }
        private void updatestatus()
        {
            try
            {
                string str = " SELECT * INTO #TBL FROM( " +
                            " SELECT TOP 1 [STATUS],id, x=SUBSTRING(servicing, PATINDEX('%[0-9]%', servicing), PATINDEX('%[0-9][^0-9]%', servicing + 't') - PATINDEX('%[0-9]%'," +
                            " servicing) +1)" +
                            " FROM SERVICINGTB where cin = @cin order by x DESC ) AS TBL" +
                            " update callintb set [status] = (SELECT  case when [status] is null then '' else [status] end FROM #TBL) where cin = @cin";
            
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@cin", Session["CIN"].ToString());
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            if (Convert.ToBoolean(Session["pendingSOURCE"]))
            {
                Response.Redirect("~/AFTERSALESPROJ/PENDINGPAGE.aspx");
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/HOMEPAGE.aspx");
            }
        }

     
    }
}
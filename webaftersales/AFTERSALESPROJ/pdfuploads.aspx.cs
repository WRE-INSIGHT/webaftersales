using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class pdfuploads : System.Web.UI.Page
    {
        string filepath = "~/KMDI_FILES/Aftersales/ASuploads/PDFfiles/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath + aseno + "/"));
                    if (!IsExists)
                    {
                        System.IO.Directory.CreateDirectory(Server.MapPath(filepath + aseno + "/"));
                    }
                    if (!IsPostBack)
                    {
                        loaddata();
                        if (Session["ErrorMessage"] != null)
                        {
                            errorlbl.Text = Session["ErrorMessage"].ToString();
                            Panel2.Visible = true;
                        }
                        else
                        {
                            Panel2.Visible = false;
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
        private string aseno
        {
            get
            {
                return Session["aseno"].ToString();
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
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
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (FileUpload1.HasFile)
            {

                foreach (HttpPostedFile thefile in FileUpload1.PostedFiles)
                {
                    string fileExtension = System.IO.Path.GetExtension(thefile.FileName).ToString().ToLower();

                    if (fileExtension == ".pdf")
                    {
                        double filesize = thefile.ContentLength;
                        if (filesize < 29360128)
                        {
                            thefile.SaveAs(Server.MapPath(filepath + aseno + "/" + thefile.FileName));
                            Session["ErrorMessage"] = null;
                            string path = filepath + aseno + "/";
                            insertnew(thefile.FileName.ToString(), path);

                        }
                        else
                        {
                            CustomValidator err = new CustomValidator();
                            Session["ErrorMessage"] = "You can only upload files of size lesser than 28 MB, but you are uploading a file of " + Math.Round((filesize / 1048576.00), 2) + " MB";
                        }
                    }
                    else
                    {
                        Session["ErrorMessage"] = "invalid file type";
                    }
                }
            }
            else
            {
                Session["ErrorMessage"] = "select pdf file first";
            }
            Response.Redirect("~/AFTERSALESPROJ/pdfuploads.aspx");

        }
        private void insertnew(string filename, string path)
        {
            try
            {
                bool has;
                
                string str = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from pdftable) " +
                    "insert into pdftable (id,aseno,filename,filepath) values(@id,@aseno,@filename,@filepath)";

                string find = "select * from pdftable where aseno  = @aseno and filename  = @filename";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        sqlcmd.Parameters.AddWithValue("@filename", filename);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                has = true;
                            }
                            else
                            {
                                has = false;
                            }
                        }
                    }
                }

                if (has == false)
                {
                    using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                            sqlcmd.Parameters.AddWithValue("@filename", filename);
                            sqlcmd.Parameters.AddWithValue("@filepath", path);
                            sqlcmd.ExecuteNonQuery();
                        }
                    }
                }
                else
                {
                  
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                loaddata();
            }
        }

        private void loaddata()
        {
            try
            {
                
                string str = "select * from pdftable where aseno = @aseno";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        DataTable tb = new DataTable();
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
            if (e.CommandName == "viewfile")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Response.Redirect(((Label)row.FindControl("lblfilepath")).Text + ((LinkButton)row.FindControl("lbtnfilename")).Text);
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                try
                {
                    
                    string str = "delete from pdftable where aseno = @aseno and filename = @filename";
                    using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                            sqlcmd.Parameters.AddWithValue("@filename", ((LinkButton)row.FindControl("lbtnfilename")).Text);
                            sqlcmd.ExecuteNonQuery();

                            string[] Files = Directory.GetFiles(Server.MapPath(((Label)row.FindControl("lblfilepath")).Text));
                            foreach (string file in Files)
                            {
                                FileInfo fileinfo = new FileInfo(file);
                                if (fileinfo.Name == ((LinkButton)row.FindControl("lbtnfilename")).Text)
                                {
                                    File.Delete(file);
                                }
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

                    loaddata();
                }

            }
        }
    }
}

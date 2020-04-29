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
    public partial class assessmentPage : System.Web.UI.Page
    {
        DataTable tb;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    getcl();
                    getdata();
                    lblkno.Text = kno;
                    lbllocation.Text = location;
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
            }
        }
        private string reportid
        {
            get
            {
                return Session["reportID"].ToString();
            }
        }
        private string location
        {
            get
            {
                return Session["LOCATION"].ToString();
            }
        }
        private string jo
        {
            get
            {
                return Session["JOBORDERNO"].ToString();
            }
        }
        private string kno
        {
            get
            {
                return Session["KNO"].ToString();
            }
        }
        private string fcl
        {
            get
            {
                if (ViewState["FCL"] == null)
                {
                    return "";
                }
                else
                {
                    return ViewState["FCL"].ToString();
                }
            }
        }
        private string scl
        {
            get
            {
                if (ViewState["SCL"] == null)
                {
                    return "";
                }
                else
                {
                    return ViewState["SCL"].ToString();
                }
            }
        }
        private void getcl()
        {
            string cs = ConfigurationManager.ConnectionStrings["sqlcon1"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                try
                {
                    sqlcon.Open();
                    string str = " declare @f as varchar(100) = (select isnull(clno,'') from kmdi_fabrication_tb where KMDI_NO='" + kno + "' AND JOB_ORDER_NO = '" + jo + "')"+
                                    " declare @s as varchar(100) = (select isnull(clno,'') from KMDI_SCREENFAB_TB where KMDI_NO='" + kno + "' AND JOB_ORDER_NO = '" + jo + "')"+
                                    " select @f,@s";

                    SqlCommand sqlcmd = new SqlCommand(str, sqlcon);
                    using (SqlDataReader rd = sqlcmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            ViewState["FCL"] = rd[0].ToString();
                            ViewState["SCL"] = rd[1].ToString();
                        }
                    }
                }
                catch (Exception e)
                {
                    errorrmessage(e.Message.ToString());
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
        private void getdata()
        {
            try
            {
                tb = new DataTable();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {

                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "stpmaterialsused";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@kno", kno);
                    sqlcmd.Parameters.AddWithValue("@fcl", fcl);
                    sqlcmd.Parameters.AddWithValue("@scl", scl);
                    sqlcmd.Parameters.AddWithValue("@jo", jo);
                    sqlcmd.Parameters.AddWithValue("@find", findtbox.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(tb);
                    GridView1.DataSource = tb;
                    GridView1.DataBind();
                    ViewState["tb"] = tb;
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

            List<int> idlist = new List<int>();
            if (ViewState["listid"] != null)
            {
                idlist = (List<int>)ViewState["listid"];
            }

            foreach (GridViewRow row in this.GridView1.Rows)
            {
                CheckBox cbx = (CheckBox)row.FindControl("cboxselect");

                var selectedkey = int.Parse(GridView1.DataKeys[row.RowIndex].Value.ToString());

                if (cbx.Checked)
                {
                    if (!idlist.Contains(selectedkey))
                    {
                        idlist.Add(selectedkey);
                    }
                }
                else
                {
                    if (idlist.Contains(selectedkey))
                    {
                        idlist.Remove(selectedkey);
                    }
                }
            }

            ViewState["listid"] = idlist;
            GridView1.PageIndex = e.NewPageIndex;
            getdata();

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            List<int> idlist = ViewState["listid"] as List<int>;
            if (e.Row.RowType == DataControlRowType.DataRow && idlist != null)
            {
                var autoid = int.Parse(GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
                if (idlist.Contains(autoid))
                {
                    CheckBox cbx = (CheckBox)e.Row.FindControl("cboxselect");
                    cbx.Checked = true;
                }
            }
        }

       

        protected void importbtn_Click(object sender, EventArgs e)
        {

            List<int> l = new List<int>();
            if ((List<int>)ViewState["listid"] == null)
            {
                l.Add(0);
            }
            else
            {
                l = ViewState["listid"] as List<int>;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                if (cbk.Checked == true)
                {
                    int x = int.Parse(((Label)row.FindControl("Label1")).Text.ToString());
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(((Label)row.FindControl("Label1")).Text.ToString());
                    if (l.Contains(x))
                    {
                        l.Remove(x);
                    }
                }
            }
            try
            {

                for (int i = 0; i <= mytb.Rows.Count - 1; i++)
                {

                    int id = Convert.ToInt32(mytb.Rows[i]["id"].ToString());
                    if (l.Contains(id))
                    {
                        string stockno, description;
                        stockno = mytb.Rows[i]["stockno"].ToString();
                        description = mytb.Rows[i]["description"].ToString();
                        insertdata(stockno, description, "");
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                    if (cbk.Checked == true)
                    {
                        int x = int.Parse(((Label)row.FindControl("Label1")).Text.ToString());
                        if (l.Contains(x))
                        {
                            l.Remove(x);
                            cbk.Checked = false;
                        }
                    }
                }
            }

            ViewState["listid"] = l;
        }
        private void insertdata(string stockno, string description, string assessment)
        {
            try
            {
                string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from TBLassessment) insert into [TBLassessment] (id,reportid,stockno,assessment,description)values(@id,@reportid,@stockno,@assessment,@description)";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@reportid", reportid);
                        sqlcmd.Parameters.AddWithValue("@stockno", stockno);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@assessment", assessment);
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
                Response.Redirect("~/AFTERSALESPROJ/assessmentmade.aspx");
            }
        }
        protected void findbtn_Click(object sender, EventArgs e)
        {
            getdata();
        }
    }

}
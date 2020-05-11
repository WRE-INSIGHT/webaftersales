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
    public partial class importparts : System.Web.UI.Page
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
        private string iid
        {
            get
            {
                return Session["IID"].ToString();
            }
        }
        private void getdata()
        {
            try
            {
                try
                {
                    string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                    DataSet ds = new DataSet();
                    using (SqlConnection sqlcon = new SqlConnection(cs))
                    {
                        string str = "select * from partstb where iid = @iid";
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.Parameters.AddWithValue("@iid", iid);
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
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void tboxunitprice_TextChanged(object sender, EventArgs e)
        {
            if (tboxunitprice.Text != "" && tboxqty.Text != "" && tboxmarkup.Text != "")
            {
                double netamount, v, w, x, y, z;
                w = double.Parse(tboxmarkup.Text);
                x = double.Parse(tboxqty.Text);
                y = double.Parse(tboxunitprice.Text);
            
                z = x * y;
                v = z * (w * 0.01);
                netamount = z + v;
                tboxnetprice.Text = Convert.ToString(netamount);
            }
            else
            {
                tboxnetprice.Text = "0";
            }
        }
        public bool IsNumeric(string value)
        {
            return value.All(char.IsNumber);
        }
    }
}
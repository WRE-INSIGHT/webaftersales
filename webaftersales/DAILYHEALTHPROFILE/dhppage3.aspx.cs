using System;
using System.Collections.Generic;
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
    }
}
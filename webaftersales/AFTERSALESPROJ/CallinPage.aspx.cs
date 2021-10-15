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
using webaftersales.AFTERSALESPROJ.dal;

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
                            provinceddl.Text = Session["provincekey"].ToString();
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
        private string sqlconstr1
        {
            get
            {
                return ConnectionString.sqlconstr1();
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }

        private void getprovinces()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
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
            catch (Exception ex)
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

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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

            Session["callinProject"] = "";
            Session["callinAddress"] = "";
            Session["callinJo"] = "";
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
                    Session["callinJo"] = ((Label)row.FindControl("jolbl")).Text;
                    Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
                }
                else
                {
                    if (Convert.ToDecimal(((Label)row.FindControl("paymentperlbl")).Text) >= 100)
                    {
                        Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                        Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                        Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                        Session["callinJo"] = ((Label)row.FindControl("jolbl")).Text;
                        Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
                    }
                    else
                    {
                        if (((Label)row.FindControl("lblrstatus")).Text == "Approved")
                        {
                            Session["callinnumber"] = ((Label)row.FindControl("callinlbl")).Text;
                            Session["callinProject"] = ((Label)row.FindControl("projectlbl")).Text;
                            Session["callinAddress"] = ((Label)row.FindControl("addresslbl")).Text;
                            Session["callinJo"] = ((Label)row.FindControl("jolbl")).Text;
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
            else if (e.CommandName == "saveaddressbtn")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updateaddress(((Label)row.FindControl("tboxParentjono")).Text,
                    ((TextBox)row.FindControl("tboxUnitno")).Text,
                    ((TextBox)row.FindControl("tboxEstablishment")).Text,
                    ((TextBox)row.FindControl("tboxNo")).Text,
                    ((TextBox)row.FindControl("tboxStreet")).Text,
                    ((TextBox)row.FindControl("tboxVillage")).Text,
                    ((TextBox)row.FindControl("tboxBrgy")).Text,
                    ((TextBox)row.FindControl("tboxTown")).Text,
                    ((TextBox)row.FindControl("tboxProvince")).Text,
                    ((TextBox)row.FindControl("tboxArea")).Text);
            }
            else if (e.CommandName == "editaddressbtn")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("UPDATEADDRESSPANEL")).Visible = true;
            }
            else if (e.CommandName == "canceladdressbtn")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("UPDATEADDRESSPANEL")).Visible = false;
            }
            else if (e.CommandName == "editColor")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("pnlColor")).Visible = true;

                loadColor(((DropDownList)row.FindControl("ddlColor")));
            }
            else if (e.CommandName == "cancelEditingColor")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("pnlColor")).Visible = false;
            }
            else if (e.CommandName == "selectColor")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((TextBox)row.FindControl("tboxColor")).Text = ((TextBox)row.FindControl("tboxColor")).Text == "" ? ((DropDownList)row.FindControl("ddlColor")).Text : ((TextBox)row.FindControl("tboxColor")).Text + ", " + ((DropDownList)row.FindControl("ddlColor")).Text;
            }
            else if (e.CommandName == "saveColor")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updateColor(((Label)row.FindControl("jolbl")).Text, ((TextBox)row.FindControl("tboxColor")).Text);
            }
        }
        private void loadColor(DropDownList ddl)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
            {
                using (SqlCommand sqlcmd = new SqlCommand("select * from kmdi_addinfo_tb where type = 'PROFILE_FINISH' order by value asc", sqlcon))
                {
                    sqlcon.Open();
                    ddl.DataSource = sqlcmd.ExecuteReader();
                    ddl.DataTextField = "value";
                    ddl.DataValueField = "value";
                    ddl.DataBind();
                }
            }
        }
        private void updateColor(string jo, string profileColor)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("update addendum_to_contract_tb set profile_finish = '" + profileColor + "' where job_order_no = '" + jo + "'", sqlcon))
                    {
                        sqlcon.Open();
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
        private void updateaddress(string parentjono, string unitno, string establishment, string no, string street, string village, string brgy, string town, string province, string area)
        {
            try
            {
                string fulladd = AddressFormat(unitno, establishment,no,street,village,brgy,town,province,area);
                string str = " update addendum_to_contract_tb set unitno='" + unitno + "', " +
                             " establishment='" + establishment + "',					   " +
                             " no='" + no + "',											   " +
                             " street='" + street + "',									   " +
                             " village='" + village + "',								   " +
                             " BRGY_MUNICIPALITY='" + brgy + "',			               " +
                             " TOWN_DISTRICT='" + town + "',					           " +
                             " province='" + province + "',								   " +
                             " area='" + area + "', 									   " +
                             " fulladd='" + fulladd + "'										   " +
                             " where parentjono = '" + parentjono + "'				       ";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
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
        private void insertrequest(string cin)
        {
            try
            {

                string find = " select * from RequestCollectionApproval where cin = @cin";
                string str = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from RequestCollectionApproval)" +
                                " insert into RequestCollectionApproval     " +
                                " (ID                                         " +
                                " , CIN                                      " +
                                " , REQUESTED                                " +
                                " , APPROVED                                 " +
                                " , DISAPPROVED                              " +
                                " ,[MESSAGE])                                " +
                                " values                                     " +
                                "  (@id                                      " +
                                " , @cin                                     " +
                                " , getdate()                               " +
                                " , ''                                " +
                                " , ''                             " +
                                " , '')                           ";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                    if (bol == false)
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
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                getdata();
            }
        }
        public string AddressFormat(string unitnoAF, string establishmentAF, string housenoAF, string streetAF, string villageAF, string brgyAF, string cityAF, string provinceAF, string areaAF)
        {
            string FullAddress_Global = null;

            string UnitNo_Global;
            string Establishment_Global;
            string HouseNo_Global;
            string Street_Global;
            string Village_Global;
            string Brgy_Global;
            string CityMunicipality_Global;
            string Province_Global;
            string Area_Global;

            unitnoAF = unitnoAF.Trim();
            establishmentAF = establishmentAF.Trim();
            housenoAF = housenoAF.Trim();
            streetAF = streetAF.Trim();
            villageAF = villageAF.Trim();
            brgyAF = brgyAF.Trim();
            cityAF = cityAF.Trim();
            provinceAF = provinceAF.Trim();
            areaAF = areaAF.Trim();

            unitnoAF = unitnoAF.TrimEnd(System.Convert.ToChar(","));
            establishmentAF = establishmentAF.TrimEnd(System.Convert.ToChar(","));
            housenoAF = housenoAF.TrimEnd(System.Convert.ToChar(","));
            streetAF = streetAF.TrimEnd(System.Convert.ToChar(","));
            villageAF = villageAF.TrimEnd(System.Convert.ToChar(","));
            brgyAF = brgyAF.TrimEnd(System.Convert.ToChar(","));
            cityAF = cityAF.TrimEnd(System.Convert.ToChar(","));
            provinceAF = provinceAF.TrimEnd(System.Convert.ToChar(","));
            areaAF = areaAF.TrimEnd(System.Convert.ToChar(","));

            UnitNo_Global = unitnoAF;
            Establishment_Global = establishmentAF;
            HouseNo_Global = housenoAF;
            Street_Global = streetAF;
            Village_Global = villageAF;
            Brgy_Global = brgyAF;
            CityMunicipality_Global = cityAF;
            Province_Global = provinceAF;

            if (areaAF.IndexOf("Luzon", 0, StringComparison.CurrentCultureIgnoreCase) > -1)
                areaAF = "Luzon";
            else if (areaAF.IndexOf("Visayas", 0, StringComparison.CurrentCultureIgnoreCase) > -1)
                areaAF = "Visayas";
            else if (areaAF.IndexOf("Mindanao", 0, StringComparison.CurrentCultureIgnoreCase) > -1)
                areaAF = "Mindanao";
            else
                areaAF = "";

            Area_Global = areaAF;

            switch (unitnoAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        FullAddress_Global = unitnoAF;
                        break;
                    }
            }

            switch (establishmentAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        FullAddress_Global = FullAddress_Global + " " + establishmentAF;
                        break;
                    }
            }

            switch (housenoAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        FullAddress_Global = FullAddress_Global + " " + housenoAF;
                        break;
                    }
            }

            switch (streetAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        FullAddress_Global = FullAddress_Global + " " + streetAF;
                        break;
                    }
            }

            switch (villageAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        switch (housenoAF)
                        {
                            case "":
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                FullAddress_Global = FullAddress_Global + " " + villageAF;
                                                break;
                                            }

                                        default:
                                            {
                                                FullAddress_Global = FullAddress_Global + ", " + villageAF;
                                                break;
                                            }
                                    }

                                    break;
                                }

                            default:
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                FullAddress_Global = FullAddress_Global + " " + villageAF;
                                                break;
                                            }

                                        default:
                                            {
                                                FullAddress_Global = FullAddress_Global + ", " + villageAF;
                                                break;
                                            }
                                    }

                                    break;
                                }
                        }

                        break;
                    }
            }

            switch (brgyAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        switch (housenoAF)
                        {
                            case "":
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            FullAddress_Global = FullAddress_Global + " " + brgyAF;
                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            FullAddress_Global = FullAddress_Global + ", " + brgyAF;
                                                            break;
                                                        }
                                                }

                                                break;
                                            }

                                        default:
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            FullAddress_Global = FullAddress_Global + ", " + brgyAF;
                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            FullAddress_Global = FullAddress_Global + ", " + brgyAF;
                                                            break;
                                                        }
                                                }

                                                break;
                                            }
                                    }

                                    break;
                                }

                            default:
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            FullAddress_Global = FullAddress_Global + " " + brgyAF;
                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            FullAddress_Global = FullAddress_Global + ", " + brgyAF;
                                                            break;
                                                        }
                                                }

                                                break;
                                            }

                                        default:
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            FullAddress_Global = FullAddress_Global + ", " + brgyAF;
                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            FullAddress_Global = FullAddress_Global + ", " + brgyAF;
                                                            break;
                                                        }
                                                }

                                                break;
                                            }
                                    }

                                    break;
                                }
                        }

                        break;
                    }
            }

            switch (cityAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        switch (housenoAF)
                        {
                            case "":
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + " " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }

                                        default:
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }
                                    }

                                    break;
                                }

                            default:
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + " " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }

                                        default:
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        FullAddress_Global = FullAddress_Global + ", " + cityAF;
                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }
                                    }

                                    break;
                                }
                        }

                        break;
                    }
            }

            switch (provinceAF)
            {
                case "":
                    {
                        FullAddress_Global = FullAddress_Global;
                        break;
                    }

                default:
                    {
                        switch (housenoAF)
                        {
                            case "":
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + " " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }

                                        default:
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }
                                    }

                                    break;
                                }

                            default:
                                {
                                    switch (streetAF)
                                    {
                                        case "":
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + " " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }

                                        default:
                                            {
                                                switch (villageAF)
                                                {
                                                    case "":
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }

                                                    default:
                                                        {
                                                            switch (brgyAF)
                                                            {
                                                                case "":
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }

                                                                default:
                                                                    {
                                                                        switch (cityAF)
                                                                        {
                                                                            case "":
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }

                                                                            default:
                                                                                {
                                                                                    FullAddress_Global = FullAddress_Global + ", " + provinceAF;
                                                                                    break;
                                                                                }
                                                                        }

                                                                        break;
                                                                    }
                                                            }

                                                            break;
                                                        }
                                                }

                                                break;
                                            }
                                    }

                                    break;
                                }
                        }

                        break;
                    }
            }

            return FullAddress_Global = FullAddress_Global.Trim();
            Area_Global = areaAF;
        }

    }
}
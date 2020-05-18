using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.DAILYHEALTHPROFILE
{
    public partial class dhpnew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["dhp_EMPNO"] != null)
            {

                if (!IsPostBack)
                {
                    lblname.Text = Session["dhp_FULLNAME"].ToString();
                    lblempno.Text = Session["dhp_EMPNO"].ToString();
                    DateTime now = DateTime.Now;
                    DateTime givenDate = DateTime.Parse(Session["dhp_BIRTHDAY"].ToString());
                    DateTime d1 = DateTime.Now;
                    int YR = DateTime.Parse(Session["dhp_BIRTHDAY"].ToString()).Year;
                    int MM = DateTime.Parse(Session["dhp_BIRTHDAY"].ToString()).Month;
                    int DD = DateTime.Parse(Session["dhp_BIRTHDAY"].ToString()).Day;
                    DateTime d2 = new DateTime(YR, MM, DD);
                    TimeSpan difference = d1.Subtract(d2);
                    string age = (difference.TotalDays / 365.25).ToString();
                    lblage.Text = age;
                    lblbirthday.Text = Session["dhp_BIRTHDAY"].ToString();
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
    
        private void inserttempdata()
        {
            try
            {
                string find = "select * from dhrtemperaturetbl where empno=@empno and dhpid=@dhpid";
                bool exist = false;


                string insertstr = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from dhrtemperaturetbl)" +
                                   " insert into dhrtemperaturetbl (id,empno,dhpid,moatt,motr,miatt,mitr,afatt,aftr,evatt,evtr)values(@id,@empno,@dhpid,@moatt,@motr,@miatt,@mitr,@afatt,@aftr,@evatt,@evtr)";
                string updatestr = " update dhrtemperaturetbl set moatt=@moatt,motr=@motr,miatt=@miatt,mitr=@mitr,afatt=@afatt,aftr=@aftr,evatt=@evatt,evtr=@evtr where empno = @empno and dhpid=@dhpid";

                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@empno", empno);
                        sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                exist = true;
                            }
                            else
                            {
                                exist = false;
                            }
                        }

                    }
                    if (exist)
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(updatestr, sqlcon))
                        {

                            sqlcmd.Parameters.AddWithValue("@empno", empno);
                            sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
                            sqlcmd.Parameters.AddWithValue("@moatt", tboxmoatt.Text);
                            sqlcmd.Parameters.AddWithValue("@motr", tboxmotr.Text);
                            sqlcmd.Parameters.AddWithValue("@miatt", tboxmiatt.Text);
                            sqlcmd.Parameters.AddWithValue("@mitr", tboxmitr.Text);
                            sqlcmd.Parameters.AddWithValue("@afatt", tboxafatt.Text);
                            sqlcmd.Parameters.AddWithValue("@aftr", tboxaftr.Text);
                            sqlcmd.Parameters.AddWithValue("@evatt", tboxevatt.Text);
                            sqlcmd.Parameters.AddWithValue("@evtr", tboxevtr.Text);
                            sqlcmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(insertstr, sqlcon))
                        {

                            sqlcmd.Parameters.AddWithValue("@empno", empno);
                            sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
                            sqlcmd.Parameters.AddWithValue("@moatt", tboxmoatt.Text);
                            sqlcmd.Parameters.AddWithValue("@motr", tboxmotr.Text);
                            sqlcmd.Parameters.AddWithValue("@miatt", tboxmiatt.Text);
                            sqlcmd.Parameters.AddWithValue("@mitr", tboxmitr.Text);
                            sqlcmd.Parameters.AddWithValue("@afatt", tboxafatt.Text);
                            sqlcmd.Parameters.AddWithValue("@aftr", tboxaftr.Text);
                            sqlcmd.Parameters.AddWithValue("@evatt", tboxevatt.Text);
                            sqlcmd.Parameters.AddWithValue("@evtr", tboxevtr.Text);
                            sqlcmd.ExecuteNonQuery();
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
         
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            inserttempdata();
        }
        private void insertanswersheet()
        {
            try
            {
                string find = "select * from ASNWERSHEETtbl where empno=@empno and dhpid=@dhpid";
                bool exist = false;


                string insertstr = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from ASNWERSHEETtbl) " +
                                   "insert into ASNWERSHEETtbl " +
                                    "(ID ,	" +
                                    "EMPNO,	" +
                                    "DHPID,	" +
                                    "DCEX ,	" +
                                    "DCDO ,	" +
                                    "DCET ,	" +
                                    "DCRE ,	" +
                                    "FEEX ,	" +
                                    "FEDO ,	" +
                                    "FEET ,	" +
                                    "FERE ,	" +
                                    "MPEX ,	" +
                                    "MPDO ,	" +
                                    "MPET ,	" +
                                    "MPRE ,	" +
                                    "DSEX ,	" +
                                    "DSDO ,	" +
                                    "DSET ,	" +
                                    "DSRE ,	" +
                                    "DTEX ,	" +
                                    "DTDO ,	" +
                                    "DTET ,	" +
                                    "DTRE ,	" +
                                    "DIEX ,	" +
                                    "DIDO ,	" +
                                    "DIET ,	" +
                                    "DIRE ,	" +
                                    "DBEX ,	" +
                                    "DBDO ,	" +
                                    "DBET ,	" +
                                    "DBRE ,	" +
                                    "LBEX ,	" +
                                    "LBDO ,	" +
                                    "LBET ,	" +
                                    "LBRE ,	" +
                                    "OSEX ,	" +
                                    "OSDO ,	" +
                                    "OSET ,	" +
                                    "OSRE)	" +
                                    "values	" +
                                    "(@id ,	" +
                                    "@empno," +
                                    "@dhpid," +
                                    "@DCEX ," +
                                    "@DCDO ," +
                                    "@DCET ," +
                                    "@DCRE ," +
                                    "@FEEX ," +
                                    "@FEDO ," +
                                    "@FEET ," +
                                    "@FERE ," +
                                    "@MPEX ," +
                                    "@MPDO ," +
                                    "@MPET ," +
                                    "@MPRE ," +
                                    "@DSEX ," +
                                    "@DSDO ," +
                                    "@DSET ," +
                                    "@DSRE ," +
                                    "@DTEX ," +
                                    "@DTDO ," +
                                    "@DTET ," +
                                    "@DTRE ," +
                                    "@DIEX ," +
                                    "@DIDO ," +
                                    "@DIET ," +
                                    "@DIRE ," +
                                    "@DBEX ," +
                                    "@DBDO ," +
                                    "@DBET ," +
                                    "@DBRE ," +
                                    "@LBEX ," +
                                    "@LBDO ," +
                                    "@LBET ," +
                                    "@LBRE ," +
                                    "@OSEX ," +
                                    "@OSDO ," +
                                    "@OSET ," +
                                    "@OSRE) ";
                string updatestr = " update ASNWERSHEETtbl set " +
                                    " DCEX = @DCEX , " +
                                    " DCDO = @DCDO , " +
                                    " DCET = @DCET , " +
                                    " DCRE = @DCRE , " +
                                    " FEEX = @FEEX , " +
                                    " FEDO = @FEDO , " +
                                    " FEET = @FEET , " +
                                    " FERE = @FERE , " +
                                    " MPEX = @MPEX , " +
                                    " MPDO = @MPDO , " +
                                    " MPET = @MPET , " +
                                    " MPRE = @MPRE , " +
                                    " DSEX = @DSEX , " +
                                    " DSDO = @DSDO , " +
                                    " DSET = @DSET , " +
                                    " DSRE = @DSRE , " +
                                    " DTEX = @DTEX , " +
                                    " DTDO = @DTDO , " +
                                    " DTET = @DTET , " +
                                    " DTRE = @DTRE , " +
                                    " DIEX = @DIEX , " +
                                    " DIDO = @DIDO , " +
                                    " DIET = @DIET , " +
                                    " DIRE = @DIRE , " +
                                    " DBEX = @DBEX , " +
                                    " DBDO = @DBDO , " +
                                    " DBET = @DBET , " +
                                    " DBRE = @DBRE , " +
                                    " LBEX = @LBEX , " +
                                    " LBDO = @LBDO , " +
                                    " LBET = @LBET , " +
                                    " LBRE = @LBRE , " +
                                    " OSEX = @OSEX , " +
                                    " OSDO = @OSDO , " +
                                    " OSET = @OSET , " +
                                    " OSRE = @OSRE   " +
                                    " where EMPNO=@empno and DHPID=@dhpid ";


                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@empno", empno);
                        sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                exist = true;
                            }
                            else
                            {
                                exist = false;
                            }
                        }

                    }
                    if (exist)
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(updatestr, sqlcon))
                        {
                            setparam(sqlcmd);
                        }
                    }
                    else
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(insertstr, sqlcon))
                        {
                            setparam(sqlcmd);
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }
        private void setparam(SqlCommand sqlcmd)
        {
            sqlcmd.Parameters.AddWithValue("@empno", empno);
            sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
            sqlcmd.Parameters.AddWithValue("@DCEX", cboxDCEX.Checked);
            sqlcmd.Parameters.AddWithValue("@DCDO", tboxDCDO.Text);
            sqlcmd.Parameters.AddWithValue("@DCET", tboxDCET.Text);
            sqlcmd.Parameters.AddWithValue("@DCRE", tboxDCRE.Text);
            sqlcmd.Parameters.AddWithValue("@FEEX", cboxFEEX.Checked);
            sqlcmd.Parameters.AddWithValue("@FEDO", tboxFEDO.Text);
            sqlcmd.Parameters.AddWithValue("@FEET", tboxFEET.Text);
            sqlcmd.Parameters.AddWithValue("@FERE", tboxFERE.Text);
            sqlcmd.Parameters.AddWithValue("@MPEX", cboxMPEX.Checked);
            sqlcmd.Parameters.AddWithValue("@MPDO", tboxMPDO.Text);
            sqlcmd.Parameters.AddWithValue("@MPET", tboxMPET.Text);
            sqlcmd.Parameters.AddWithValue("@MPRE", tboxMPRE.Text);
            sqlcmd.Parameters.AddWithValue("@DSEX", cboxDSEX.Checked);
            sqlcmd.Parameters.AddWithValue("@DSDO", tboxDSDO.Text);
            sqlcmd.Parameters.AddWithValue("@DSET", tboxDSET.Text);
            sqlcmd.Parameters.AddWithValue("@DSRE", tboxDSRE.Text);
            sqlcmd.Parameters.AddWithValue("@DTEX", cboxDTEX.Checked);
            sqlcmd.Parameters.AddWithValue("@DTDO", tboxDTDO.Text);
            sqlcmd.Parameters.AddWithValue("@DTET", tboxDTET.Text);
            sqlcmd.Parameters.AddWithValue("@DTRE", tboxDTRE.Text);
            sqlcmd.Parameters.AddWithValue("@DIEX", cboxDIEX.Checked);
            sqlcmd.Parameters.AddWithValue("@DIDO", tboxDIDO.Text);
            sqlcmd.Parameters.AddWithValue("@DIET", tboxDIET.Text);
            sqlcmd.Parameters.AddWithValue("@DIRE", tboxDIRE.Text);
            sqlcmd.Parameters.AddWithValue("@DBEX", cboxDBEX.Checked);
            sqlcmd.Parameters.AddWithValue("@DBDO", tboxDBDO.Text);
            sqlcmd.Parameters.AddWithValue("@DBET", tboxDBET.Text);
            sqlcmd.Parameters.AddWithValue("@DBRE", tboxDBRE.Text);
            sqlcmd.Parameters.AddWithValue("@LBEX", cboxLBEX.Checked);
            sqlcmd.Parameters.AddWithValue("@LBDO", tboxLBDO.Text);
            sqlcmd.Parameters.AddWithValue("@LBET", tboxLBET.Text);
            sqlcmd.Parameters.AddWithValue("@LBRE", tboxLBRE.Text);
            sqlcmd.Parameters.AddWithValue("@OSEX", cboxOSEX.Checked);
            sqlcmd.Parameters.AddWithValue("@OSDO", tboxOSDO.Text);
            sqlcmd.Parameters.AddWithValue("@OSET", tboxOSET.Text);
            sqlcmd.Parameters.AddWithValue("@OSRE", tboxOSRE.Text);
            sqlcmd.ExecuteNonQuery();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            insertanswersheet();
        }
    }
}
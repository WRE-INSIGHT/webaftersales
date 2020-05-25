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
            if (Session["dhp_USERNAME"] != null)
            {

                if (!IsPostBack)
                {
                    lbldate.Text= Session["dhpdate"].ToString();
                    lblname.Text = Session["dhpname"].ToString();
                    lblempno.Text = Session["dhpempno"].ToString();
                    lblage.Text = Session["dhpage"].ToString();
                    lblbirthday.Text = Session["dhpbirthday"].ToString();
                    getdata();
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
                return Session["dhpempno"].ToString();
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
        private void getdata()
        {
            try
            {
                string str = " select * from asnwersheettbl where empno = @empno and dhpid=@dhpid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@empno", empno);
                        sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                DCEXyes.Checked = getbol(rd["DCEX"].ToString());
                                DCEXno.Checked = getbol(rd["DCEXno"].ToString());
                                tboxDCDO.Text = rd["DCDO"].ToString();
                                tboxDCET.Text = rd["DCET"].ToString();
                                tboxDCRE.Text = rd["DCRE"].ToString();
                                FEEXyes.Checked = getbol(rd["FEEX"].ToString());
                                FEEXno.Checked = getbol(rd["FEEXno"].ToString());
                                tboxFEDO.Text = rd["FEDO"].ToString();
                                tboxFEET.Text = rd["FEET"].ToString();
                                tboxFERE.Text = rd["FERE"].ToString();
                                MPEXyes.Checked = getbol(rd["MPEX"].ToString());
                                MPEXno.Checked = getbol(rd["MPEXno"].ToString());
                                tboxMPDO.Text = rd["MPDO"].ToString();
                                tboxMPET.Text = rd["MPET"].ToString();
                                tboxMPRE.Text = rd["MPRE"].ToString();
                                WEEXyes.Checked = getbol(rd["WEEX"].ToString());
                                WEEXno.Checked = getbol(rd["WEEXno"].ToString());
                                tboxWEDO.Text = rd["WEDO"].ToString();
                                tboxWEET.Text = rd["WEET"].ToString();
                                tboxWERE.Text = rd["WERE"].ToString();
                                DSEXyes.Checked = getbol(rd["DSEX"].ToString());
                                DSEXno.Checked = getbol(rd["DSEXno"].ToString());
                                tboxDSDO.Text = rd["DSDO"].ToString();
                                tboxDSET.Text = rd["DSET"].ToString();
                                tboxDSRE.Text = rd["DSRE"].ToString();
                                DTEXyes.Checked = getbol(rd["DTEX"].ToString());
                                DTEXno.Checked = getbol(rd["DTEXno"].ToString());
                                tboxDTDO.Text = rd["DTDO"].ToString();
                                tboxDTET.Text = rd["DTET"].ToString();
                                tboxDTRE.Text = rd["DTRE"].ToString();
                                DIEXyes.Checked = getbol(rd["DIEX"].ToString());
                                DIEXno.Checked = getbol(rd["DIEXno"].ToString());
                                tboxDIDO.Text = rd["DIDO"].ToString();
                                tboxDIET.Text = rd["DIET"].ToString();
                                tboxDIRE.Text = rd["DIRE"].ToString();
                                DBEXyes.Checked = getbol(rd["DBEX"].ToString());
                                DBEXno.Checked = getbol(rd["DBEXno"].ToString());
                                tboxDBDO.Text = rd["DBDO"].ToString();
                                tboxDBET.Text = rd["DBET"].ToString();
                                tboxDBRE.Text = rd["DBRE"].ToString();
                                LBEXyes.Checked = getbol(rd["LBEX"].ToString());
                                LBEXno.Checked = getbol(rd["LBEXno"].ToString());
                                tboxLBDO.Text = rd["LBDO"].ToString();
                                tboxLBET.Text = rd["LBET"].ToString();
                                tboxLBRE.Text = rd["LBRE"].ToString();
                                OSEXyes.Checked = getbol(rd["OSEX"].ToString());
                                OSEXno.Checked = getbol(rd["OSEXno"].ToString());
                                tboxOSDO.Text = rd["OSDO"].ToString();
                                tboxOSET.Text = rd["OSET"].ToString();
                                tboxOSRE.Text = rd["OSRE"].ToString();
                                tboxOS.Text =rd["OS"].ToString();
                                tboxCOM.Text = rd["COMMENT"].ToString();
                                tboxmoatt.Text = rd["MOATT"].ToString();
                                tboxmotr.Text = rd["MOTR"].ToString();
                                tboxmiatt.Text = rd["MIATT"].ToString();
                                tboxmitr.Text = rd["MITR"].ToString();
                                tboxafatt.Text = rd["AFATT"].ToString();
                                tboxaftr.Text = rd["AFTR"].ToString();
                                tboxevatt.Text = rd["EVATT"].ToString();
                                tboxevtr.Text = rd["EVTR"].ToString();
                            }

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
     
        private bool getbol(string val)
        {
            return (val != "0");
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
                                    "DCEXno ,	" +
                                    "DCDO ,	" +
                                    "DCET ,	" +
                                    "DCRE ,	" +
                                    "FEEX ,	" +
                                    "FEEXno ,	" +
                                    "FEDO ,	" +
                                    "FEET ,	" +
                                    "FERE ,	" +
                                    "MPEX ,	" +
                                    "MPEXno ,	" +
                                    "MPDO ,	" +
                                    "MPET ,	" +
                                    "MPRE ,	" +
                                    "WEEX ,	" +
                                    "WEEXno ,	" +
                                    "WEDO ,	" +
                                    "WEET ,	" +
                                    "WERE ,	" +
                                    "DSEX ,	" +
                                    "DSEXno ,	" +
                                    "DSDO ,	" +
                                    "DSET ,	" +
                                    "DSRE ,	" +
                                    "DTEX ,	" +
                                    "DTEXno ,	" +
                                    "DTDO ,	" +
                                    "DTET ,	" +
                                    "DTRE ,	" +
                                    "DIEX ,	" +
                                    "DIEXno ,	" +
                                    "DIDO ,	" +
                                    "DIET ,	" +
                                    "DIRE ,	" +
                                    "DBEX ,	" +
                                    "DBEXno ,	" +
                                    "DBDO ,	" +
                                    "DBET ,	" +
                                    "DBRE ,	" +
                                    "LBEX ,	" +
                                    "LBEXno ,	" +
                                    "LBDO ,	" +
                                    "LBET ,	" +
                                    "LBRE ,	" +
                                    "OSEX ,	" +
                                    "OSEXno ,	" +
                                    "OSDO ,	" +
                                    "OSET ,	" +
                                    "OSRE ,	" +
                                    " OS,COMMENT,moatt,motr,miatt,mitr,afatt,aftr,evatt,evtr) " +
                                    "values	" +
                                    "(@id ,	" +
                                    "@empno," +
                                    "@dhpid," +
                                    "@DCEX ," +
                                    "@DCEXno ," +
                                    "@DCDO ," +
                                    "@DCET ," +
                                    "@DCRE ," +
                                    "@FEEX ," +
                                    "@FEEXno ," +
                                    "@FEDO ," +
                                    "@FEET ," +
                                    "@FERE ," +
                                    "@MPEX ," +
                                    "@MPEXno ," +
                                    "@MPDO ," +
                                    "@MPET ," +
                                    "@MPRE ," +
                                    "@WEEX ," +
                                    "@WEEXno ," +
                                    "@WEDO ," +
                                    "@WEET ," +
                                    "@WERE ," +
                                    "@DSEX ," +
                                    "@DSEXno ," +
                                    "@DSDO ," +
                                    "@DSET ," +
                                    "@DSRE ," +
                                    "@DTEX ," +
                                    "@DTEXno ," +
                                    "@DTDO ," +
                                    "@DTET ," +
                                    "@DTRE ," +
                                    "@DIEX ," +
                                    "@DIEXno ," +
                                    "@DIDO ," +
                                    "@DIET ," +
                                    "@DIRE ," +
                                    "@DBEX ," +
                                    "@DBEXno ," +
                                    "@DBDO ," +
                                    "@DBET ," +
                                    "@DBRE ," +
                                    "@LBEX ," +
                                    "@LBEXno ," +
                                    "@LBDO ," +
                                    "@LBET ," +
                                    "@LBRE ," +
                                    "@OSEX ," +
                                    "@OSEXno ," +
                                    "@OSDO ," +
                                    "@OSET ," +
                                    "@OSRE , " +
                                    " @OS,@COMMENT,@moatt,@motr,@miatt,@mitr,@afatt,@aftr,@evatt,@evtr) ";
                string updatestr = " update ASNWERSHEETtbl set " +
                                    " DCEX = @DCEX , " +
                                    " DCEXno = @DCEXno , " +
                                    " DCDO = @DCDO , " +
                                    " DCET = @DCET , " +
                                    " DCRE = @DCRE , " +
                                    " FEEX = @FEEX , " +
                                    " FEEXno = @FEEXno , " +
                                    " FEDO = @FEDO , " +
                                    " FEET = @FEET , " +
                                    " FERE = @FERE , " +
                                    " MPEX = @MPEX , " +
                                    " MPEXno = @MPEXno , " +
                                    " MPDO = @MPDO , " +
                                    " MPET = @MPET , " +
                                    " MPRE = @MPRE , " +
                                    " WEEX = @WEEX , " +
                                    " WEEXno = @WEEXno , " +
                                    " WEDO = @WEDO , " +
                                    " WEET = @WEET , " +
                                    " WERE = @WERE , " +
                                    " DSEX = @DSEX , " +
                                    " DSEXno = @DSEXno , " +
                                    " DSDO = @DSDO , " +
                                    " DSET = @DSET , " +
                                    " DSRE = @DSRE , " +
                                    " DTEX = @DTEX , " +
                                    " DTEXno = @DTEXno , " +
                                    " DTDO = @DTDO , " +
                                    " DTET = @DTET , " +
                                    " DTRE = @DTRE , " +
                                    " DIEX = @DIEX , " +
                                    " DIEXno = @DIEXno , " +
                                    " DIDO = @DIDO , " +
                                    " DIET = @DIET , " +
                                    " DIRE = @DIRE , " +
                                    " DBEX = @DBEX , " +
                                    " DBEXno = @DBEXno , " +
                                    " DBDO = @DBDO , " +
                                    " DBET = @DBET , " +
                                    " DBRE = @DBRE , " +
                                    " LBEX = @LBEX , " +
                                    " LBEXno = @LBEXno , " +
                                    " LBDO = @LBDO , " +
                                    " LBET = @LBET , " +
                                    " LBRE = @LBRE , " +
                                    " OSEX = @OSEX , " +
                                    " OSEXno = @OSEXno , " +
                                    " OSDO = @OSDO , " +
                                    " OSET = @OSET , " +
                                    " OSRE = @OSRE ,  " +
                                    " OS = @OS ,  " +
                                    " COMMENT = @COMMENT ,  " +
                                    " moatt=@moatt,motr=@motr,miatt=@miatt,mitr=@mitr,afatt=@afatt,aftr=@aftr,evatt=@evatt,evtr=@evtr " +
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
            finally
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "val2";
                err.IsValid = false;
                err.ErrorMessage = "page 1 saved successfully";
                Page.Validators.Add(err);
            }

        }
        private void setparam(SqlCommand sqlcmd)
        {
            if (tboxmotr.Text == "")
            {
                tboxmotr.Text = "0";
            }
            if (tboxmitr.Text == "")
            {
                tboxmitr.Text = "0";
            }
            if (tboxaftr.Text == "")
            {
                tboxaftr.Text = "0";
            }
            if (tboxevtr.Text == "")
            {
                tboxevtr.Text = "0";
            }

            sqlcmd.Parameters.AddWithValue("@empno", empno);
            sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
            sqlcmd.Parameters.AddWithValue("@DCEX", DCEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@DCEXno", DCEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@DCDO", tboxDCDO.Text);
            sqlcmd.Parameters.AddWithValue("@DCET", tboxDCET.Text);
            sqlcmd.Parameters.AddWithValue("@DCRE", tboxDCRE.Text);
            sqlcmd.Parameters.AddWithValue("@FEEX", FEEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@FEEXno", FEEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@FEDO", tboxFEDO.Text);
            sqlcmd.Parameters.AddWithValue("@FEET", tboxFEET.Text);
            sqlcmd.Parameters.AddWithValue("@FERE", tboxFERE.Text);
            sqlcmd.Parameters.AddWithValue("@MPEX", MPEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@MPEXno", MPEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@MPDO", tboxMPDO.Text);
            sqlcmd.Parameters.AddWithValue("@MPET", tboxMPET.Text);
            sqlcmd.Parameters.AddWithValue("@MPRE", tboxMPRE.Text);
            sqlcmd.Parameters.AddWithValue("@WEEX", WEEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@WEEXno", WEEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@WEDO", tboxWEDO.Text);
            sqlcmd.Parameters.AddWithValue("@WEET", tboxWEET.Text);
            sqlcmd.Parameters.AddWithValue("@WERE", tboxWERE.Text);
            sqlcmd.Parameters.AddWithValue("@DSEX", DSEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@DSEXno", DSEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@DSDO", tboxDSDO.Text);
            sqlcmd.Parameters.AddWithValue("@DSET", tboxDSET.Text);
            sqlcmd.Parameters.AddWithValue("@DSRE", tboxDSRE.Text);
            sqlcmd.Parameters.AddWithValue("@DTEX", DTEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@DTEXno", DTEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@DTDO", tboxDTDO.Text);
            sqlcmd.Parameters.AddWithValue("@DTET", tboxDTET.Text);
            sqlcmd.Parameters.AddWithValue("@DTRE", tboxDTRE.Text);
            sqlcmd.Parameters.AddWithValue("@DIEX", DIEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@DIEXno", DIEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@DIDO", tboxDIDO.Text);
            sqlcmd.Parameters.AddWithValue("@DIET", tboxDIET.Text);
            sqlcmd.Parameters.AddWithValue("@DIRE", tboxDIRE.Text);
            sqlcmd.Parameters.AddWithValue("@DBEX", DBEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@DBEXno", DBEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@DBDO", tboxDBDO.Text);
            sqlcmd.Parameters.AddWithValue("@DBET", tboxDBET.Text);
            sqlcmd.Parameters.AddWithValue("@DBRE", tboxDBRE.Text);
            sqlcmd.Parameters.AddWithValue("@LBEX", LBEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@LBEXno", LBEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@LBDO", tboxLBDO.Text);
            sqlcmd.Parameters.AddWithValue("@LBET", tboxLBET.Text);
            sqlcmd.Parameters.AddWithValue("@LBRE", tboxLBRE.Text);
            sqlcmd.Parameters.AddWithValue("@OSEX", OSEXyes.Checked);
            sqlcmd.Parameters.AddWithValue("@OSEXno", OSEXno.Checked);
            sqlcmd.Parameters.AddWithValue("@OSDO", tboxOSDO.Text);
            sqlcmd.Parameters.AddWithValue("@OSET", tboxOSET.Text);
            sqlcmd.Parameters.AddWithValue("@OSRE", tboxOSRE.Text);
            sqlcmd.Parameters.AddWithValue("@OS", tboxOS.Text);
            sqlcmd.Parameters.AddWithValue("@COMMENT", tboxCOM.Text);
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

        protected void Button2_Click(object sender, EventArgs e)
        {
            insertanswersheet();
        }

    
    }
}
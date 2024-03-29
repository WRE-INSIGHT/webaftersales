﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class signaturePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    if (Session["Signatureby"].ToString() == "panel1")
                    {
                        Panel1.Visible = true;
                    }
                    else if (Session["Signatureby"].ToString() == "panel2")
                    {
                        Panel2.Visible = true;
                    }
                    else if (Session["Signatureby"].ToString() == "panel3")
                    {
                        Panel3.Visible = true;
                    }
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
        private string sid
        {
            get
            {
                return Session["SID"].ToString() +"/";
            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
          
            if (IsValid)
            {
                //Session["dataurlsignature"] = Request.Form["myurl"];
                //Session["inspectedby"] = tboxinspector.Text;
                //Session["inspecteddate"] = tboxinspectordate.Text;
                string filepath = "~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/signature/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + "inspectedby.jpg"));
                //ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "successfulmessage();", true);
                string str = "update servicingtb set inspectedby=@person,insdate=@date where id = @sid";
                updatetb(str, tboxinspector.Text, tboxinspectordate.Text);
                Response.Redirect("~/AFTERSALESPROJ/reportviewPage.aspx");
            }
        }
        public static void UploadImage(string imageData,string fileNameWitPath)
        {
            using (FileStream fs = new FileStream(fileNameWitPath, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))

                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();
                }
            }
        }
        protected void Button1_Click1(object sender, EventArgs e)
        {
            if (IsValid)
            {
                //Session["dataurlsignature1"] = Request.Form["myurl1"];
                //Session["monitoredby"] = tboxmonitored.Text;
                //Session["monitoreddate"] = tboxmonitoreddate.Text;
                string filepath = "~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/signature/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl1"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + "monitoredby.jpg"));
                //ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "successfulmessage();", true);
                string str = "update servicingtb set monitoredby=@person,mondate=@date where id = @sid";
                updatetb(str, tboxmonitored.Text, tboxmonitoreddate.Text);
                Response.Redirect("~/AFTERSALESPROJ/reportviewPage.aspx");
            }

        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                //Session["dataurlsignature1"] = Request.Form["myurl1"];
                //Session["monitoredby"] = tboxmonitored.Text;
                //Session["monitoreddate"] = tboxmonitoreddate.Text;
                string filepath = "~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/signature/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl2"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + "acceptedby.jpg"));
                //ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "successfulmessage();", true);
                string str = "update servicingtb set acceptedby=@person,acceptedbydate=@date where id = @sid";
                updatetb(str, tboxaccepted.Text, tboxaccepteddate.Text);
                Response.Redirect("~/AFTERSALESPROJ/reportviewPage.aspx");
            }

        }
        private void updatetb(string qry,string person,string sdate)
        {
            try
            {
              
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(qry, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@sid",Session["SID"].ToString());
                        sqlcmd.Parameters.AddWithValue("@person", person);
                        sqlcmd.Parameters.AddWithValue("@date", sdate);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        
        }
    }
}
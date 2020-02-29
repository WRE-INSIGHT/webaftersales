using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                byte[] barr = imgToBytearray(Image1);
                ReportParameter param1 = new ReportParameter("imagebyte", Convert.ToBase64String(barr));
                ReportViewer1.LocalReport.SetParameters(param1);
            }
        }

        public byte[] imgToBytearray(System.Drawing.Image img)
        {
            using (MemoryStream mstream = new MemoryStream())
            {
                img.Save(mstream, System.Drawing.Imaging.ImageFormat.Bmp);
                return mstream.ToArray();
            }
        }
        //public static byte[] ImageToByteArray(System.Drawing.Image img)
        //{
        //    try
        //    {
        //        MemoryStream mstImage = new MemoryStream();
        //        img.Save(mstImage, System.Drawing.Imaging.ImageFormat.Jpeg);
        //        Byte[] bytImage = mstImage.GetBuffer();
        //        return bytImage;
        //    }
        //    catch (Exception ex)
        //    {

        //    }
    }

}
}
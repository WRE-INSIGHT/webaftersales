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

namespace webaftersales.AFTERSALESPROJ
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
        
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Cache["accttb"] != null)
            {
                DataSet ds = (DataSet)Cache["accttb"];
                GridView1.DataSource = ds;
                GridView1.DataBind();
                Label1.Text = "from cache";
            }
            else
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("select * from accttb", sqlcon))
                    {
                        sqlcon.Open();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        DataSet ds = new DataSet();
                        da.Fill(ds, "tb");
                        System.Web.Caching.SqlCacheDependencyAdmin.EnableNotifications(cs);
                        System.Web.Caching.SqlCacheDependencyAdmin.EnableTableForNotifications(cs, "accttb");
                    

                        CacheItemRemovedCallback onCacheItemRemoved = new CacheItemRemovedCallback(CacheItemRemovedCallbackMethod);


                        SqlCacheDependency sqlDependency = new SqlCacheDependency("ASDB", "accttb");
                        Cache.Insert("accttb", ds, sqlDependency,DateTime.Now.AddHours(24),Cache.NoSlidingExpiration,CacheItemPriority.Default, onCacheItemRemoved);


                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                        Label1.Text = "from sql";
                    }


                }
            }
        }
        public void CacheItemRemovedCallbackMethod(string key, object value, CacheItemRemovedReason reason)
        {
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                using (SqlCommand sqlcmd = new SqlCommand("select * from accttb", sqlcon))
                {
                    sqlcon.Open();
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    DataSet ds = new DataSet();
                    da.Fill(ds, "tb");

                    System.Web.Caching.SqlCacheDependencyAdmin.EnableNotifications(cs);
                    System.Web.Caching.SqlCacheDependencyAdmin.EnableTableForNotifications(cs, "accttb");

                    CacheItemRemovedCallback onCacheItemRemoved = new CacheItemRemovedCallback(CacheItemRemovedCallbackMethod);


                    SqlCacheDependency sqlDependency = new SqlCacheDependency("ASDB", "accttb");
                    Cache.Insert("accttb", ds, sqlDependency, DateTime.Now.AddHours(24), Cache.NoSlidingExpiration, CacheItemPriority.Default, onCacheItemRemoved);
                }

            }
            Cache["changed"]="changed";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Cache.Remove("accttb");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Label1.Text = Cache["changed"].ToString();
        }
    }
}
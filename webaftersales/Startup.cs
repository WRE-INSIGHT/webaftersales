using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(webaftersales.Startup))]
namespace webaftersales
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

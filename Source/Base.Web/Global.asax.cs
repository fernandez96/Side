using Base.DTO.AutoMapper;
using System.Web.Mvc;
using System.Web.Routing;

namespace Base.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            log4net.Config.XmlConfigurator.Configure();
            AutoMapperConfiguration.Configure();
        }
    }
}

using Base.DTO.AutoMapper;
using Base.WebApi.Core;
using System.Web.Http;

namespace Base.WebApi
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configuration.MessageHandlers.Add(new CorsHandler());
            GlobalConfiguration.Configure(WebApiConfig.Register);
            GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Clear();
            log4net.Config.XmlConfigurator.Configure();
            AutoMapperConfiguration.Configure();
        }
    }
}

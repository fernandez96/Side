using Base.BusinessEntity;
using Base.BusinessLogic;
using Base.Common;
using Base.Common.DataTable;
using Base.DTO;
using Base.DTO.AutoMapper;
using Base.Web.ApiService;
using Base.Web.Core;
using Base.Web.Models;
using Base.Web.Utilities;
using Newtonsoft.Json;
using Stimulsoft.Report;
using Stimulsoft.Report.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Base.Web.Controllers
{
    public class ReporteController : BaseController
    {
        [HttpPost]
        public ActionResult StimulsoftControl(string controllerGetSnapshot, Dictionary<string, string> parametros)
        {
            TempData["Parametros"] = parametros;
            ViewData["ControllerGetSnapshot"] = controllerGetSnapshot;
            return PartialView();
        }

    }
}
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
          //  return PartialView();
            return StiMvcViewer.ViewerEventResult();
        }
        public ActionResult GetReportSnapshot()
        {
            TablaRegistroDTO tablaRegistroDTO = new TablaRegistroDTO();
            var tablaregistro = MapperHelper.Map<TablaRegistroDTO, TablaRegistro>(tablaRegistroDTO);
            var dataDocumento = TablaRegistroBL.Instancia.GetById(new TablaRegistro { Id = 2 });

            var report = new StiReport();
            report.Load(Server.MapPath("~/Prints/M_Administrador/TablaRegistro/ReporteIngreso.mrt"));
            //report.RegBusinessObject("Almacen", "Documento", dataDocumento);
            //report.RegBusinessObject("Almacen", "DetalleDocumento", dataDocumento);
            //report.GetComponentByName("txtAnulado").Enabled = dataDocumento.EstadoDocumento ==
            //                                                  (int)EstadoDocumento.Anulado;
            return StiMvcViewer.GetReportSnapshotResult(HttpContext, report);
        }
    }
}
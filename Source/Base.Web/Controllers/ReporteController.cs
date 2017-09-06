using Base.Common;
using Base.Common.DataTable;
using Base.Web.ApiService;
using Base.Web.Core;
using Base.Web.Models;
using Base.Web.Utilities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Base.Web.Controllers
{
    public class ReporteController : BaseController
    {
        // GET: Reporte
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Listar(DataTableModel<ReporteFilterModel, int> dataTableModel)
        {
            try
            {
                FormatDataTable(dataTableModel);
                var jsonResponse = new JsonResponse { Success = false };
                jsonResponse = InvokeHelper.MakeRequest(ConstantesWeb.WS_Reporte_GetAllPaging,
                    new PaginationParameter<int>
                    {
                        AmountRows = dataTableModel.length,
                        WhereFilter = dataTableModel.whereFilter,
                        Start = dataTableModel.start,
                        OrderBy = dataTableModel.orderBy
                    }, ConstantesWeb.METHODPOST);

                var usuarioPaginationModelList = (List<ReportePaginationModel>)JsonConvert.DeserializeObject(jsonResponse.Data.ToString(), (new List<ReportePaginationModel>()).GetType());
                dataTableModel.data = usuarioPaginationModelList;
                if (usuarioPaginationModelList.Count > 0)
                {
                    dataTableModel.recordsTotal = usuarioPaginationModelList[0].CantidadRows;
                    dataTableModel.recordsFiltered = dataTableModel.recordsTotal;
                }
            }
            catch (Exception ex)
            {
                LogError(ex);

                ViewBag.MessageError = ex.Message;
                dataTableModel.data = new List<UsuarioPaginationModel>();
            }
            return Json(dataTableModel);
        }

        #region Métodos Privados

        public void FormatDataTable(DataTableModel<ReporteFilterModel, int> dataTableModel)
        {
            for (int i = 0; i < dataTableModel.order.Count; i++)
            {
                var columnIndex = dataTableModel.order[0].column;
                var columnDir = dataTableModel.order[0].dir.ToUpper();
                var column = dataTableModel.columns[columnIndex].data;
                dataTableModel.orderBy = (" [" + column + "] " + columnDir + " ");
            }
            string WhereModel = "WHERE 1=1";
            if (dataTableModel.filter.AnioSearch!=0)
            {
                WhereModel += " OR Anio="+ dataTableModel.filter.AnioSearch +"";
            }
            if (dataTableModel.filter.ClienteSearch!=null || dataTableModel.filter.ClienteSearch != "")
            {
                WhereModel += " OR Cliente='" + dataTableModel.filter.ClienteSearch + "'";
            }
            dataTableModel.whereFilter = WhereModel;

        }

        #endregion
    }
}
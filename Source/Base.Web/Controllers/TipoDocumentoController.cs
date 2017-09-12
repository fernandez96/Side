using Base.BusinessEntity;
using Base.BusinessLogic;
using Base.Common;
using Base.Common.DataTable;
using Base.DTO;
using Base.DTO.AutoMapper;
using Base.Web.Core;
using Base.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Base.Web.Controllers
{
    public class TipoDocumentoController : BaseController
    {
        // GET: TipoDocumento
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult Listar(DataTableModel<TipoDocumentoFilterModel, int> dataTableModel)
        {
            try
            {
                FormatDataTable(dataTableModel);
                var jsonResponse = new JsonResponse { Success = false };
                var tipodocumentoList = TipoDocumentoBL.Instancia.GetAllPaging(new PaginationParameter<int>
                {
                    AmountRows = dataTableModel.length,
                    WhereFilter = dataTableModel.whereFilter,
                    Start = dataTableModel.start,
                    OrderBy = dataTableModel.orderBy
                });
                var tipodocumentoDTOList = MapperHelper.Map<IEnumerable<TipoDocumento>, IEnumerable<TipoDocumentoDTO>>(tipodocumentoList);
                dataTableModel.data = tipodocumentoDTOList;
                if (tipodocumentoDTOList.Count() > 0)
                {
                    dataTableModel.recordsTotal = tipodocumentoList[0].Cantidad;
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

        public void FormatDataTable(DataTableModel<TipoDocumentoFilterModel, int> dataTableModel)
        {
            for (int i = 0; i < dataTableModel.order.Count; i++)
            {
                var columnIndex = dataTableModel.order[0].column;
                var columnDir = dataTableModel.order[0].dir.ToUpper();
                var column = dataTableModel.columns[columnIndex].data;
                dataTableModel.orderBy = (" [" + column + "] " + columnDir + " ");
            }
            string WhereModel = "WHERE tdocc_flag_estado=1";
            

            if (dataTableModel.filter.codigoSearch != null)
            {
                WhereModel += "  AND tdocc_vabreviatura_tipo_doc = '" + dataTableModel.filter.codigoSearch + "' ";
            }
            if (dataTableModel.filter.descripcionSearch != null)
            {
                WhereModel += "  AND tdocc_vdescripcion LIKE '%" + dataTableModel.filter.descripcionSearch + "%'";
            }
            dataTableModel.whereFilter = WhereModel;
        }

        #endregion
    }
}
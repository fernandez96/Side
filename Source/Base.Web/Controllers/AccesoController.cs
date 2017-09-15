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
using System.Web;
using System.Web.Mvc;

namespace Base.Web.Controllers
{
    public class AccesoController : BaseController
    {
        // GET: Acceso
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public JsonResult Listar(DataTableModel<RolFilterModel, int> dataTableModel)
        {
            try
            {
                //FormatDataTable(dataTableModel);
                var jsonResponse = new JsonResponse { Success = false };
                var usuarioList = RolBL.Instancia.GetAllActives();
               
                var usuarioDTOList = MapperHelper.Map<IEnumerable<Rol>, IEnumerable<RolDTO>>(usuarioList);
                dataTableModel.data = usuarioList;
                if (usuarioList.Count > 0)
                {
                    dataTableModel.recordsTotal = usuarioList.Count;
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

        [HttpPost]
        public JsonResult GetAllModulos()
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var moduloList = ModeloBL.Instancia.GetAllActives();
                var moduloDTOList = MapperHelper.Map<IEnumerable<Modulo>, IEnumerable<ModuloDTO>>(moduloList);
                jsonResponse.Data = moduloDTOList;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return Json(jsonResponse);
        }

        #region Métodos Privados


        public void FormatDataTable(DataTableModel<RolFilterModel, int> dataTableModel)
        {
            for (int i = 0; i < dataTableModel.order.Count; i++)
            {
                var columnIndex = dataTableModel.order[0].column;
                var columnDir = dataTableModel.order[0].dir.ToUpper();
                var column = dataTableModel.columns[columnIndex].data;
                dataTableModel.orderBy = (" [" + column + "] " + columnDir + " ");
            }

            dataTableModel.whereFilter = "WHERE Estado IN (1)";            
        }

        #endregion
    }
}
using Base.BusinessEntity;
using Base.BusinessLogic;
using Base.Common;
using Base.DTO;
using Base.DTO.AutoMapper;
using Base.WebApi.Core;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Web.Http;
namespace Base.WebApi.Controllers
{
    public class ReporteController: BaseController
    {
        [HttpPost]
        public JsonResponse GetAllPaging(PaginationParameter<int> paginationParameters)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var ReporteList = ReporteBL.Instancia.VentaGetAllFilter(paginationParameters);
                var ReporteDTOList = MapperHelper.Map<IEnumerable<Reporte>, IEnumerable<ReporteDTO>>(ReporteList);
                jsonResponse.Data = ReporteDTOList;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }


        [HttpPost]
        public JsonResponse GetAllReport(PaginationParameter<int> paginationParameters)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var ReporteList = ReporteBL.Instancia.VentaGetAllReport(paginationParameters);
                var ReporteDTOList = MapperHelper.Map<IEnumerable<Reporte>, IEnumerable<ReporteDTO>>(ReporteList);
                jsonResponse.Data = ReporteDTOList;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }
    }
}
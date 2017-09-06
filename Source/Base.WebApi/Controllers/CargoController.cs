using Base.BusinessEntity;
using Base.BusinessLogic;
using Base.Common;
using Base.DTO;
using Base.DTO.AutoMapper;
using Base.WebApi.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace Base.WebApi.Controllers
{
    public class CargoController: BaseController
    {
        [HttpPost]
        public JsonResponse GetAll(PaginationParameter<int> paginationParameters)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var usuarioList = CargoBL.Instancia.GetAll(paginationParameters);
                var usuarioDTOList = MapperHelper.Map<IEnumerable<Cargo>, IEnumerable<CargoDTO>>(usuarioList);
                jsonResponse.Data = usuarioDTOList;
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
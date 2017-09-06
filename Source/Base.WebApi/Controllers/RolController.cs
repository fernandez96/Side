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
    public class RolController: BaseController
    {
        [HttpPost]
        public JsonResponse GetAllActives()
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var rolList = RolBL.Instancia.GetAllActives();
                var rolDTOList = MapperHelper.Map<IEnumerable<Rol>, IEnumerable<RolDTO>>(rolList);
                jsonResponse.Data = rolDTOList;
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
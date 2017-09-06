using Newtonsoft.Json;
using Base.ActiveDirectory;
using Base.BusinessEntity;
using Base.BusinessLogic;
using Base.Common;
using Base.DTO;
using Base.DTO.AutoMapper;
using Base.WebApi.Core;
using System;
using System.Web.Http;

namespace Base.WebApi.Controllers
{
    public class AccountController: BaseController
    {
        [HttpPost]
        public JsonResponse Login(LoginDTO loginDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                if (loginDTO.ValidacionAD)
                {
                    UsuarioAD usuarioAD = new UsuarioAD();
                    if (usuarioAD.AutenticarEnDominio(loginDTO.Username, loginDTO.Password))
                    {
                        var usuario = UsuarioBL.Instancia.GetByUsername(loginDTO.Username);
                        if (usuario != null)
                        {
                            var usuarioLoginDTO = MapperHelper.Map<Usuario, UsuarioLoginDTO>(usuario);
                            jsonResponse.Data = usuarioLoginDTO;

                            LogBL.Instancia.Add(new Log
                            {
                                Accion = Mensajes.Login,
                                Controlador = Mensajes.AccountController,
                                Identificador = usuarioLoginDTO.Id,
                                Mensaje = Mensajes.AccesoAlSistema,
                                Usuario = usuarioLoginDTO.Username,
                                Objeto = JsonConvert.SerializeObject(usuarioLoginDTO)
                            });
                        }
                        else
                        {
                            jsonResponse.Warning = true;
                            jsonResponse.Message = Mensajes.UsuarioNoExiste;
                        }
                    }
                    else
                    {
                        jsonResponse.Warning = true;
                        jsonResponse.Message = Mensajes.CredencialesDominioIncorrectas;
                    }
                }
                else
                {
                    var usuario = UsuarioBL.Instancia.GetByUsername(loginDTO.Username);
                    if (usuario != null)
                    {
                        var usuarioLoginDTO = MapperHelper.Map<Usuario, UsuarioLoginDTO>(usuario);
                        jsonResponse.Data = usuarioLoginDTO;

                        LogBL.Instancia.Add(new Log
                        {
                            Accion = Mensajes.Login,
                            Controlador = Mensajes.AccountController,
                            Identificador = usuarioLoginDTO.Id,
                            Mensaje = Mensajes.AccesoAlSistema,
                            Usuario = usuarioLoginDTO.Username,
                            Objeto = JsonConvert.SerializeObject(usuarioLoginDTO)
                        });
                    }
                    else
                    {
                        jsonResponse.Warning = true;
                        jsonResponse.Message = Mensajes.UsuarioNoExiste;
                    }
                }
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
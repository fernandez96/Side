using Base.BusinessEntity;
using Base.BusinessLogic;
using Base.Common;
using Base.DTO;
using Base.WebApi.Core;
using ClosedXML.Excel;
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Reflection;
using System.Web.Http;
namespace Base.WebApi.Controllers
{
    public class EnvioEmailController : BaseController
    {
        [HttpPost]
        public JsonResponse Upload(EnvioEmailDTO envioemail)
        {
            
            var jsonResponse = new JsonResponse { Success = true };
            try
            {
                envioemail.FileCarga = envioemail.FileCarga.Replace(Mensajes.OpenXmlFormats, string.Empty);
                byte[] fileCarga = Convert.FromBase64String(envioemail.FileCarga);
                MemoryStream memoryStream = new MemoryStream(fileCarga);
                XLWorkbook xLWorkbook = new XLWorkbook(memoryStream);
                var worksheet = xLWorkbook.Worksheet(1);
                int contador = 0;
                long resultado = 0;

                while (worksheet.LastRowUsed().RowNumber() >= contador)
                {
                    if (contador >0)
                    {
                        var row = worksheet.Row(contador);
                        if (row.Cell(2).IsEmpty() || row.Cell(2).Value == null)
                            break;
                        EnvioEmail carga = new EnvioEmail();
                        carga.correo = row.Cell(2).GetValue<string>();
                        carga.UsuarioCreacion = envioemail.UsuarioRegistro;
                        carga.Estado = 1;
                        string url = null;
                        resultado = EnvioEmailBL.Instancia.Add(url);
                 
                        if (resultado <= 0)
                        {
                            jsonResponse.Title = Title.TitleAlerta;
                            jsonResponse.Warning = true;
                            jsonResponse.Message = Mensajes.RegistroFallido;
                            break;
                        }
                        else
                        {
                            jsonResponse.Title = Title.TitleRegistro;
                            jsonResponse.Message = Mensajes.RegistroSatisfactorio;
                        }
                    }
                    contador++;
                }

                LogBL.Instancia.Add(new Log
                {
                    Accion = Mensajes.Upload,
                    Controlador = Mensajes.EnvioEmailController,
                    Identificador = Convert.ToInt32(resultado),
                    Mensaje = jsonResponse.Message,
                    Usuario = envioemail.UsuarioRegistro,
                    Objeto = JsonConvert.SerializeObject(new EnvioEmailDTO { correo = envioemail.correo, UsuarioRegistro = envioemail.UsuarioRegistro })
                });
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
                LogBL.Instancia.Add(new Log
                {
                    Accion = Mensajes.Upload,
                    Controlador = Mensajes.EnvioEmailController,
                    Identificador = 0,
                    Mensaje = ex.Message,
                    Usuario = envioemail.UsuarioRegistro,
                    Objeto = JsonConvert.SerializeObject(new EnvioEmailDTO { correo = envioemail.correo, UsuarioRegistro = envioemail.UsuarioRegistro })
                });
            }

            return jsonResponse;
        }
    }

    
} 
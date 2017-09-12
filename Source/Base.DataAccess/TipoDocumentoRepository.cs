﻿using Base.BusinessEntity;
using Base.Common;
using Base.Common.Generics;
using Base.DataAccess.Core;
using Base.DataAccess.Interfaces;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Collections.Generic;
using System.Data;

namespace Base.DataAccess
{
    public class TipoDocumentoRepository : Singleton<TipoDocumentoRepository>, ITipoDocumentoRepository<TipoDocumento, int>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSQL);

        #endregion
        #region Métodos Públicos
        public IList<TipoDocumento> GetAllPaging(PaginationParameter<int> paginationParameters)
        {
            List<TipoDocumento> tipodocumento = new List<TipoDocumento>();
            using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "SGE_TIPO_DOCUMENTO_GetAllFilter")))
            {
                _database.AddInParameter(comando, "@WhereFilters", DbType.String, string.IsNullOrWhiteSpace(paginationParameters.WhereFilter) ? string.Empty : paginationParameters.WhereFilter);
                _database.AddInParameter(comando, "@OrderBy", DbType.String, string.IsNullOrWhiteSpace(paginationParameters.OrderBy) ? string.Empty : paginationParameters.OrderBy);
                _database.AddInParameter(comando, "@Start", DbType.Int32, paginationParameters.Start);
                _database.AddInParameter(comando, "@Rows", DbType.Int32, paginationParameters.AmountRows);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        tipodocumento.Add(new TipoDocumento
                        {
                            Id = lector.IsDBNull(lector.GetOrdinal("Id")) ? default(int) : lector.GetInt32(lector.GetOrdinal("Id")),
                            tdocc_vabreviatura_tipo_doc= lector.IsDBNull(lector.GetOrdinal("tdocc_vabreviatura_tipo_doc")) ? default(string) : lector.GetString(lector.GetOrdinal("tdocc_vabreviatura_tipo_doc")),
                            tdocc_vdescripcion = lector.IsDBNull(lector.GetOrdinal("tdocc_vdescripcion")) ? default(string) : lector.GetString(lector.GetOrdinal("tdocc_vdescripcion")),
                            Estado = lector.IsDBNull(lector.GetOrdinal("tdocc_flag_estado")) ? default(int) : lector.GetInt32(lector.GetOrdinal("tdocc_flag_estado")),
                            Cantidad = lector.IsDBNull(lector.GetOrdinal("Cantidad")) ? default(int) : lector.GetInt32(lector.GetOrdinal("Cantidad"))
                        });
                    }
                }
            }

            return tipodocumento;
        }
        #endregion
    }
}

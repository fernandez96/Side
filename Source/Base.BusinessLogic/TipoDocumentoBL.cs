using Base.BusinessEntity;
using Base.BusinessLogic.Interfaces;
using Base.Common;
using Base.Common.Generics;
using Base.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Base.BusinessLogic
{
    public class TipoDocumentoBL: Singleton<TipoDocumentoBL>, ITipoDocumentoBL<TipoDocumento, int>
    {
        public IList<TipoDocumento> GetAllPaging(PaginationParameter<int> paginationParameters)
        {
            return TipoDocumentoRepository.Instancia.GetAllPaging(paginationParameters);
        }
    }
}

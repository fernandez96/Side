using Base.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Base.BusinessLogic.Interfaces
{
  public  interface ITipoDocumentoBL <T,Q> where T: class 
    {
        Q Add(T entity);
        IList<T> GetAllPaging(PaginationParameter<Q> paginationParameters);
    }
}

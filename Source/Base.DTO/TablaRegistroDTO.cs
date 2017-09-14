using Base.DTO.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Base.DTO
{
   public class TablaRegistroDTO: EntityAuditableDTO<int>
    {
        //Cabezera
        public string tbpc_vcod_tabla_opciones { get; set; }
        public string tbpc_vdescripcion { get; set; }

        //detalle
        public string tbpd_vcod_tabla_opciones_det { get; set; }
        public string tbpd_vdescripcion_detalle { get; set; }
    }
}

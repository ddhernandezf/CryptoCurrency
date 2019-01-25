using System;
using System.Collections.Generic;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CMenu
    {
        public byte Menu { get; set; }
        public string Descripcion { get; set; }
        public string Accion { get; set; }
        public string Controlador { get; set; }
        public string imageUrl { get; set; }

        public String text
        {
            get
            {
                return Descripcion;
            }
            set { }
        }

        public String url { get; set; }

        public List<CMenu> items { get; set; }
    }
}

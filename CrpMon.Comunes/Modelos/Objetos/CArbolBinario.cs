using System.Collections.Generic;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CArbolBinario
    {
        public string nombres { get; set; }
        public string monto { get; set; }
        public string image { get; set; }
        public string estado { get; set; }
        public string producto { get; set; }
        public string monto_diario_L { get; set; }
        public string monto_diario_R { get; set; }
        public string monto_acumulado_L { get; set; }
        public string monto_acumulado_R { get; set; }
        public string monto_directo_L { get; set; }
        public string monto_directo_R { get; set; }
        public List<CArbolBinario> items { get; set; }
    }
}

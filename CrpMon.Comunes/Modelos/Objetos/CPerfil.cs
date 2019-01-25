using CrpMon.Comunes.Modelos.Vistas;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CPerfil
    {
        public CPersona persona { get; set; }
        public CCambioPassword cambiarpassword { get; set; }
        public CCambioPerfil cambiarperfil { get; set; }
        public CProducto producto { get; set; }
    }
}

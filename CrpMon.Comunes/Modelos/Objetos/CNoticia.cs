namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CNoticia
    {
        public int IdNotificacion { get; set; }
        public byte Estado { get; set; }
        public string NombreEstado { get; set; }
        public string Titulo { get; set; }
        public string Contenido { get; set; }
        public System.DateTime FechaInicio { get; set; }
        public System.DateTime FechaFin { get; set; }
        public string FechaMostar
        {
            get
            {
                return FechaInicio.ToString("dd/MM/yyyy");
            }
            set { }
        }
    }
}

namespace CrpMon.Comunes.Modelos
{
    public class CCoinPaymentResult
    {
        public string amount { get; set; }
        public string address { get; set; }
        public string txn_id { get; set; }
        public string confirms_needed { get; set; }
        public long timeout { get; set; }
        public string status_url { get; set; }
        public string qrcode_url { get; set; }
    }
}

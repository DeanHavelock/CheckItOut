namespace CheckItOut.Ui.Web.ConfigurationOptions
{
    public class CheckItOutQueryApiHttpOptions
    {
        public static string CheckItOutQueryApi => "CheckItOutQueryApiHttp";
        public string BaseUrl { get; set; }
        public string PaymentsEndpoint { get; set; }
    }
}

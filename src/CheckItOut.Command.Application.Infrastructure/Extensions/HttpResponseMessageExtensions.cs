using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace CheckItOut.Command.Application.Infrastructure.Extensions
{
    public static class HttpResponseMessageExtensions
    {
        public static async Task<TResponseType> Content<TResponseType>(this HttpResponseMessage httpResponseMessage)
        {
            var jsonResponseContent = await httpResponseMessage.Content.ReadAsStringAsync();
            var checkoutPaymentResponse = JsonConvert.DeserializeObject<TResponseType>(jsonResponseContent);
            return checkoutPaymentResponse;
        }
    }
}
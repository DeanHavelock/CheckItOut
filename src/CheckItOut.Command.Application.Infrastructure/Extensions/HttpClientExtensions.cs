using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace CheckItOut.Command.Application.Infrastructure.Extensions
{
    public static class HttpClientExtensions
    {
        /// <summary>
        /// SendAsync Extension - Sends a Strongly Typed Request, Converted to Json and Added to the HttpResponseMessage Body
        /// </summary>
        /// <typeparam name="TRequestType"></typeparam>
        /// <param name="httpClient"></param>
        /// <param name="url"></param>
        /// <param name="httpMethod"></param>
        /// <param name="messageContent"></param>
        /// <param name="authorizationHeaderKey"></param>
        /// <returns></returns>
        public static async Task<HttpResponseMessage> SendAsync<TRequestType>(this HttpClient httpClient, string url, HttpMethod httpMethod, TRequestType messageContent, string authorizationHeaderKey = "blankAuthHeader")
        {
            var httpRequestMessage = new HttpRequestMessage()
            {
                RequestUri = new Uri(url),
                Method = httpMethod,
                Content = new StringContent(JsonConvert.SerializeObject(messageContent), System.Text.Encoding.UTF8, "application/json"),
                Headers =
                {
                    {"Authorization", authorizationHeaderKey}
                }
            };

            var response = await httpClient.SendAsync(httpRequestMessage);
            return response;
            //var responseContent = await response.Content<TResponseType>();
            //return responseContent;
        }
    }
}

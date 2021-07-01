using System;
using System.Net.Http;
using Newtonsoft.Json;

namespace CheckItOut.Command.Application.Infrastructure.Extensions
{
    public static class HttpRequestMessageExtensions
    {
        public static HttpRequestMessage Create<T>(this HttpRequestMessage httpRequestMessage, string url, HttpMethod httpMethod, T content, string authorizationHeaderKey = "") where T : class
        {
            return new HttpRequestMessage()
            {
                
                RequestUri = new Uri(url),
                Method = httpMethod,
                Content = new StringContent(JsonConvert.SerializeObject(content), System.Text.Encoding.UTF8, "application/json"),
                Headers = 
                {
                    {"Authorization", authorizationHeaderKey}
                }
            };
        }
    }
}

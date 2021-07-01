using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using CheckItOut.Domain;
using CheckItOut.Domain.External.Persistence.EventSourcing;
using JsonSerializer = System.Text.Json.JsonSerializer;

namespace CheckItOut.Command.Application.Infrastructure.Persistence.EventSourcing.Eventstore
{
    public class EventSourcingAppenderAdapter : IEventSourcingAppenderAdapter
    {
        private readonly HttpClient _httpClient;

        public EventSourcingAppenderAdapter(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task Append<T>(T @event) where T : DomainEvent
        {
            var request = new HttpRequestMessage(HttpMethod.Post, "http://localhost:2113/streams/mydocument")
            {
                Content = new StringContent(JsonSerializer.Serialize(@event), Encoding.UTF8,
                    "application/json"),
                Headers =
                {
                    {"ES-EventType",typeof(T).FullName},
                    {"ES-EventId", Guid.NewGuid().ToString()}
                }
            };
            
            var response = await _httpClient.SendAsync(request);
        }
    }

    //internal class DomainEvent<T>
    //{
    //    public T Data { get; set; }
    //}
}

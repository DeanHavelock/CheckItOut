using CheckItOut.Domain;
using CheckItOut.Domain.External.Persistence.EventSourcing;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace CheckItOut.Query.Application.Infrastructure.Persistence.EventSourcing.Eventstore
{
    public class EventSourcingQueryAdapter : IEventSourcingQueryAdapter
    {
        private readonly HttpClient _httpClient;
        private readonly IEventSerializer _eventSerializer;

        public EventSourcingQueryAdapter(HttpClient httpClient, IEventSerializer eventSerializer)
        {
            _httpClient = httpClient;
            _eventSerializer = eventSerializer;
        }

        public async Task<IEnumerable<DomainEvent>> GetAll()
        {
            var request = new HttpRequestMessage(HttpMethod.Get, "http://localhost:2113/streams/mydocument")
            {
                Headers =
                {
                    {"Accept", "application/vnd.eventstore.atom+json"}
                }
            };
            var response = await _httpClient.SendAsync(request);

            var responseStringContent = await response.Content.ReadAsStringAsync();

            var deserializedResponse = System.Text.Json.JsonSerializer.Deserialize<GetStreamResponse>(responseStringContent);

            List<DomainEvent> domainEvents = new List<DomainEvent>();

            foreach (var entry in deserializedResponse.entries)
            {
                var selfLinkData = await GetSelfLinkData(entry);
                domainEvents.Add(selfLinkData);
            }

            return domainEvents;
        }

        public async Task<DomainEvent> GetSelfLinkData(Entry entry)
        {
            var link = entry.links.First(x => x.relation == "self" || x.relation == "alternate" || x.relation == "edit").uri;
            var request = new HttpRequestMessage(HttpMethod.Get, link)
            {
                Headers =
                {
                    {"Accept", "application/vnd.eventstore.atom+json"}
                }
            };
            var response = await _httpClient.SendAsync(request);

            var responseStringContent = await response.Content.ReadAsStringAsync();

            var deserializedResponse = System.Text.Json.JsonSerializer.Deserialize<GetStreamItemResponse>(responseStringContent);

            var serializedData = System.Text.Json.JsonSerializer.Serialize(deserializedResponse.content.data);
            
            var domainEvent = _eventSerializer.Deserialize(entry.summary, serializedData);

            return (DomainEvent)domainEvent;

        }
    }
}

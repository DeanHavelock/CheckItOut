using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;

namespace CheckItOut.Query.Application.Infrastructure.Persistence.EventSourcing.Eventstore
{
    // Root myDeserializedClass = JsonConvert.DeserializeObject<Root>(myJsonResponse); 
    //public class Data
    //{
    //    public string CardId { get; set; }
    //    public string CardNumber { get; set; }
    //    public DateTime OccurredOn { get; set; }
    //}

    public class Content
    {
        public string eventStreamId { get; set; }
        public int eventNumber { get; set; }
        public string eventType { get; set; }
        public string eventId { get; set; }
        public object data { get; set; }
        public string metadata { get; set; }
    }

    public class GetStreamItemResponse
    {
        public string title { get; set; }
        public string id { get; set; }
        public DateTime updated { get; set; }
        public Author author { get; set; }
        public string summary { get; set; }
        public Content content { get; set; }
        public List<Link> links { get; set; }
    }




}

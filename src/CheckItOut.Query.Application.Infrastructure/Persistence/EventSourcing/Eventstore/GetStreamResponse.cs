using System;
using System.Collections.Generic;
using System.Text;

namespace CheckItOut.Query.Application.Infrastructure.Persistence.EventSourcing.Eventstore
{
    // Root myDeserializedClass = JsonConvert.DeserializeObject<Root>(myJsonResponse); 
    public class Author
    {
        public string name { get; set; }
    }

    public class Link
    {
        public string uri { get; set; }
        public string relation { get; set; }
    }

    public class Entry
    {
        public string title { get; set; }
        public string id { get; set; }
        public DateTime updated { get; set; }
        public Author author { get; set; }
        public string summary { get; set; }
        public List<Link> links { get; set; }
    }

    public class GetStreamResponse
    {
        public string title { get; set; }
        public string id { get; set; }
        public DateTime updated { get; set; }
        public string streamId { get; set; }
        public Author author { get; set; }
        public bool headOfStream { get; set; }
        public string selfUrl { get; set; }
        public string eTag { get; set; }
        public List<Link> links { get; set; }
        public List<Entry> entries { get; set; }
    }


}

namespace CheckItOut.Domain
{
    public class SomeAggregateRoot
    {
        public SomeAggregateRoot(string id)
        {
            Id = id;
        }

        public string Id { get; set; }
        public string SomeValue { get; set; }
    }
}

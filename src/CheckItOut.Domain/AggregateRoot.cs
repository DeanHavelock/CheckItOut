namespace CheckItOut.Domain
{
    public class AggregateRoot
    {
        public AggregateRoot(string id)
        {
            Id = id;
        }

        public string Id { get; set; }
    }
}

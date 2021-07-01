namespace CheckItOut.Domain.External.Persistence.EventSourcing
{
    public interface IEventSerializer
    {
        DomainEvent Deserialize(string type, string data);
    }
}

using System.Threading.Tasks;

namespace CheckItOut.Domain.External.Persistence.EventSourcing
{
    public interface IEventSourcingAppenderAdapter
    {
        Task Append<T>(T domainEvent) where T : DomainEvent;
    }
}

using System.Collections.Generic;
using System.Threading.Tasks;

namespace CheckItOut.Domain.External.Persistence.EventSourcing
{
    public interface IEventSourcingQueryAdapter
    {

        Task<IEnumerable<DomainEvent>> GetAll();
    }
}

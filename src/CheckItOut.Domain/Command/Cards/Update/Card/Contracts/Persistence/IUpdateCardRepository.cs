using System.Threading.Tasks;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate;

namespace CheckItOut.Domain.Command.Cards.Update.Card.Contracts.Persistence
{
    public interface IUpdateCardRepository
    {
        Task Save(UpdateCardAggregate aggregate);
    }
}

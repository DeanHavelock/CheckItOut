using System.Threading.Tasks;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate;
using CheckItOut.Domain.Command.Cards.Update.Card.Contracts.Persistence;

namespace CheckItOut.Command.Application.Infrastructure.Persistence.EntityFramework.Cards.Update.Card
{
    public class UpdateCardRepository : IUpdateCardRepository
    {
        public async Task Save(UpdateCardAggregate aggregate)
        {
            DbContext.Cards.Add(new Domain.Command.Cards.Update.CardWithCustomer.Card());/*aggregate.CardEntityQuestionmark*/;
            await DbContext.SaveChanges();
        }
    }
}

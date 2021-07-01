using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Persistence;

namespace CheckItOut.Command.Application.Infrastructure.Persistence.InMemory.Cards.Update.CardWithCustomer
{
    public class UpdateCardWithCustomerRepository : IUpdateCardWithCustomerRepository
    {
        public void Save(UpdateCardWithCustomerAggregate aggregate)
        {
            throw new System.NotImplementedException();
        }
    }
}

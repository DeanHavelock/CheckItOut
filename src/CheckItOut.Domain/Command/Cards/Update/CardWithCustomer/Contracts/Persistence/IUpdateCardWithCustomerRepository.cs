using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate;

namespace CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Persistence
{
    public interface IUpdateCardWithCustomerRepository
    {
        void Save(UpdateCardWithCustomerAggregate aggregate);
    }
}

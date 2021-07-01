using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate.Commands;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Queries;

namespace CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate
{
    public class UpdateCardWithCustomerAggregate
    {
        public Card Card;
        public Customer Customer;
        private IQueryCardWithCustomerAdapter _fgerwfe;

        public UpdateCardWithCustomerAggregate(IQueryCardWithCustomerAdapter fefe)
        {
            _fgerwfe = fefe;
        }

        private UpdateCardWithCustomerAggregate(){}

        public static UpdateCardWithCustomerAggregate FromExisting(CardWithCustomerQueryResponseDto cardWithCustomer)
        {
            return new UpdateCardWithCustomerAggregate()
            {
                Card = new Card(){ Id = cardWithCustomer.CustomerId, CardNumber = cardWithCustomer.CardNumber },
                Customer = new Customer(){ Id = cardWithCustomer.CustomerId, Name = cardWithCustomer.CustomerName }
            };
        }

        public void Update(UpdateCardWithCustomerCommand command)
        {
            Card.CardNumber = command.CardNumber;
            Customer.Name = command.CustomerName;

        }
    }
}

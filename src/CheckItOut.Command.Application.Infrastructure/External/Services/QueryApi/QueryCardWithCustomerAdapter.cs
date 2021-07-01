using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Queries;

namespace CheckItOut.Command.Application.Infrastructure.External.Services.QueryApi
{
    public class QueryCardWithCustomerAdapter : IQueryCardWithCustomerAdapter
    {
        public CardWithCustomerQueryResponseDto GetBy(string commandCardId, string commandCustomerId)
        {
            return new CardWithCustomerQueryResponseDto()
            {
                CardId = commandCardId,
                CardNumber = "1212121212121212",
                CustomerId = commandCustomerId,
                CustomerName = "bertrand meyer"
            };
        }
    }
}

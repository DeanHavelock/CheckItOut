namespace CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Queries
{
    public interface IQueryCardWithCustomerAdapter
    {
        CardWithCustomerQueryResponseDto GetBy(string commandCardId, string commandCustomerId);
    }
}

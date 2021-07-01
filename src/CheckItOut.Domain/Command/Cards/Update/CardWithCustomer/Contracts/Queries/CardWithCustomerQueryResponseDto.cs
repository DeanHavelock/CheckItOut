namespace CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Queries
{
    public class CardWithCustomerQueryResponseDto
    {
        public string CardId { get; set; }
        public string CardNumber { get; set; }
        public string CustomerId { get; set; }
        public string CustomerName { get; set; }
    }
}
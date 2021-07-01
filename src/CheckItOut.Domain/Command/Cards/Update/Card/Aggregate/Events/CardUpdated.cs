namespace CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Events
{
    public class CardUpdated : DomainEvent
    {
        public string CardId { get; set; }
        public string CardNumber { get; set; }
    }
}

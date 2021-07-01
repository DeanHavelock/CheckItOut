using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Events;

namespace CheckItOut.Domain.Query.Cards.Get
{
    public class CardProjection
    {
        public string CardId { get; set; }
        public string CardNumber { get; set; }

        public static CardProjection From(CardUpdated notification)
        {
            return new CardProjection {CardId = notification.CardId, CardNumber = notification.CardNumber};
        }
    }
}

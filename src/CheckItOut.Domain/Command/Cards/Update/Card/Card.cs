using CheckItOut.Domain.Query.Cards.Get;

namespace CheckItOut.Domain.Command.Cards.Update.Card
{
    public class Card
    {
        public static Card From(CardProjection projection)
        {
            return new Card(){Id = projection.CardId, CardNumber = projection.CardNumber};
        }

        public string Id { get; set; }

        public void Update(string cardNumber)
        {
            CardNumber = cardNumber;
        }

        public string CardNumber { get; set; }
    }
}

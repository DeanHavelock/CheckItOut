using System;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Commands;
using CheckItOut.Domain.Query.Cards.Get;

namespace CheckItOut.Domain.Command.Cards.Update.Card.Aggregate
{
    public class UpdateCardAggregate
    {
        public Card Card { get; set; }

        public static UpdateCardAggregate FromExistingCard(CardProjection cardProjection) 
        { 
            if(cardProjection == null)
                throw new ArgumentNullException("card does not exist");
            
            return new UpdateCardAggregate(){ Card = new Card() { Id = cardProjection.CardId, CardNumber = cardProjection.CardNumber } };
        }

        public void UpdateCard(UpdateCardCommand command)
        {
            Card.Update(command.CardNumber);;
        }
    }
}

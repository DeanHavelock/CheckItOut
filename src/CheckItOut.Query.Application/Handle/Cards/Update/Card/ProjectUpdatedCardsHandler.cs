using System.Threading;
using System.Threading.Tasks;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Events;
using CheckItOut.Domain.Query.Cards.Get;
using MediatR;

namespace CheckItOut.Query.Application.Handle.Cards.Update.Card
{
    public class ProjectUpdatedCardsHandler : INotificationHandler<CardUpdated>
    {
        private IQueryCard _queryCard;

        public ProjectUpdatedCardsHandler(IQueryCard queryCard)
        {
            _queryCard = queryCard;
        }

        public async Task Handle(CardUpdated notification, CancellationToken cancellationToken)
        {
            var projection = CardProjection.From(notification);

            await _queryCard.Store(projection);

            await _queryCard.ById(notification.CardId);
        }
    }
}


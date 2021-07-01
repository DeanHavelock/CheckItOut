using System.Threading;
using System.Threading.Tasks;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Events;
using MediatR;

namespace CheckItOut.Query.Application.Handle.Cards.Update.Card
{
    public class ProjectExpiringCardsHandler : INotificationHandler<CardUpdated>
    {
        public async Task Handle(CardUpdated notification, CancellationToken cancellationToken)
        {
            var pass = true;
        }
    }
}

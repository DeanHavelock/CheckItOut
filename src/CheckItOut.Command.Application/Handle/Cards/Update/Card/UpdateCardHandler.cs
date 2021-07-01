using System;
using System.Threading;
using System.Threading.Tasks;
using CheckItOut.Domain.Command;
using CheckItOut.Domain.Command.Cards.Update.Card.Adapters;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Commands;
using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Events;
using CheckItOut.Domain.Command.Cards.Update.Card.Contracts.Persistence;
using CheckItOut.Domain.External.Persistence.EventSourcing;
using CheckItOut.Domain.Query.Cards.Get;
using MediatR;

namespace CheckItOut.Command.Application.Handle.Cards.Update.Card
{
    using Card = Domain.Command.Cards.Update.Card.Card;

    public class UpdateCardHandler : IRequestHandler<UpdateCardCommand, object>
    {
        private readonly IQueryCardAdapter _queryCard; // available store (eventually consistent current state projections store)
        private readonly IEventSourcingAppenderAdapter _eventSourcingAppenderAdapter; // write store (source of truth)
        private readonly IUpdateCardRepository _updateCardRepository; // write + read store (consistent current state store)

        public UpdateCardHandler(IUpdateCardRepository updateCardRepository, IQueryCardAdapter queryCard, IEventSourcingAppenderAdapter eventSourcingAppenderAdapter)
        {
            _updateCardRepository = updateCardRepository;
            _queryCard = queryCard;
            _eventSourcingAppenderAdapter = eventSourcingAppenderAdapter;
        }

        public async Task<object> Handle(UpdateCardCommand command, CancellationToken cancellationToken)
        {
            var projectionResponse = await _queryCard.ById(command.CardId);//there has to be data in the write model that is current (Not eventually consistent so that business logic is working off of current and valid data), or compensating actions.

            UpdateCardAggregate aggregate = UpdateCardAggregate.FromExistingCard(projectionResponse);

            aggregate.UpdateCard(command);

            await _eventSourcingAppenderAdapter.Append(new CardUpdated {OccurredOn = DateTime.UtcNow, CardId = command.CardId, CardNumber = command.CardNumber});

            //_updateCardRepository.Save(aggregate);//ToDo: we won't have a consistent database, we have an event sourced datastore and available store (eventually consistent projections)

            //_mediatR.Send(new CardUpdatedEvent(){x="",y="",z=""});

            return command.CardId;
        }
    }
}

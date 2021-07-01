using System.Threading;
using System.Threading.Tasks;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate.Commands;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Persistence;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Queries;
using MediatR;

namespace CheckItOut.Command.Application.Handle.Cards.Update.CardWithCustomer
{
    public class UpdateCardWithCustomerHandler : IRequestHandler<UpdateCardWithCustomerCommand, object>
    {
        private readonly IQueryCardWithCustomerAdapter _queryCardWithCustomer;
        private readonly IUpdateCardWithCustomerRepository _repository;

        public UpdateCardWithCustomerHandler(IUpdateCardWithCustomerRepository repository, IQueryCardWithCustomerAdapter queryCardWithCustomer)
        {
            _repository = repository;
            _queryCardWithCustomer = queryCardWithCustomer;
        }

        public Task<object> Handle(UpdateCardWithCustomerCommand command, CancellationToken cancellationToken)
        {
            CardWithCustomerQueryResponseDto cardWithCustomer = _queryCardWithCustomer.GetBy(command.CardId, command.CustomerId);

            var aggregate = UpdateCardWithCustomerAggregate.FromExisting(cardWithCustomer);

            aggregate.Update(command);

            //_repository.Save(aggregate);//ToDo: we won't have a consistent database, we will have an event sourced datastore and available store (eventually consistent projections)

            //_mediatR.Send(new CardWithCustomerUpdatedEvent(){x="",y="",z=""});

            return new Task<object>(() => command.CardId);
        }
    }
}

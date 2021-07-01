using CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Commands;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate.Commands;
using CheckItOut.Domain.External.CheckItOut.Ui.Web;
using MediatR;

namespace CheckItOut.Domain
{
    public class ApplicationCommand : IRequest<object>
    {
        public static ApplicationCommand FromRequest(UpdateCardDto request)
        {
            if(string.IsNullOrWhiteSpace(request.CustomerId))
                return UpdateCardCommand.FromRequest(request);
            return UpdateCardWithCustomerCommand.FromRequest(request);
        }
    }
}
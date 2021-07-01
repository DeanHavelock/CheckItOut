using CheckItOut.Domain.External.CheckItOut.Ui.Web;

namespace CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Aggregate.Commands
{
    public class UpdateCardWithCustomerCommand : ApplicationCommand
    {
        public static UpdateCardWithCustomerCommand FromRequest(UpdateCardDto request) 
            => new UpdateCardWithCustomerCommand(){ CardId = request.CardId, CardNumber = request.CardNumber, CustomerId = request.CustomerId, CustomerName = request.CustomerName };

        public string CardId { get; set; }
        public string CardNumber { get; set; }
        public string CustomerId { get; set; }
        public string CustomerName { get; set; }
    }
}
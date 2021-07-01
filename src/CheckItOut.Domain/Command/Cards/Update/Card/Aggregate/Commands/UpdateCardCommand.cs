using CheckItOut.Domain.External.CheckItOut.Ui.Web;

namespace CheckItOut.Domain.Command.Cards.Update.Card.Aggregate.Commands
{
    public class UpdateCardCommand : ApplicationCommand
    {
        public static UpdateCardCommand FromRequest(UpdateCardDto request) => new UpdateCardCommand() {CardId = request.CardId, CardNumber = request.CardNumber};

        public string CardId { get; set; }
        public string CardNumber { get; set; }
    }
}
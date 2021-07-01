namespace CheckItOut.Domain.External.CheckItOut.Ui.Web
{
    //ToDo: This does not belong in the domain, it is a consequence of mapping the command.MapFrom(request).
    // likely the command should be an application command defined within the application
    // likely the aggregate should not apply a command and should instead apply a domain event
    public class UpdateCardDto
    {
        public string CardId { get; set; }
        public string CardNumber { get; set; }
        public string CustomerId { get; set; }
        public string CustomerName { get; set; }
    }
}
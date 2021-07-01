using System;
using System.Threading.Tasks;
using CheckItOut.Domain;
using CheckItOut.Domain.External.CheckItOut.Ui.Web;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace CheckItOut.Ui.Web.Controllers
{
    public class CardsController : Controller
    {
        private readonly IMediator _mediator;

        public CardsController(IMediator mediator)
        {
            _mediator = mediator;
        }

        public async Task<IActionResult> Update(/*UpdateCardDto request*/)
        {
            UpdateCardDto request = new UpdateCardDto()
            {
                CardId = "3a732400-0672-4f88-8e4f-558f3f34b064",
                CardNumber = "424242424242424242",
               // CustomerId = Guid.NewGuid().ToString(),
               // CustomerName = Guid.NewGuid().ToString()
            };

            
            var command = ApplicationCommand.FromRequest(request);

            await _mediator.Send(command);
            
            return View("Success");
        }

        public IActionResult Success()
        {
            return View("Success");
        }
        
    }
}

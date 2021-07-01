using System.Threading.Tasks;
using CheckItOut.Domain.Query.Cards.Get;
using Microsoft.AspNetCore.Mvc;

namespace CheckItOut.Query.Application.Api.Http.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CardsController : ControllerBase
    {
        private IQueryCard _queryCard;

        public CardsController(IQueryCard queryCard)
        {
            _queryCard = queryCard;
        }

        [HttpGet]
        [Route("{id}")]
        public async Task<IActionResult> Get(/*[FromBody]*/string id)
        {
            if (id == null)
                return NotFound("No idea valid");
            var cardProjection = await _queryCard.ById(id);
            return Ok(cardProjection);

            //return AcceptedResult("https://fjeifjeijf.com/payments", cardProjection);
            //string userId = "1235";
            //var result = "result";//new GetPaymentService().GetPayment(userId);
            //return AcceptedResult("https://fjeifjeijf.com/payments/fejifjei", result);
        }
    }
}

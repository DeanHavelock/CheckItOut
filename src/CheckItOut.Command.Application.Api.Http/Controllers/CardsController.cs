using Microsoft.AspNetCore.Mvc;

namespace CheckItOut.Command.Application.Api.Http.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CardsController : ControllerBase
    {
        [HttpPost]
        [Route("payment")]
        public IActionResult PostPayments()
        {
            string userId = "1235";
            var result = "response";
            return new AcceptedResult("https://fjeifjeijf.com/payments/fejifjei", result);
        }

        [HttpPost]
        [Route("payment/success")]
        public IActionResult SuccessCallback()
        {
            string userId = "1235";
            var result = "response";
            return new AcceptedResult("https://fjeifjeijf.com/payments/fejifjei", result);
        }
    }
}

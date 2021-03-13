using Microsoft.AspNetCore.Mvc;
using CheckItOut.Application.QueryHandlers;

namespace CheckItOut.Query.Api.Http.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentsController : ControllerBase
    {
        [HttpGet]
        //[Route("payments","payments",0)]
        public IActionResult GetPayments()
        {
            string userId = "1235";
            var result =  new GetPaymentService().GetPayment(userId);
            return new AcceptedResult("https://fjeifjeijf.com/payments/fejifjei", result);
        }
    }
}

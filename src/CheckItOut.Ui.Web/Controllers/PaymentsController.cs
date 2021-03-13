using System.Net.Http;
using System.Threading.Tasks;
using CheckItOut.Ui.Web.ConfigurationOptions;
using CheckItOut.Ui.Web.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace CheckItOut.Ui.Web.Controllers
{
    public class PaymentsController : Controller
    {
        private readonly ILogger<PaymentsController> _logger;
        private readonly IOptions<CheckItOutQueryApiHttpOptions> _checkItOutQueryApiOptions;

        public PaymentsController(ILogger<PaymentsController> logger, IOptions<CheckItOutQueryApiHttpOptions> checkItOutQueryApiOptions)
        {
            _checkItOutQueryApiOptions = checkItOutQueryApiOptions;
            _logger = logger;
        }

        public async Task<IActionResult> Index()
        {
            var url = _checkItOutQueryApiOptions.Value.GetPaymentsUrl;
            HttpClient httpClient = new HttpClient();
            var responseMessage = await httpClient.GetAsync(url);
            var content = await responseMessage.Content.ReadAsStringAsync();

            return View(new GetPaymentViewModel(){Id = content, Amount = "100"});
        }
    }
}

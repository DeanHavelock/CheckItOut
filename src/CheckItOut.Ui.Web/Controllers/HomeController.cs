using CheckItOut.Ui.Web.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Diagnostics;
using CheckItOut.Ui.Web.ConfigurationOptions;
using Microsoft.Extensions.Options;

namespace CheckItOut.Ui.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IOptions<CheckItOutQueryApiHttpOptions> _queryApiOptions;

        public HomeController(ILogger<HomeController> logger, IOptions<CheckItOutQueryApiHttpOptions> queryApiOptions)
        {
            _queryApiOptions = queryApiOptions;
            _logger = logger;
        }

        public IActionResult Index()
        {
            //var abc = _queryApiOptions.Value.GetPaymentsUrl;
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

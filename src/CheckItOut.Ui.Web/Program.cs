using System;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

namespace CheckItOut.Ui.Web
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {                    
                    //webBuilder.UseKestrel();
                    //webBuilder.ConfigureKestrel(x => x.AddServerHeader = false);
                    //webBuilder.UseContentRoot(Directory.GetCurrentDirectory());
                    webBuilder.ConfigureAppConfiguration((webHostBuilderContext, configurationBuilder) =>
                    {
                        var environmentName = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
                    });

                    webBuilder.UseStartup<Startup>();
                });
    }
}

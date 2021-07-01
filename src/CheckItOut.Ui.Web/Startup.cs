using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System.Reflection;
using CheckItOut.Command.Application.Handle.Cards.Update.Card;
using CheckItOut.Command.Application.Infrastructure.External.Services.QueryApi;
using CheckItOut.Command.Application.Infrastructure.Persistence.EventSourcing.Eventstore;
using CheckItOut.Command.Application.Infrastructure.Persistence.InMemory.Cards.Update.Card;
using CheckItOut.Command.Application.Infrastructure.Persistence.InMemory.Cards.Update.CardWithCustomer;
using CheckItOut.Domain.Command;
using CheckItOut.Domain.Command.Cards.Update.Card.Adapters;
using CheckItOut.Domain.Command.Cards.Update.Card.Contracts.Persistence;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Persistence;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer.Contracts.Queries;
using CheckItOut.Domain.External.Persistence.EventSourcing;
using CheckItOut.Domain.Query.Cards.Get;
using CheckItOut.Ui.Web.ConfigurationOptions;
using MediatR;

namespace CheckItOut.Ui.Web
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //List<Assembly> assemblies = new List<Assembly>(){ typeof(UpdateCardHandler).GetTypeInfo().Assembly, typeof(ApplicationCommand).GetTypeInfo().Assembly };
            //services.AddMediatR(new List<Type>(){ typeof(UpdateCardHandler).GetTypeInfo().Assembly, new };
            services.AddMediatR(typeof(UpdateCardHandler).GetTypeInfo().Assembly);
            
            services.AddControllersWithViews();

            services.AddTransient<IUpdateCardRepository, UpdateCardRepository>();
            services.AddTransient<IQueryCardAdapter, QueryCardAdapter>();

            services.AddTransient<IUpdateCardWithCustomerRepository, UpdateCardWithCustomerRepository>();
            services.AddTransient<IQueryCardWithCustomerAdapter, QueryCardWithCustomerAdapter>();

            services.AddHttpClient<IEventSourcingAppenderAdapter, EventSourcingAppenderAdapter>();
            //services.AddHttpClient();



            SetupConfigurationOptionsFromAppSettings(services);
        }

        private void SetupConfigurationOptionsFromAppSettings(IServiceCollection services)
        {
            services.Configure<CheckItOutQueryApiHttpOptions>(Configuration.GetSection(CheckItOutQueryApiHttpOptions.CheckItOutQueryApi));


        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}

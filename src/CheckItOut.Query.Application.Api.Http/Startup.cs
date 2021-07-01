using Amazon;
using Amazon.DynamoDBv2;
using Amazon.Runtime;
using CheckItOut.Domain.Query.Cards.Get;
using CheckItOut.Query.Application.Infrastructure.Persistence.AvailableStores.DynamoDb;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;

namespace CheckItOut.Query.Application.Api.Http
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

            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "CheckItOut.Command.Application.Api.Http", Version = "v1" });
            });

            //services.AddDefaultAWSOptions(Configuration.GetAWSOptions());
            //services.AddAWSService<IAmazonDynamoDB>(Configuration.GetAWSOptions("DynamoDb"));

            services.AddSingleton<IAmazonDynamoDB>(options =>
            {
                var config = new AmazonDynamoDBConfig
                {
                    RegionEndpoint = RegionEndpoint.EUWest2,
                    ServiceURL = "http://localhost:4569"
                };

                AWSCredentials credentials;

                credentials = new BasicAWSCredentials("accessKey", "secret");
                var client = new AmazonDynamoDBClient(credentials, config);

                return client;
            });

            services.AddTransient<IQueryCard, QueryCardRepository>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "CheckItOut.Command.Application.Api.Http v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}

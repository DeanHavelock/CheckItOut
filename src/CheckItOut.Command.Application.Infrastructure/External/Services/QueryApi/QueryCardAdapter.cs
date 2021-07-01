using System.Net.Http;
using System.Threading.Tasks;
using CheckItOut.Command.Application.Infrastructure.Extensions;
using CheckItOut.Domain.Command;
using CheckItOut.Domain.Command.Cards.Update.Card.Adapters;
using CheckItOut.Domain.Query.Cards.Get;

namespace CheckItOut.Command.Application.Infrastructure.External.Services.QueryApi
{
    public class QueryCardAdapter : IQueryCardAdapter
    {
        public async Task<CardProjection> ById(string commandCardId)
        {
            HttpClient httpClient = new HttpClient();
            var responseMessage = await httpClient.SendAsync<string>("http://localhost:6200/api/Cards/"+commandCardId, HttpMethod.Get, commandCardId);
            var queryResult = await responseMessage.Content<CardProjection>();
            return queryResult;
        }
    }
}

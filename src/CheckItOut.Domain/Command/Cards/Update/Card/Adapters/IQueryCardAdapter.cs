using System.Threading.Tasks;
using CheckItOut.Domain.Query.Cards.Get;

namespace CheckItOut.Domain.Command.Cards.Update.Card.Adapters
{
    public interface IQueryCardAdapter
    {
        Task<CardProjection> ById(string commandCardId);
    }
}
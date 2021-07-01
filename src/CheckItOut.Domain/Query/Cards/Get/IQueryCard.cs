using System.Threading.Tasks;

namespace CheckItOut.Domain.Query.Cards.Get
{
    public interface IQueryCard
    {
        Task<CardProjection> ById(string id);
        Task Store(CardProjection projection);
    }
}

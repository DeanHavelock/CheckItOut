using CheckItOut.Domain;

namespace CheckItOut.Application.QueryHandlers
{
    public class GetPaymentService
    {
        public string GetPayment(string id)
        {
            //var aggregateRoot = repository.getById(id);

            var aggregateRoot = new SomeAggregateRoot(id);
            return aggregateRoot.Id;
        }
    }
}

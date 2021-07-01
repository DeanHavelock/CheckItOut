using System.Collections.Generic;
using System.Threading.Tasks;
using CheckItOut.Domain.Command.Cards.Update.CardWithCustomer;

namespace CheckItOut.Command.Application.Infrastructure.Persistence.EntityFramework
{
    public static class DbContext
    {
        public static List<Card> Cards
        {
            get
            {
                if (Cards == null)
                    return new List<Card>();
                return Cards;
            }
            set
            {
                if(Cards==null)
                    Cards = new List<Card>();
                Cards = value;
            }
        }

        public static List<Customer> Customers
        {
            get
            {
                if (Customers == null)
                    return new List<Customer>();
                return Customers;
            }
            set { Customers = value; }
        }

        public static async Task SaveChanges()
        {
            await Task.CompletedTask;
        }
    }
}

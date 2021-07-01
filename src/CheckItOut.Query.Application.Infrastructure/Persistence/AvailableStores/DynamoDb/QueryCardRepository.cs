using System.Collections.Generic;
using System.Threading.Tasks;
using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.Model;
using CheckItOut.Domain.Query.Cards.Get;

namespace CheckItOut.Query.Application.Infrastructure.Persistence.AvailableStores.DynamoDb
{
    public class QueryCardRepository : IQueryCard
    {
        private readonly IAmazonDynamoDB _amazonDynamoDb;

        public QueryCardRepository(IAmazonDynamoDB amazonDynamoDb)
        {
            _amazonDynamoDb = amazonDynamoDb;
        }

        public async Task<CardProjection> ById(string id)
        {
            var response = await _amazonDynamoDb.GetItemAsync(new GetItemRequest("cards_by_id",
                new Dictionary<string, AttributeValue> {["PK"] = new AttributeValue {S = id}}));
            
            var status = response.HttpStatusCode;

            return new CardProjection
            {
                CardId = id,
                CardNumber = response.Item["CardNumber"].S
            };



            //CardDocument cardDocument = CardDocument.Create(cardToStore);
            //DefaultCardKeyDocument defaultCardKeyDocument = DefaultCardKeyDocument.Create(cardToStore);
            //CardKeyDocument cardKeyDocument = CardKeyDocument.Create(cardToStore);
            //
            ////using (_metrics.TimeIO("dynamodb", _dynamoTableName, "store_card_parallel"))
            ////using (_logger.TimeDebug("Storing card, default card key and card key in DynamoDB"))
            ////{
            //    await InsertIfNotExistsAsync(cardDocument, CardDocument.CreateDocumentType(), cancellationToken);
            //    await InsertIfNotExistsAsync(defaultCardKeyDocument, DefaultCardKeyDocument.CreateDocumentType(), cancellationToken);
            //
            //    // Not currently handling the case where the above documents already exist
            //    // The only downside is that we may have more card keys than necessary
            //    await InsertAsync(cardKeyDocument, CardKeyDocument.CreateDocumentType(), cancellationToken);
            ////}
            //
            //return new CardKey
            //{
            //    VaultId = cardToStore.VaultId,
            //    Fingerprint = cardToStore.Fingerprint
            //};
        }

        public async Task Store(CardProjection projection)
        {
            var response = await _amazonDynamoDb.PutItemAsync(new PutItemRequest("cards_by_id", new Dictionary<string, AttributeValue>() { 
                { "PK", new AttributeValue() { S = projection.CardId } },
                { "CardNumber", new AttributeValue() { S = projection.CardNumber } }
            }));
        }
    }
}

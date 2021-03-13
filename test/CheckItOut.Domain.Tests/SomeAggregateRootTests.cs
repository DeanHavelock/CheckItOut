using System;
using Xunit;

namespace CheckItOut.Domain.Tests
{
    public class SomeAggregateRootTests
    {
        [Fact]
        public void GivenAnId_WhenSetOnAggregate_ReturnsCorrectId()
        {
            string id = "12345";
            
            SomeAggregateRoot aggregateRoot = new SomeAggregateRoot(id);
            
            Assert.True(aggregateRoot.Id == id);
        }
    }
}

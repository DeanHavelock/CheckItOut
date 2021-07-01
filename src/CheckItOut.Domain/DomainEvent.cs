using System;
using MediatR;

namespace CheckItOut.Domain
{
    public class DomainEvent : INotification
    {
        public DomainEvent()
        {
            OccurredOn = DateTimeOffset.UtcNow;
            //EventId = Guid.NewGuid().ToString();
        }

        //public string EventId { get; }
        public DateTimeOffset OccurredOn { get; set; }
    }
}
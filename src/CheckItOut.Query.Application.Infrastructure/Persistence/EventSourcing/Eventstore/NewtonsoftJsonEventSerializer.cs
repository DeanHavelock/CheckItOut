using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using CheckItOut.Domain;
using CheckItOut.Domain.External.Persistence.EventSourcing;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace CheckItOut.Query.Application.Infrastructure.Persistence.EventSourcing.Eventstore
{
    public sealed class NewtonsoftJsonEventSerializer : IEventSerializer
    {
        private readonly IEnumerable<Assembly> _assemblies ;

        private static readonly JsonSerializerSettings JsonSerializerSettings = new JsonSerializerSettings()
        {
            ConstructorHandling = ConstructorHandling.AllowNonPublicDefaultConstructor,
            ContractResolver = new PrivateSetterContractResolver()
        };

        public NewtonsoftJsonEventSerializer(IEnumerable<Assembly> assemblies)
        {
            if(assemblies == null || assemblies.Count() == 0)
                assemblies = new[] { Assembly.GetExecutingAssembly(), typeof(DomainEvent).Assembly };

            _assemblies = assemblies;
        }

        //public DomainEvent Deserialize(string type, byte[] data)
        //{
        //    var jsonData = System.Text.Encoding.UTF8.GetString(data);
        //    return this.Deserialize(type, jsonData);
        //}

        public DomainEvent Deserialize(string type, string data)
        {
            //TODO: cache types
            var eventType = _assemblies.Select(a => a.GetType(type, false))
                                .FirstOrDefault(t => t != null) ?? Type.GetType(type);
            if (null == eventType)
                throw new ArgumentOutOfRangeException(nameof(type), $"invalid event type: {type}");

            // as of 01/10/2020, "Deserialization to reference types without a parameterless constructor isn't supported."
            // https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json-how-to
            // apparently it's being worked on: https://github.com/dotnet/runtime/issues/29895

            var result = Newtonsoft.Json.JsonConvert.DeserializeObject(data, eventType, JsonSerializerSettings);

            return (DomainEvent)result;
        }

        //public byte[] Serialize<TId>(IDomainEvent<TId> domainEvent)
        //{
        //    var json = System.Text.Json.JsonSerializer.Serialize((dynamic)domainEvent);
        //    var data = Encoding.UTF8.GetBytes(json);
        //    return data;
        //}
    }

    /// <summary>
    /// https://www.mking.net/blog/working-with-private-setters-in-json-net
    /// </summary>
    public class PrivateSetterContractResolver : DefaultContractResolver
    {
        protected override JsonProperty CreateProperty(MemberInfo member, MemberSerialization memberSerialization)
        {
            var jsonProperty = base.CreateProperty(member, memberSerialization);
            if (jsonProperty.Writable)
                return jsonProperty;

            if (member is PropertyInfo propertyInfo)
            {
                var setter = propertyInfo.GetSetMethod(true);
                jsonProperty.Writable = setter != null;
            }

            return jsonProperty;
        }
    }

}

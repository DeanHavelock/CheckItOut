

-> CheckItOut.Command.Application.Api.Http
	-> Application (orchestration)
		-> Aggregate.Behaviour(...)
			-> CheckItOut.Query.Application.Api.Http
		-> EventSourceStore.Append(DomainEvent)


-> CheckItOut.Query.Application.BackgroundService (read events from eventstore)
	-> ProjectionFromDomainEventHandler
		-> QueryRepository(.Store, .Update, .Delete)


-> CheckItOut.Query.Application.Api.Http
	-> CardWithCustomerQueryRepository.GetById(...) (Full Projection returned (Pre-calculated into a single get record))
	-> ExpiringCardsRepository.ByMonthYear(...) (Full Projection returned (Pre-calculated into a single get record))



Run The Application:
docker-compose -f docker-compose-infrastructure.yml up --build
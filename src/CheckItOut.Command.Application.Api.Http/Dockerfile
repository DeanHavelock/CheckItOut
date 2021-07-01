#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY ["src/CheckItOut.Command.Application.Api.Http/CheckItOut.Command.Application.Api.Http.csproj", "src/CheckItOut.Command.Application.Api.Http/"]
RUN dotnet restore "src/CheckItOut.Command.Application.Api.Http/CheckItOut.Command.Application.Api.Http.csproj"
COPY . .
WORKDIR "/src/src/CheckItOut.Command.Application.Api.Http"
RUN dotnet build "CheckItOut.Command.Application.Api.Http.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "CheckItOut.Command.Application.Api.Http.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CheckItOut.Command.Application.Api.Http.dll"]
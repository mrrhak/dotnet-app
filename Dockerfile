FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
USER app
WORKDIR /source

# copy csproj and restore as distinct layers
COPY ["dotnet-app/dotnet-app.csproj", "dotnet-app/"]
RUN dotnet restore "./dotnet-app/./dotnet-app.csproj"

# copy everything else and build app
COPY . .
WORKDIR "/source/dotnet-app"
RUN dotnet publish "./dotnet-app.csproj" -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
EXPOSE 8080
WORKDIR /app
COPY --from=build /dotnet-app/app .
ENTRYPOINT ["./dotnet-app"]
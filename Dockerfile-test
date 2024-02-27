FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY dotnet-app/*.csproj ./dotnet-app/
RUN dotnet restore dotnet-app/dotnet-app.csproj

# copy and build app and libraries
COPY dotnet-app/. ./dotnet-app/

# test stage -- exposes optional entrypoint
# target entrypoint with: docker build --target test
FROM build AS unit-test
COPY unit-test/*.csproj ./unit-test/
WORKDIR /source/unit-test
RUN dotnet restore

COPY unit-test/. .
RUN dotnet build --no-restore
ENTRYPOINT ["dotnet", "test", "--logger:trx", "--no-build"]

FROM build AS publish
WORKDIR /source/dotnet-app
RUN dotnet publish -c release --no-restore -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=publish /app ./
# Expose ports
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "dotnet-app.dll"]
# Docker Environment
Make sure start command line at project root.

## 1. Build Image
```sh
docker build . -t dotnet-app
docker build . -t dotnet-app --build-arg=ENVIRONMENT=Staging
```

## 2. Run Image in Container
### 2.1 Run normal using default app color `black`
```sh
docker run -d -p 8080:80 --name dotnet-app-container dotnet-app
```
### 2.2 Run with environment set app color
```sh
docker run -d -p 8080:80 --name dotnet-app-container dotnet-app -e AppSetting:AppColor=red
```

### 3. Unit Test
```sh
docker build --pull --target unit-test -t dotnet-app-unit-test .
docker run --rm dotnet-app-unit-test
# For shared file only
docker run --rm -v ${pwd}/TestResults:/source/unit-test/TestResults dotnet-app-unit-test
```

dotnet dev-certs https -ep ${HOME}/.aspnet/https/dotnet-app.pfx -p password
dotnet dev-certs https --trust

# Rebuild all images
```sh
docker-compose build
```
# Run system
```sh
docker-compose -f "docker-compose.sit.yml" up -d
# or
docker-compose -f "docker-compose.uat.yml" up -d
# or
docker-compose -f "docker-compose.prod.yml" up -d
```
# Stop system
```sh
docker-compose -f "docker-compose.uat.yml" down
```
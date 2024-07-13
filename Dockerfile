# Use the official .NET SDK image from the Microsoft Container Registry for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["HelloWorldApp.csproj", ""]
RUN dotnet restore "./HelloWorldApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "HelloWorldApp.csproj" -c Release -o /app/build
RUN dotnet publish "HelloWorldApp.csproj" -c Release -o /app/publish

# Use the official ASP.NET Core runtime image for running the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]


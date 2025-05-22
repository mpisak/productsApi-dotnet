# Use the official .NET SDK image for building the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["ProductsApi.csproj", "./"]
RUN dotnet restore "./ProductsApi.csproj"
COPY . .
RUN dotnet publish "ProductsApi.csproj" -c Release -o /app/publish

# Use the official ASP.NET runtime image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "ProductsApi.dll"]

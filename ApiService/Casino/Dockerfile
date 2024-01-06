#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 3010

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["Casino/Casino.csproj", "Casino/"]
RUN dotnet restore "Casino/Casino.csproj"
COPY . .
WORKDIR "/src/Casino"
RUN dotnet build "Casino.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Casino.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Casino.dll"]
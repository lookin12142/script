# Use the official .NET SDK image from Microsoft
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Create a new .NET console application
RUN dotnet new console -o App -n DotNet.Docker

# Add the specified code to Program.cs
RUN echo '// See https://aka.ms/new-console-template for more information\nConsole.WriteLine("Hello, World!");\nConsole.WriteLine("The current time is " + DateTime.Now);' > /app/App/Program.cs

# Publish the application
RUN dotnet publish /app/App/DotNet.Docker.csproj -c Release -o /app/publish

# Use a runtime image for running the application
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime

# Set the working directory
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/publish .

# Command to run the application
CMD ["dotnet", "DotNet.Docker.dll"]

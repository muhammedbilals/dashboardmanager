# Property Management System

This project is a Property Management System with a Flutter frontend and an ASP.NET Core MVC backend.

## Table of Contents
- [Backend Setup](#backend-setup)
  - [Prerequisites](#prerequisites)
  - [Setting up the ASP.NET Core MVC Backend](#setting-up-the-aspnet-core-mvc-backend)
- [Frontend Setup](#frontend-setup)
  - [Prerequisites](#prerequisites-1)
  - [Project Configuration](#project-configuration)
  - [Configuring Backend URL](#configuring-backend-url)
- [Running the Project](#running-the-project)
  - [Starting the Backend](#starting-the-backend)
  - [Running the Flutter App](#running-the-flutter-app)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Backend Setup

### Prerequisites
- Make sure you have .NET 8 SDK or later installed on your system.
- SQL Server should be installed and running.

### Setting up the ASP.NET Core MVC Backend
1. Navigate to the backend directory:

   ```bash
   cd backend
2. Restore the .NET packages:
   ```bash
   dotnet restore
3.Configure the appsettings.json file:

- Open the appsettings.json file in your preferred text editor.
- Update the DefaultConnection string in the ConnectionStrings section:
  ```bash
   "ConnectionStrings": {
  "DefaultConnection": "Data Source=YOUR_SERVER_NAME;Initial Catalog=propertiesapp;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
  }
- Replace YOUR_SERVER_NAME with your SQL Server instance name
4. Verify the JWT settings:
   ```bash
   "JWT": {
    "Issuer": "http://localhost:5246",
    "Audience": "http://localhost:5246",
    "SigninKey": "YOUR_SIGNING_KEY"
    }
5. Apply database migrations
     ```bash
   dotnet ef database update
6.Start the server

  ```bash
    dotnet watch run
  ```


7. Access Swagger UI at [http://localhost:5000/swagger/index.html](http://localhost:5000/swagger/index.html) to view and test your API endpoints.

   
## Backend Setup

### Prerequisites
- Ensure you have Flutter installed on your system.
- Make sure you have an IDE installed (e.g., Android Studio, VS Code).

### Project Configuration

1. Navigate to the frontend directory:

    ```bash
    cd frontend
    ```

2. Install dependencies:

    ```bash
    flutter pub get
    ```

### Configuring Backend URL

1. Navigate to the constants folder in your Flutter project:

    ```bash
    cd lib\core\constant\api_constant.dart
    ```

2. Open the file containing the base
   - Update the base URL with your backend URL:
   
    ```bash
    const String baseUrl = 'http://YourIpAddress:5000/api';
    ```
## Running the Project

### Starting the Backend
1. Navigate to the backend directory:

    ```bash
    cd backend
    ```

2. Start the server:

    ```bash
    dotnet run
    ```

### Running the Flutter App
1. Navigate to the frontend directory:

    ```bash
    cd frontend
    ```

2. Run the Flutter app:

    ```bash
    flutter run
    ```
   

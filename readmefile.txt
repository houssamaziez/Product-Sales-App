# Product Sales App

## Project Overview

The **Product Sales App** is a Flutter application designed to facilitate the sale of products by scanning QR codes. The app operates in two modes:

1. **Local Network Mode**: In this mode, the app inserts orders directly into a Microsoft SQL Server database.
2. **Offline Mode**: When offline, the app stores orders locally on the device. When the network connection is restored, the app notifies the user to sync the data with the server.

## Features

- **Scan QR Codes**: Scan product QR codes using the device's camera.
- **Add, Update, and Delete Products**: Manage product inventory by adding, updating, or deleting products.
- **Create and Manage Orders**: Handle customer orders efficiently, even in offline mode.
- **View Sales Statistics**: Analyze sales performance through in-app statistics.
- **Offline Support with Hive**: Store scanned products and orders in a local Hive database when offline.
- **SQL Server Integration**: Insert orders into a Microsoft SQL Server database when connected to the local network.
- **Reactive UI with GetX**: Manage app state reactively using GetX for a smooth and responsive user experience.
- **Data Sync Notifications**: Notify users to sync data when the network connection is restored.

## Project Architecture

The app follows the MVC (Model-View-Controller) design pattern:

- **Model**: Represents the data layer, including data structures and local database logic.
- **View**: Manages the presentation logic and user interface.
- **Controller**: Handles the application's logic, interacting with the Model and updating the View.

## Project Structure

```plaintext
lib/
├── controllers/  # GetX controllers for business logic
├── models/       # Data structures and local database logic
├── views/        # UI components
├── bindings/     # Dependency management (optional)
├── services/     # Data access services (e.g., SQL Server integration)
├── routes/       # Navigation logic
├── utils/        # Utility classes and functions
├── widgets/      # Reusable custom widgets

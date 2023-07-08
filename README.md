# Flutter Bloc Pattern with Clean Architecture and SOLID Principles

## Description
The "Flutter Bloc Pattern with Clean Architecture and SOLID Principles" project aims to develop a Flutter application that combines the robustness of the BLoC (Business Logic Component) pattern with the clarity of clean architecture principles and incorporates the SOLID principles for robust and maintainable code.

Clean architecture provides a structured approach to organizing code, emphasizing the separation of concerns and maintaining a clear boundary between different layers. This project will adhere to clean architecture principles by dividing the application into distinct layers:

- Presentation Layer: This layer will handle the UI components, user interactions, and visual elements. It will interact with the domain layer to retrieve and display data, and also communicate with the data layer to save or update information.

- Domain Layer: The domain layer encapsulates the business logic and use cases of the application. It defines the core functionality and rules of the application, independent of any UI or data source. This layer will interact with the data layer through abstractions to retrieve and process data.

- Data Layer: The data layer is responsible for interacting with external data sources, such as databases, APIs, or local storage. It will provide concrete implementations of the abstractions defined in the domain layer. The data layer will handle data retrieval, transformation, and persistence, ensuring a separation between data management and the business logic.

By following clean architecture principles, this project will achieve a highly modular and maintainable codebase. Each layer will depend only on abstractions from lower layers, promoting loose coupling and making it easier to replace or modify components without impacting the entire application.

Additionally, the project integrates the SOLID principles, which consist of the following:

- Single Responsibility Principle (SRP): Ensures that each class has a single responsibility, enhancing code clarity and maintainability.
- Open/Closed Principle (OCP): Allows for extending the functionality without modifying existing code, promoting code reuse and scalability.
- Liskov Substitution Principle (LSP): Ensures that derived classes can be substituted for their base classes without affecting the correctness of the program.
- Interface Segregation Principle (ISP): Encourages the creation of focused interfaces to prevent clients from depending on unnecessary functionalities.
- Dependency Inversion Principle (DIP): Promotes loose coupling by depending on abstractions, facilitating flexibility and testability.
By adhering to the SOLID principles, the project achieves code that is modular, reusable, and easier to understand and maintain.

To support the project's implementation, popular packages such as "flutter_bloc" for BLoC pattern implementation, "equatable" for simplified equality comparisons, and "get_it" for dependency inversion and management will be integrated. These packages provide powerful tools and utilities to streamline development, improve code quality, and enhance maintainability.
## Features
- Authentication (Login, Register, Logout)
- Product (List, Create, Update, Delete)
- Multi Language (English, Indonesian)
- Multi Theme (Light, Dark)
- Validation (Form, Internet Connection)
- Auto Login
- Auto save theme mode and language preference
- Offline data caching

## Popular Packages Used
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for BLoC pattern implementation
- [equatable](https://pub.dev/packages/equatable) for simplified equality comparisons
- [get_it](https://pub.dev/packages/get_it) for dependency inversion and management
- [go_router](https://pub.dev/packages/go_router) for declarative routing
- [hive](https://pub.dev/packages/hive) for lightweight and blazing fast key-value database
- etc
## Project Structure
- lib
  - src
    - configs
      - adapter
      - injector
    - core
      - api
      - blocs
      - cache
      - constant
      - errors
      - extensions
      - network
      - themes
      - usecases
      - utils
    - features
      - auth
        - data
          - datasources
          - models
          - repositories
        - di
        - domain
          - entities
          - repositories
          - usecases
        - presentation
          - bloc
          - pages
          - widgets
      - product
        - data
          - datasources
          - models
          - repositories
        - di
        - domain
          - entities
          - repositories
          - usecases
        - presentation
          - bloc
          - pages
          - widgets
    - routes
    - widgets
    - app.dart
  - main.dart

## How to run
- Clone this repository
- Open project directory in terminal or cmd
- Run `flutter pub get`
- Create firebase project
- Create firestore database in firebase project
- Edit security rules in firestore database to allow read and write without authentication
```rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write;
    }
  }
}
```
- Configure firebase to flutter project using flutterfire
- Run `flutter run` or debug from IDE (remember to open simulator or connect physical device)

## Feedback
- I am very happy if you want to provide feedback or contribute to this project
- If you have any questions, please contact me at yoga3911@gmail.com
- If you think this project is useful, you can give me a cup of coffee (Just Kidding 😁)
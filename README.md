# **PlatedRewards**

# **About**
PlatedRewards is a modular, state-driven iOS app designed to let users explore a variety of dishes from around the world. The app combines a smooth, intuitive user experience with a scalable and testable architecture.

# **Submission scope**
Users can browse meals by category (e.g., dessert, entrée) or by region (e.g., USA, Japan), view detailed information for each dish, and explore additional resources like YouTube videos or source links.

# **Architecture details** 
- Applied [Model-View-ViewModel](https://learn.microsoft.com/en-us/dotnet/architecture/maui/mvvm) architecture, ensuring clear separation of concerns between business logic and UI.
- PlatedRewards embraces amalgamation of mainstream concepts in UIKit while making them adaptable with SwiftUI style paradigm by following Coordinator pattern.
  - Practices inspired from [Kodeco's (Prev. Raywanderlich) Advanced iOS App Architecture book](https://www.kodeco.com/books/advanced-ios-app-architecture/v4.0) allowing making navigation modular and scalable.
- Utilizes highly adaptable networking service implementation inspired from [this architecture](https://medium.com/@bilalbakhrom/understanding-the-networking-aspect-of-swift-programming-cdf30334a55e) for scalable structure that embraces usage of [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) for testability and flexibility.
- Implemented unit testing and Test Driven Development practices ensuring high-quality, bug-free functionality.

## **Features**

- **Browse Dishes by Category and Area**: Ability to view dishes by selecting categories (e.g., dessert, entrée) or areas (e.g., USA, Japan).
- **Modular list selection**: By default the dessert list is being loaded which is paired with the selection of the filtering system embracing flexibility.
- **Dark mode support**: Incorporated good practices to make it frinedly on accessibility standards by implementing dark mode support.
- **View Meal Details**: Includes dish name, instructions, thumbnail image, and links to YouTube videos or source articles.
- **Unified Logging support**: The app includes unified logging to track errors during network requests, making debugging and monitoring easier.
- **Modular Architecture**: Components are organized into separate modules, making the codebase highly maintainable and follows SOLID principles.
- **File organizaton**: Added focus in maintaining flexible navigation across the codebase by following good file organization practices.
- **State-Driven UI**: The app uses custom state declaration to drive UI updates.
- **Faster API fetch**: Batch fetching and a well-structured Router and Repository pattern ensure efficient API interactions, resulting in faster loading times.

> I have implemented application that is more than the provided scope to showcase the app’s scalability and flexibility in handling various scenarios and requirements.

## **Building and testing environment**

- **Deployment target iOS 17+**
- **Built on Xcode 15.4**

## **Screenshots** 

- Logging
  
<img src="https://github.com/rpati99/PlatedRewards/blob/main/App%20Screenshots/Logging.jpg" alt="Logging" width="600"/>

- Screens


<img src="https://github.com/rpati99/PlatedRewards/blob/main/App%20Screenshots/MainDark.png" alt="MainDark" width="150"/><img src="https://github.com/rpati99/PlatedRewards/blob/main/App%20Screenshots/MainLight.png" alt="MainLight" width="150"/><img src="https://github.com/rpati99/PlatedRewards/blob/main/App%20Screenshots/DetaiDark.png" alt="DetailDark" width="150"/><img src="https://github.com/rpati99/PlatedRewards/blob/main/App%20Screenshots/DetailLight.png" alt="DetailLight" width="150"/>

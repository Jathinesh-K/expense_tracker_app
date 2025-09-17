# expense_tracker
Demo:
https://github.com/user-attachments/assets/e54badbf-7452-475b-8cf7-36ea96b86da4

Design choices:
1. Chosen MVVM achitecture pattern. Since we don't have any complex business logic other than adding/removing items from the list, I have used only UI and Data layers. If we have any complex logic, better to introduce domain layer with useCases communicating to Data Layer.
2. Chosen Provider for both State Management and dependency injection. State management for its simplicity given the scale of the app. And also a service locator might just be an overkill considering we were not having any scenarios where we have dependencies where BuildContext is not available. For big scale applications, we could go with more scalable solutions like BLoC for state management and any service locator like get_it package for global dependencies.


📱 Mobile Test

Mobile Test is a simple Flutter project demonstrating Clean Architecture, Dio networking, Dependency Injection (GetIt + Injectable), and Bloc state management.

🚀 Setup
1. Install dependencies
flutter pub get

2. Run code generation
dart run build_runner build --delete-conflicting-outputs

3. Start the app
flutter run

⚡ Makefile (recommended)

This project includes a Makefile for faster setup.

Initialize project:

make init


Other useful commands:

make gen      # build_runner
make watch    # watch mode
make clean    # flutter clean + pub get

📂 Structure
lib/
 ├── core/         # DI, Dio, Interceptors, utilities
 ├── features/     # Auth, Contacts.
 └── main.dart

🌐 API

The project uses a mock API:

https://mobile-test.free.mockoapp.net
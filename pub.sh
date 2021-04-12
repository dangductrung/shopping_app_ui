flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run easy_localization:generate -S assets/lang -f keys -o locale_keys.g.dart

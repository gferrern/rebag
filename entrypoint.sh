flutter build web --dart-define=FLUTTER_WEB_USE_SKIA=true --release
flutter run -d web-server --dart-define=FLUTTER_WEB_USE_SKIA=true --web-port $FLUTTER_WEB_PORT --web-hostname 0.0.0.0 --observatory-port $FLUTTER_DEBUG_PORT --release
exit

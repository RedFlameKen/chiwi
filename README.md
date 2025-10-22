# Chiwi AI

Voice-controlled reviewer that users can use to quiz themselves and quiz others

## Prerequisites
- [ ] Flutter SDK

## Running
The primary target platform this application targets is `web`. To run the app
regardless of the browser, you may run the following command:

```
flutter run -d web-server
```

This will launch a web server for the app. By default, this will use a random
port number. For consistency with the port number, the `--web-port` option may
be used to specify a custom port. For example: 

```
flutter run --web-port 8069 -d web-server
```

## Building
The project may be built with:

```
flutter build web
```

- todo:
    - [ ] Add github workflow for building and running the app on github pages.

## Resources

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

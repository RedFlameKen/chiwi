# Chiwi AI

Voice-controlled reviewer that users can use to quiz themselves and quiz others

## Prerequisites
- Flutter SDK

## Running
The primary target platform this application targets is `web`. To run the app
regardless of the browser, you may run the following command:

```bash
flutter run -d web-server
```

This will launch a web server for the app. By default, this will use a random
port number. For consistency with the port number, the `--web-port` option may
be used to specify a custom port. For example: 

```bash
flutter run --web-port 8069 -d web-server
```

Encryption requires secret keys. And to avoid tracking it in git, it is kept in
a file ignored by git called `keys.json`. To allow encryption to work, create
that file with the field `ENCRYPTION_KEY`. For example:
```json
{
    "ENCRYPTION_KEY": "examplePa55w0rd"
}
```

To allow flutter to read this file, the `--dart-define-from-file` option should
be used with the value of the keys file (`keys.json`):
```bash
flutter run --dart-define-from-file="keys.json" --web-port 3434 -d web-server
```

## Building
The project may be built with:

```bash
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

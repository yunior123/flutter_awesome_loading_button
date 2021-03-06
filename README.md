<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This is an awesome loading button without external dependencies

## Features

![Capture d’écran, le 2022-01-15 à 20 50 59](https://user-images.githubusercontent.com/47259501/149644240-773ce018-eae8-4a28-9936-c662318a5a80.png)

https://user-images.githubusercontent.com/47259501/149643618-8d5f1d58-b5ed-40f0-bae5-dbf2f9118b89.mov

## Getting started

This is a very simple to use package.

## Usage

Example

```dart
      AwesomeLoadingButton(
          loadingIndicatorColor: Colors.blue,
          loadingIndicatorValueColor: const AlwaysStoppedAnimation(
            Colors.blueAccent,
          ),
          onPressed: () async {
            await Future.delayed(
              const Duration(
                seconds: 5,
              ),
            );
          },
          text: 'Fetch',
        ),
```

## Additional information

Feel free to contribute by creating a pull request. I am always available.

# Foosball Mobile App (Dano Foosball) ⚽

`Dano Foosball`, A mobile app written in `Flutter` and uses the `Dart` programming language.

The mobile app interacts with a `Dot net core REST api`.

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/makes-people-smile.svg)](http://forthebadge.com)

[![Flutter](https://img.shields.io/badge/Flutter-3.29.3-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](http://forthebadge.com)

[![Dart](https://img.shields.io/badge/Dart-3.7.2-%230175C2.svg?style=for-the-badge&logo=Dart&logoColor=white)](http://forthebadge.com)

</div>

## iOS Development Setup

### Known Issue: libphonenumber_plugin Swift Compiler Error

If you encounter the following error when running on iOS:
Swift Compiler Error (Xcode): Cannot find type 'PhoneNumberKit' in scope

This is caused by the `flutter_login` package dependency `libphonenumber_plugin`. Follow these steps to fix:

1. **Download the patch files** from the flutter_login GitHub issue thread (Files.zip containing `SwiftLibphonenumberPlugin.swift` and `intl_phone_number_input.sh`)

2. **Place the patch files** in your project root directory (same level as `pubspec.yaml`)

3. **Make the script executable**:
   ```bash
   chmod +x intl_phone_number_input.sh

Clean and rebuild:
bashflutter clean
flutter pub get
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..

If the script doesn't run automatically, execute it manually:
bash./intl_phone_number_input.sh

Then run your app:
bashflutter run


Note: You may need to run the intl_phone_number_input.sh script manually after each pod install if the automated execution doesn't wor

# Development

Run the project with the following command.
OBS! We are now using Flutter version Manager

```sh
fvm flutter run
```

or run the program with the debugger withing `Visual studio code` if you have the `Flutter` and `Dart` extension.

# Run build runner

```sh
fvm flutter packages pub run build_runner build
```

## Env variables

Secrets are added to `secrets.json` file with `dotnet user-secrets`

To run the project. The following variables are needed. Mainly used for testing.

```bash
JWT_TOKEN_TEST=
USERNAME_TEST=
PASSWOR_TEST=
REST_URL_PATH_DEV=
REST_URL_PATH_PROD=

DEV_HOST=
DEV_PORT=
PROD_HOST=
PROD_PORT=

```

## Run on ANDROID emulator with localhost .net core webserver

1. Run an emulator from android studio

In the `.env` file make sure the `REST_URL_PATH_DEV` variable is set to `https://10.0.2.2:7145`

## Run on ANDROID physical device with localhost .net core webserver

Make sure to have `adb` in your environment path

I put this for the user variables and the system variables in PATH

```bash
C:\Users\USERNAME\AppData\Local\Android\sdk\platform-tools
```

Next make sure to reverse tcp with the following command

```bash
adb reverse tcp:7145 tcp:7145
```

In the `.env` file, make sure the `REST_URL_PATH_DEV` and `REST_URL_PATH_PROD` variables are set to `https://localhost:7145`

## Technology

[Flutter](https://flutter.dev/)
[Dart] (https://dart.dev/)

## Code Rules

To Do!

Right click on project file and choose `Format code`

## Testing

Integration testing is coded in `integration_test` folder

## Thanks

**Foosball** © 2022+, Mossfellsbær City.<br>
Authored and maintained by Daniel Freyr Sigurdsson. With help from [contributors].

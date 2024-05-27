# Foosball Mobile App ⚽

`Foosball Mobile App`, A mobile app written in `Flutter` and uses the `Dart` programming language.

The mobile app interacts with a `Dot net core REST api`.

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/makes-people-smile.svg)](http://forthebadge.com)

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](http://forthebadge.com)

[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](http://forthebadge.com)

</div>

# Development

Run the project with the following command

```sh
flutter run
```

or run the program with the debugger withing `Visual studio code` if you have the `Flutter` and `Dart` extension.

# Run build runner

```sh
flutter packages pub run build_runner build
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

To Do!

## Thanks

**Foosball** © 2022+, Mossfellsbær City.<br>
Authored and maintained by Daniel Freyr Sigurdsson. With help from [contributors].

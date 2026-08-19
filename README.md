# Slökun Frontend

This repository contains the Flutter MVP for the Slökun application.

## Project purpose

The frontend is responsible for:
- welcome and auth screens
- registration and login flows
- map-based sauna discovery
- venue details and reviews
- profile and attendance actions

## Repository responsibilities

- `flutter_app/lib/src/screens`: app screens
- `flutter_app/lib/src/services`: API and local storage layers
- `flutter_app/lib/src/providers`: app state and auth flows
- `flutter_app/lib/src/firebase_options.dart`: Firebase config
- `flutter_app/lib/main.dart`: app bootstrap

## Local development

1. Install Flutter dependencies:
   ```bash
   cd flutter_app
   flutter pub get
   ```
2. Run in web mode:
   ```bash
   flutter run -d chrome
   ```
3. Or build web:
   ```bash
   flutter build web --release
   ```

## CI

GitHub Actions run on:
- `main`
- `schuchanek-flutter-mvp`

Workflow file:
- `.github/workflows/flutter_web_build.yml`

## Notes

This project uses:
- Flutter
- Material Design 3 styling
- Easy Localization
- Firebase bootstrap
- API contract based on the backend repository

## Working agreement

Keep this repo traceable and reviewable:
- branch per feature
- commit after meaningful milestones
- push before handoff
- maintain README and status docs in repo

## Related repositories

- Backend: `schuchanek/slokun-backend`
- DevOps: `schuchanek/slokun-devops`

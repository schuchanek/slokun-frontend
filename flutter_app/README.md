Slökun Frontend MVP (Flutter)

Run (web):

  flutter pub get
  flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8080

Build (web):

  flutter build web --release

Production serve:
 - build/web contains static assets; serve with nginx or static server.
 - Dockerfile included runs flutter web-server for dev; replace with nginx static image for production.

Env: copy .env.example -> .env

Required env vars:
 - API_BASE_URL - backend API base URL
 - OAUTH_GOOGLE_CLIENT_ID - google oauth client id for web
 - FIREBASE_API_KEY, FIREBASE_AUTH_DOMAIN - if using Firebase auth
 - FLUTTER_WEB_PORT (default 8080)

DevOps: proxy should route /api/* to API_BASE_URL and proxy other paths to the frontend container on 8080. CORS must allow OAuth redirect and API calls.

Google Maps (web):
 - Add your Maps API key to web/index.html by replacing YOUR_GOOGLE_MAPS_API_KEY.
 - Alternatively inject the key during CI into web/index.html before deploying.

Firebase:
 - Run `flutterfire configure` to generate lib/src/firebase_options.dart and set Firebase project settings.
 - Ensure FIREBASE_API_KEY & FIREBASE_AUTH_DOMAIN in .env if using Firebase web config.

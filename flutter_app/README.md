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
 - Or run `dart pub global activate flutterfire_cli` then `flutterfire configure` in the project root to generate `lib/src/firebase_options.dart`.
 - For web, ensure FIREBASE_API_KEY & FIREBASE_AUTH_DOMAIN (and other Firebase config fields) are present in .env or in your CI secrets.

CI / Maps API key injection example (GitHub Actions):
 - Add `GOOGLE_MAPS_API_KEY` as a repo secret.
 - Before `flutter build web`, replace placeholder in web/index.html:

   - name: Inject Maps API key
     run: |
       sed -i "s/YOUR_GOOGLE_MAPS_API_KEY/${{ secrets.GOOGLE_MAPS_API_KEY }}/g" flutter_app/web/index.html

 - Also add Firebase web config as secrets and use them at build time if needed.

Notes on OAuth redirect URIs:
 - For Google OAuth web flow, in the Google Cloud Console set authorized origins to your frontend host (e.g., http://localhost:8080) and redirect URIs if using explicit redirects.
 - The backend expects idToken from client (POST /auth/google) — client should obtain idToken from Google Sign-In and POST it to backend.

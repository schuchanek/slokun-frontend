UI Design Spec — Slökun Frontend MVP

Logo: Slökun sauna symbol (modern, minimal)

Brand Colors (Dart):
- primary: Color(0xFF2A6B8F) // Mély kék
- secondary: Color(0xFFE8B8A8) // Meleg rozé
- accent: Color(0xFFF5A623) // Meleg sárga
- background: Color(0xFFF9F7F4) // Krém

Screens:
1. Welcome / Login — central, clean, CTA for Login/Register
2. Register — email + password
3. Map — Google Maps with sauna pins
4. Venue Detail — hero image, info, reviews, "Ott leszek" button
5. Reviews — rating + comment
6. Profile — user info, logout

Design notes:
- Follow Material Design 3, use soft rounded cards, generous spacing, and warm color accents.
- Prefer large imagery and muted backgrounds to create wellness/spa aesthetic.
- Dark mode: invert neutrals, keep accent colors as highlights.

Dev notes:
- Colors are wired to lib/src/app.dart as constants. Use Theme.of(context).colorScheme for colors.
- Add logo at assets/images/logo.svg (placeholder) and replace with designer asset later.

Prepared by: Frontend scaffold automation

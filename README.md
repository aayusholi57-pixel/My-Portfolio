# Aayush Oli — Portfolio

Personal portfolio website and project CMS for **Aayush Oli**, aspiring AI/ML Engineer.

- **Website:** https://aayusholi.com.np
- **Admin:** https://aayusholi.com.np/admin.html
- **GitHub:** https://github.com/aayusholi57-pixel
- **Hosting:** Render Static Site, deployed from `main`

## Features
- Responsive static portfolio with project, about, skills, and contact sections.
- Optional database-driven featured projects using Supabase.
- Admin UI with Google OAuth sign-in.
- Supabase Row Level Security (RLS) for public read-only published content and admin-only writes.
- No server-side application required for the static site.

## Configure the admin CMS
Follow [SUPABASE-SETUP.md](SUPABASE-SETUP.md) in order. In short:
1. Create a Supabase project and enable Google authentication.
2. Run [SUPABASE-SETUP.sql](SUPABASE-SETUP.sql) after replacing `YOUR_GOOGLE_EMAIL` with your exact admin Google email.
3. Configure [admin-config.js](admin-config.js) with your Supabase project URL, publishable/anon key, and the same email.
4. Commit the configuration so Render deploys it.
5. Visit `/admin.html` and sign in with the authorized Google account.

The browser key is a public publishable/anon key, not a secret. Never put a Supabase service-role key in this repository. Security is enforced by database RLS policies.

## Run locally
From this folder:

```bash
python -m http.server 8080
```

Then visit http://localhost:8080. OAuth redirects must be configured for the local URL if testing Google sign-in locally.

## Deployment
Render builds this repository's `main` branch as a static site using `echo 'Static portfolio ready to publish'` and publishes `.`. Changes committed to `main` trigger automatic deployment.

## Project claim accuracy
Keep project descriptions and live-demo links accurate. Add live links only after verifying the service is publicly accessible. Report model metrics from the corresponding evaluation split and do not overstate results.

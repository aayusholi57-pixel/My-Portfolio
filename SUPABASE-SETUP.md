# Portfolio Admin CMS Setup

The site remains a static Render site. The private management UI lives at `/admin.html`; Supabase provides Google OAuth, Postgres storage, and Row Level Security (RLS).

## 1. Create Supabase project
1. Create a project at https://supabase.com/dashboard.
2. In Project Settings > API, copy the Project URL and publishable/anon key. These browser values are public by design; RLS protects data. Never use a service-role/secret key in browser code.
3. In Authentication > Providers, enable Google. Follow Supabase's current Google provider instructions to create an OAuth client in Google Cloud and enter its client ID and secret in Supabase.
4. In Authentication > URL Configuration, set Site URL to `https://aayusholi.com.np` (or the Render URL until the custom domain is verified). Add redirect URLs:
   - `https://aayusholi.com.np/admin.html`
   - `https://www.aayusholi.com.np/admin.html`
   - `https://aayusholi-portfolio.onrender.com/admin.html`
   Use the exact domain that is working in your browser.

## 2. Create the database securely
1. Open Supabase > SQL Editor.
2. Open `SUPABASE-SETUP.sql` in this repository.
3. Replace every `YOUR_GOOGLE_EMAIL` with the exact Google account email that should administer the portfolio.
4. Run the SQL. It enables RLS and grants public read access only to published rows; writes require the matching authenticated email.

## 3. Configure the static site
1. Open `admin-config.js` in this repository.
2. Replace `YOUR_SUPABASE_PROJECT_URL`, `YOUR_SUPABASE_PUBLISHABLE_OR_ANON_KEY`, and `YOUR_GOOGLE_EMAIL`.
3. Commit the file. The key must be the publishable/anon key only. Never place a service-role key in this repository.
4. Render auto-deploys when the commit reaches `main`.

## 4. Admin
Visit `https://aayusholi.com.np/admin.html` and click **Continue with Google**. Add/edit/delete featured projects. The page checks the admin email, and the database RLS policies independently enforce write permissions.

## Important current scope
- The admin can manage the `portfolio_projects` table securely.
- To have the public homepage read these database records dynamically, deploy `public-projects.js` integration as a separate step after configuring Supabase. Until then, the existing homepage cards remain static HTML.
- Image uploads and contact inbox are not included yet.
- Keep the Supabase project private to your organization and enable MFA on your Google account.

# KARMA — Turn mistakes into realizations.
Private, event-based mistake diary. Static app (GitHub Pages) + your own Supabase project for email-OTP login and permanent storage.
## Files (all in the repo root, except the SQL)
index.html · config.js · logo.png · sw.js · manifest-v2.webmanifest · icon-*.png · supabase/migrations/001_init.sql
## Setup (once)
1. Create a free project at supabase.com.
2. SQL Editor → paste `supabase/migrations/001_init.sql` → Run.
3. Authentication → Providers → Email: on. Authentication → Email Templates → "Magic Link" (and "Confirm signup"): include `{{ .Token }}` in the body so the 6-digit code is emailed. OTP length is 6, expiry is set under Providers → Email; keep `OTP_EXPIRY_SECONDS` in config.js equal to it. For reliable delivery set up custom SMTP (Authentication → SMTP).
4. Project Settings → API: copy the Project URL and the `anon` public key into `config.js`. Never use the service_role key.
5. Commit and let GitHub Pages redeploy.
## Data safety
Code (GitHub) and data (Supabase database + private storage bucket, plus a copy in the browser) are separate. Deploying never touches data. Schema changes are new files in `supabase/migrations/` (never DROP/TRUNCATE). The service worker cache version only affects app files. Logout keeps everything.
Existing entries made before login are adopted by the first account that logs in on that device and uploaded.
## Logo
Replace `logo.png` (and `icon-192/512.png`, `icon-maskable-*.png` for the installed icon). Everything reads `logo.png` (path set in config.js).
## Backup
Data → Export → `KARMA_Backup_YYYY-MM-DD.karma.zip` (`karma.json` + `media/voice|photos|pdfs`). Import accepts `.karma.zip` and older `.karma.json`, with preview, merge (skips duplicate ids) or replace (confirmed).
## Limits
Sync is simple: entries missing on either side are copied; an entry edited on two devices keeps the local version; deleting on one device is applied to the cloud but other devices may re-upload their old copy.

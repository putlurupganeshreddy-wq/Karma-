# KARMA — Turn mistakes into realizations.
A private, event-based mistake and learning diary. **Not** a daily diary: no streaks, no reminders, no pressure.

## Features
Dashboard with local date/time and a time-aware quote (52 quotes, no immediate repeats) · record mistakes by text, voice (start/pause/resume/stop/playback/delete), photos and PDFs · categories (optional) · reflection (what happened, my mistake, realization, lesson, next time) · Mistakes, Realize and event-based Diary pages · search · favorites · PDF export via the browser print dialog ("Save as PDF") · Data export/import with merge or replace and duplicate protection · delete-all.

## Stack
Plain HTML/CSS/JavaScript (no build step). Data is stored **only on your device** in the browser's IndexedDB. Nothing is uploaded.

## Structure
`index.html` · `css/style.css` · `js/app.js` (UI, storage, reflection, import/export) · `assets/logo.png` · `.env.example`

## Run locally
Microphone access needs `localhost` or HTTPS.
```
npm start      # or: npx serve .   /   python3 -m http.server 5173
```
Open http://localhost:5173. Deploy the folder to any static host (GitHub Pages, Netlify, Vercel).

## Reflection ("AI") configuration
The reflection is generated **locally** by simple rules from the user's own words; it never invents details and never overwrites the original text. No API key is used. `.env.example` reserves `AI_API_KEY` and `SPEECH_TO_TEXT_API_KEY` for a future server integration; they are not read by this static app.

## Voice transcription
Audio is recorded and stored. Automatic transcription is not connected; type or paste a transcript into the transcript field.

## Backup format
`KARMA_Backup_YYYY-MM-DD.karma.json`: `{format:"karma-backup", version:1, exportedAt, entries:[…]}`. Each entry holds its text, dates, category, reflection, and its voice, photos and PDFs as base64 data URLs, so attachments stay linked to the right entry. One portable file, no ZIP needed.

## Restore
Data → Import → choose the file → review the preview → Merge (skips entries whose id already exists) or Replace (asks for confirmation).

## GitHub
```
git init && git add . && git commit -m "KARMA" && git branch -M main
git remote add origin <your-repo-url> && git push -u origin main
```
Clearing browser data deletes your diary: export backups regularly.

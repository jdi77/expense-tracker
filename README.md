# Expense Tracker

A personal expense tracker with monthly entry, year-at-a-glance trend view, and Supabase backend — hosted on GitHub Pages.

**Live app:** https://jdi77.github.io/expense-tracker

## Features
- 📅 Month view — add daily expenses per category
- 📊 Year view — see all 12 months side by side with heat-map highlights
- 🎨 Color-coded categories
- ☁️ Supabase backend — data syncs across devices
- ➕ Add / delete categories anytime

## Setup

### 1. Supabase
1. Go to [supabase.com](https://supabase.com) → create a free project
2. Open **SQL Editor** and paste the contents of `supabase-setup.sql` → Run
3. Go to **Settings → API** and copy your **Project URL** and **anon/public key**

### 2. GitHub Pages
1. Push this repo to GitHub
2. Go to **Settings → Pages** → Source: `main` branch, `/ (root)`
3. Your app will be live at `https://jdi77.github.io/expense-tracker`

### 3. First launch
Open the app URL, enter your Supabase URL and anon key when prompted. These are saved in your browser — you only do this once per device.

## Tech
- Vanilla HTML/CSS/JS — no build step needed
- [Supabase JS v2](https://supabase.com/docs/reference/javascript) for the database
- GitHub Pages for hosting

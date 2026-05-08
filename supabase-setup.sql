-- =====================================================
-- Expense Tracker - Full Supabase Setup
-- Run this in Supabase → SQL Editor
-- Safe to run multiple times
-- =====================================================

-- 1. Create tables
create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  position integer not null default 0,
  user_id uuid references auth.users(id) on delete cascade,
  created_at timestamptz default now()
);

create table if not exists expenses (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references categories(id) on delete cascade,
  month_key text not null,
  date_label text not null,
  note text,
  amount numeric(10,2) not null,
  user_id uuid references auth.users(id) on delete cascade,
  created_at timestamptz default now()
);

-- 2. Indexes
create index if not exists categories_user_id_idx on categories(user_id);
create index if not exists expenses_user_id_idx on expenses(user_id);
create index if not exists expenses_month_key_idx on expenses(month_key);
create index if not exists expenses_category_id_idx on expenses(category_id);

-- 3. Enable Row Level Security
alter table categories enable row level security;
alter table expenses enable row level security;

-- 4. Drop all existing policies (safe - recreated below)
drop policy if exists "Allow all" on categories;
drop policy if exists "Allow all" on expenses;
drop policy if exists "Users see own categories" on categories;
drop policy if exists "Users see own expenses" on expenses;

-- 5. Per-user policies (each user only sees their own data)
create policy "Users see own categories" on categories
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "Users see own expenses" on expenses
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

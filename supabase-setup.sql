-- Run this in Supabase → SQL Editor
-- If you already ran the old setup, this script safely updates it

-- Drop old open policies
drop policy if exists "Allow all" on categories;
drop policy if exists "Allow all" on expenses;

-- Add user_id column if not exists
alter table categories add column if not exists user_id uuid references auth.users(id) on delete cascade;
alter table expenses add column if not exists user_id uuid references auth.users(id) on delete cascade;

-- Per-user RLS policies (each user only sees their own data)
create policy "Users see own categories" on categories
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "Users see own expenses" on expenses
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Indexes
create index if not exists categories_user_id_idx on categories(user_id);
create index if not exists expenses_user_id_idx on expenses(user_id);
create index if not exists expenses_month_key_idx on expenses(month_key);

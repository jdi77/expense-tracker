-- Run this in your Supabase project → SQL Editor

-- Categories table
create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  position integer not null default 0,
  created_at timestamptz default now()
);

-- Expenses table
create table if not exists expenses (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references categories(id) on delete cascade,
  month_key text not null,       -- format: "2025-01"
  date_label text not null,      -- e.g. "Jan 7"
  note text,
  amount numeric(10,2) not null,
  created_at timestamptz default now()
);

-- Indexes for fast lookups
create index if not exists expenses_month_key_idx on expenses(month_key);
create index if not exists expenses_category_id_idx on expenses(category_id);

-- Enable Row Level Security (open policy — lock down if you add auth later)
alter table categories enable row level security;
alter table expenses enable row level security;

create policy "Allow all" on categories for all using (true) with check (true);
create policy "Allow all" on expenses for all using (true) with check (true);

-- Optional: seed default categories (comment out if you want to start fresh)
insert into categories (name, position) values
  ('Tithes & Offering', 0),
  ('Tithes-India', 1),
  ('Electricity', 2),
  ('Home Gas', 3),
  ('Washer Dryer', 4),
  ('Mobile Payments', 5),
  ('Hulu', 6),
  ('Amazon Prime', 7),
  ('Internet', 8),
  ('Water', 9),
  ('Car Insurance', 10),
  ('Car Gas', 11),
  ('Costco', 12)
on conflict do nothing;

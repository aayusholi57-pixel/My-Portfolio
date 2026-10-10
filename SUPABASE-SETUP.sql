-- Run this in Supabase Dashboard > SQL Editor.
-- Replace the email in the Google auth allowlist check with your exact Google sign-in email.
create extension if not exists pgcrypto;

create table if not exists public.portfolio_projects (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) between 1 and 100),
  icon text not null default '✦',
  description text not null check (char_length(description) between 1 and 600),
  tags text[] not null default '{}',
  repo_url text,
  demo_url text,
  sort_order integer not null default 10,
  published boolean not null default true,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.portfolio_projects enable row level security;

drop policy if exists "Public can read published portfolio projects" on public.portfolio_projects;
create policy "Public can read published portfolio projects"
on public.portfolio_projects for select
to anon, authenticated
using (published = true or (auth.jwt() ->> 'email') = 'YOUR_GOOGLE_EMAIL');

drop policy if exists "Admin can insert portfolio projects" on public.portfolio_projects;
create policy "Admin can insert portfolio projects"
on public.portfolio_projects for insert
to authenticated
with check ((auth.jwt() ->> 'email') = 'YOUR_GOOGLE_EMAIL');

drop policy if exists "Admin can update portfolio projects" on public.portfolio_projects;
create policy "Admin can update portfolio projects"
on public.portfolio_projects for update
to authenticated
using ((auth.jwt() ->> 'email') = 'YOUR_GOOGLE_EMAIL')
with check ((auth.jwt() ->> 'email') = 'YOUR_GOOGLE_EMAIL');

drop policy if exists "Admin can delete portfolio projects" on public.portfolio_projects;
create policy "Admin can delete portfolio projects"
on public.portfolio_projects for delete
to authenticated
using ((auth.jwt() ->> 'email') = 'YOUR_GOOGLE_EMAIL');

grant select on public.portfolio_projects to anon, authenticated;
grant insert, update, delete on public.portfolio_projects to authenticated;

-- After creating the table, add your existing featured projects in the admin UI.
-- IMPORTANT: replace every occurrence of YOUR_GOOGLE_EMAIL above with the exact
-- email address you will use for Google sign-in, before running this SQL.

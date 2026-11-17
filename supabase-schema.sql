-- Vanuatu Business Hub: Supabase database setup
-- Run this whole file in Supabase Dashboard > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'user' check (role in ('user','admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.businesses (
  id uuid primary key default gen_random_uuid(),
  business_name text not null check (char_length(business_name) between 2 and 100),
  category text not null,
  province text not null check (province in ('Torba','Sanma','Penama','Malampa','Shefa','Tafea')),
  location text not null,
  contact_name text not null,
  phone text not null,
  email text,
  website text,
  description text not null check (char_length(description) between 5 and 600),
  status text not null default 'Pending' check (status in ('Pending','Approved','Rejected')),
  created_at timestamptz not null default now()
);

create or replace function public.is_vbh_admin()
returns boolean language sql stable security definer
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

create or replace function public.handle_new_vbh_user()
returns trigger language plpgsql security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, role) values (new.id, 'user')
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created_vbh on auth.users;
create trigger on_auth_user_created_vbh
after insert on auth.users
for each row execute procedure public.handle_new_vbh_user();

alter table public.profiles enable row level security;
alter table public.businesses enable row level security;

drop policy if exists "Users can read own profile or admins all profiles" on public.profiles;
create policy "Users can read own profile or admins all profiles"
on public.profiles for select to authenticated
using (id = auth.uid() or public.is_vbh_admin());

drop policy if exists "Public can submit pending businesses" on public.businesses;
create policy "Public can submit pending businesses"
on public.businesses for insert to anon, authenticated
with check (status = 'Pending');

drop policy if exists "Public can read approved businesses and admins all" on public.businesses;
create policy "Public can read approved businesses and admins all"
on public.businesses for select to anon, authenticated
using (status = 'Approved' or public.is_vbh_admin());

drop policy if exists "Admins can update businesses" on public.businesses;
create policy "Admins can update businesses"
on public.businesses for update to authenticated
using (public.is_vbh_admin())
with check (public.is_vbh_admin());

drop policy if exists "Admins can delete businesses" on public.businesses;
create policy "Admins can delete businesses"
on public.businesses for delete to authenticated
using (public.is_vbh_admin());

grant usage on schema public to anon, authenticated;
grant select, insert on public.businesses to anon, authenticated;
grant update, delete on public.businesses to authenticated;
grant select on public.profiles to authenticated;
grant execute on function public.is_vbh_admin() to authenticated;

-- After creating your first administrator account in Supabase Authentication,
-- replace the email below and run this separately to grant admin access:
-- update public.profiles
-- set role = 'admin'
-- where id = (select id from auth.users where email = 'YOUR-ADMIN-EMAIL');

-- KARMA migration 001. Safe to re-run. Never add DROP/TRUNCATE. Future changes go in new numbered files (002_...).
create table if not exists public.entries(
  id text primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null,
  data jsonb not null,
  synced_at timestamptz not null default now());
create index if not exists entries_user_idx on public.entries(user_id,created_at desc);
alter table public.entries enable row level security;
do $$ begin
 if not exists(select 1 from pg_policies where tablename='entries' and policyname='own entries') then
  create policy "own entries" on public.entries for all to authenticated using(auth.uid()=user_id) with check(auth.uid()=user_id);
 end if;
 if not exists(select 1 from pg_policies where tablename='objects' and policyname='own karma media') then
  create policy "own karma media" on storage.objects for all to authenticated
   using(bucket_id='karma-media' and (storage.foldername(name))[1]=auth.uid()::text)
   with check(bucket_id='karma-media' and (storage.foldername(name))[1]=auth.uid()::text);
 end if;
end $$;
insert into storage.buckets(id,name,public) values('karma-media','karma-media',false) on conflict(id) do nothing;

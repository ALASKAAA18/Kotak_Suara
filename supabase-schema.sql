create table if not exists public.letters (
  id uuid primary key default gen_random_uuid(),
  recipient text not null check (length(btrim(recipient)) between 1 and 200),
  message text not null check (length(btrim(message)) between 1 and 10000),
  sender text not null check (length(btrim(sender)) between 1 and 200),
  sent_at timestamptz not null default now()
);

alter table public.letters enable row level security;

revoke all on table public.letters from anon, authenticated;
grant insert (recipient, message, sender) on table public.letters to anon, authenticated;
grant select, delete on table public.letters to authenticated;

drop policy if exists "Anyone can send letters" on public.letters;
create policy "Anyone can send letters"
  on public.letters
  for insert
  to anon, authenticated
  with check (true);

drop policy if exists "Admins can read letters" on public.letters;
create policy "Admins can read letters"
  on public.letters
  for select
  to authenticated
  using (
    lower(auth.jwt() ->> 'email') in (
      'asadekaalaska@gmail.com',
      'fajarhidayat130310@gmail.com'
    )
  );

drop policy if exists "Admins can delete letters" on public.letters;
create policy "Admins can delete letters"
  on public.letters
  for delete
  to authenticated
  using (
    lower(auth.jwt() ->> 'email') in (
      'asadekaalaska@gmail.com',
      'fajarhidayat130310@gmail.com'
    )
  );


alter table public.settings add column if not exists studio jsonb not null default '{}'::jsonb;
insert into storage.buckets(id,name,public) values('studio','studio',true) on conflict(id) do nothing;
drop policy if exists studio_admin on storage.objects;
create policy studio_admin on storage.objects for all to authenticated using(bucket_id='studio' and public.is_admin()) with check(bucket_id='studio' and public.is_admin());

CREATE EXTENSION IF NOT EXISTS pgcrypto;
drop table if exists locations;
create table locations (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone not null default localtimestamp,
  lat float8,
  lon float8,
  chain_id varchar(256),
  chain_name varchar(256),
  name varchar(256),
  address varchar(512),
  tel varchar(256),
  business_hours varchar(256),
  closed_on varchar(256),
  url text,
  parking text,
  items text,
  memo text,
  primary key(id)
);


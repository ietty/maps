
create database geodb encoding 'UTF8';
create extension postgis;

shp2pgsql -W cp932 -i -I -s 4612:4326 A29-11_13.shp yoto_13 > A29_13.sql

shp2pgsql -D -W cp932 -i -I -s 4326 A29-11_13.shp yoto_13 > A29_13.sql

psql -h multipurpose-pg.cnjwcovwdyax.ap-northeast-1.rds.amazonaws.com --username=adminietty geodb < A29_13.sql

select * from yoto_13 where st_intersects(geom, ST_Buffer(ST_GeomFromText('POINT(139.7139 35.6214)')::geography,200));
select * from yoto_13 where st_intersects(geom, ST_Buffer(ST_SetSRID(ST_POINT(139.7139, 35.6214),4326)::geography, 200));
select * from yoto_13 where st_intersects(geom, ST_Buffer(ST_POINT(139.7139, 35.6214)::geography, 200));


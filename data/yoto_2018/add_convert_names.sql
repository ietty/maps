SET CLIENT_ENCODING TO UTF8;

BEGIN;

ALTER TABLE yoto_2018 ADD COLUMN IF NOT EXISTS tokei_name varchar(254);
UPDATE yoto_2018 SET tokei_name =
CASE WHEN tokei = 1 THEN '市街化区域'
     WHEN tokei = 2 THEN '市街化調整区域'
     WHEN tokei = 3 THEN '非線引区域'
     WHEN tokei = 99 THEN '都市計画区域外'
END;

ALTER TABLE yoto_2018 ADD COLUMN IF NOT EXISTS youto_name varchar(254);
UPDATE yoto_2018 SET youto_name =
CASE WHEN youto = 11 THEN '第一種低層住居専用地域'
     WHEN youto = 12 THEN '第二種低層住居専用地域'
     WHEN youto = 21 THEN '第一種中高層住居専用地域'
     WHEN youto = 22 THEN '第二種中高層住居専用地域'
     WHEN youto = 31 THEN '第一種住居地域'
     WHEN youto = 32 THEN '第二種住居地域'
     WHEN youto = 40 THEN '準住居地域'
     WHEN youto = 51 THEN '近隣商業地域'
     WHEN youto = 52 THEN '商業地域'
     WHEN youto = 61 THEN '準工業地域'
     WHEN youto = 62 THEN '工業地域'
     WHEN youto = 63 THEN '工業専用地域'
     WHEN youto = 71 THEN '無指定'
     WHEN youto = 99 THEN '都市計画区域外'
END;

ALTER TABLE yoto_2018 ADD COLUMN IF NOT EXISTS bouka_name varchar(254);
UPDATE yoto_2018 SET bouka_name =
CASE WHEN bouka = 0 THEN '指定なし'
     WHEN bouka = 1 THEN '準防火地域'
     WHEN bouka = 2 THEN '防火地域'
END;

COMMIT;


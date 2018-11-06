#!/bin/bash

#yotoテーブルのrename

HOME=C:/cygwin64/home/Takemi
TODIR=$HOME/devbase/opt/maps/data/yoto
PRIVATE=$HOME/devbase/opt/private/secrets/pgsql

mkdir -p $TODIR
cd $TODIR

#sqlの作成
cat <<EOS > $TODIR/rename.sql
alter table yoto rename column A29_001 to divison_code;
alter table yoto rename column A29_002 to pref;
alter table yoto rename column A29_003 to city;
alter table yoto rename column A29_004 to yoto_id;
alter table yoto rename column A29_005 to yoto;
alter table yoto rename column A29_006 to coverage;
alter table yoto rename column A29_007 to floor_area_ratio;
alter table yoto rename column A29_008 to reference;
alter table yoto rename column A29_009 to created_at;
alter table yoto rename column A29_010 to memo;
EOS

docker run -d --rm -v $TODIR:/downloads --env-file $PRIVATE/env webgoal/geo-cli sh -c "tail -f /dev/null"

#docker run --rm -v $TODIR:/downloads --env-file $PRIVATE/env webgoal/geo-cli sh -c "psql -h multipurpose-pg.cnjwcovwdyax.ap-northeast-1.rds.amazonaws.com --username=adminietty geodb < /downloads/yoto.sql"
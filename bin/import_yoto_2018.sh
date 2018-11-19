#!/bin/bash
#ロケスマデータのPostGIS投入

#PostGISに[locations]テーブルを作成

#HOME=C:/cygwin64/home/Takemi
DATA=$HOME/devbase/opt/maps/data/yoto_2018
PRIVATE=$HOME/devbase/opt/private/secrets/pgsql

function cmd(){
  docker run --rm -v $DATA:/src --env-file $PRIVATE/env webgoal/geo-cli sh -c "$@"
}

#shp2pgsqlによるsqlの作成
docker run --rm -v $DATA:/downloads webgoal/geo-cli sh /downloads/yoto.sh

#psqlでsqlからデータ投入
docker run --rm -v $DATA:/downloads --env-file $PRIVATE/env webgoal/geo-cli sh -c "psql -h multipurpose-pg.cnjwcovwdyax.ap-northeast-1.rds.amazonaws.com --username=adminietty geodb < /downloads/yoto.sql"

#都市計画区域、用途地域、防火地域のコードを名称に変換したデータを追加
docker run --rm -v $DATA:/downloads --env-file $PRIVATE/env webgoal/geo-cli sh -c "psql -h multipurpose-pg.cnjwcovwdyax.ap-northeast-1.rds.amazonaws.com --username=adminietty geodb < /downloads/add_convert_names.sql"


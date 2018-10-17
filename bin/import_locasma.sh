#!/bin/bash
#ロケスマデータのPostGIS投入

#PostGISに[locations]テーブルを作成

#HOME=C:/cygwin64/home/Takemi
DATA=$HOME/devbase/opt/maps/data/locationsmart
PRIVATE=$HOME/devbase/opt/private/secrets/pgsql

function cmd(){
  docker run --rm -v $DATA:/src --env-file $PRIVATE/env webgoal/geo-cli sh -c "$@"
}

#テーブル作成とimport
cmd "psql geodb < /src/create.sql"


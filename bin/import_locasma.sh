#!/bin/bash
#ロケスマデータのPostGIS投入

#PostGISに[locations]テーブルを作成

#HOME=C:/cygwin64/home/Takemi
DATA=$HOME/devbase/opt/maps/data/locationsmart
PRIVATE=$HOME/devbase/opt/private/secrets/pgsql

function cmd(){
  docker run --rm -v $DATA:/src --env-file $PRIVATE/env webgoal/geo-cli sh -c "$@"
}


#納品ファイルにある最後のタブ文字を削除
#テーブル作成
cmd "psql geodb < /src/create.sql"

#まずはそのままデータを突っ込む
cmd "psql geodb < /src/copy.sql"

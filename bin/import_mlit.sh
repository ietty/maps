#!/bin/bash
#用途地域データPostGIS投入

#PostGISに用途区域GIS[yoto]テーブルを作成

HOME=C:/cygwin64/home/Takemi
TODIR=$HOME/devbase/opt/maps/data/yoto
PRIVATE=$HOME/devbase/opt/private/secrets/pgsql

#ダウンロードリストとsql作成batchの作成
mkdir -p $TODIR
cd $TODIR
echo -n "" > req.txt
echo "shp2pgsql -W cp932 -i -I -p -s 4326 /downloads/A29-11_01.shp yoto > /downloads/yoto.sql" > yoto.sh
for i in $(seq -w 47); do
  echo "http://nlftp.mlit.go.jp/ksj/gml/data/A29/A29-11/A29-11_${i}_GML.zip" >> req.txt
  echo "shp2pgsql -W cp932 -D -a -i -I -s 4326 /downloads/A29-11_${i}.shp yoto >> /downloads/yoto.sql"  >> yoto.sh
done

##テスト接続用
##docker run -d --entrypoint tail --name aria2 -v $TODIR:/downloads tbaxx/aria2:1.34.0 -f /dev/null
##docker run -d --rm -v $TODIR:/downloads --env-file $PRIVATE/env webgoal/geo-cli sh -c "tail -f /dev/null"

#aria2を利用したダウンロード
#docker run --rm -v $TODIR:/downloads tbaxx/aria2:1.34.0 -x 5 -i /downloads/req.txt -d /downloads
#unzip -oj 'A29-11_*.zip'

#shp2pgsqlによるsqlの作成
docker run --rm -v $TODIR:/downloads webgoal/geo-cli sh /downloads/yoto.sh

#psqlでsqlからデータ投入
docker run --rm -v $TODIR:/downloads --env-file $PRIVATE/env webgoal/geo-cli sh -c "psql -h multipurpose-pg.cnjwcovwdyax.ap-northeast-1.rds.amazonaws.com --username=adminietty geodb < /downloads/yoto.sql"


##docker imageを削除しておく
#docker rmi tbaxx/aria2:1.34.0 webgoal/geo-cli 
##ダウンロード中間データを削除
#rm -rf $TODIR/*.xml $TODIR/*.sql

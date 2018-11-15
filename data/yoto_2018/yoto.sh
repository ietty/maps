
dirs=`find /downloads/13/* -type d -maxdepth 0 `

#テーブル作成DDL(ファイルは何でも良い)


f=true
for dir in $dirs;
do
	$f && f=false && shp2pgsql -W cp932 -s 4301 -D -I -p $dir/youto.shp yoto_2018 > /downloads/yoto.sql
  shp2pgsql -W cp932 -s 4301 -i -D -a $dir/youto.shp yoto_2018 >> /downloads/yoto.sql
done



\copy locations(lat,lon,chain_id,name,address,tel,business_hours,closed_on,url,parking,items,memo) from '/src/zgi_20181016.txt' (delimiter '	', format csv, header true );


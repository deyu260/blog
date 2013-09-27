cd /home/backup
DataBakName=Data_$(date +"%Y%m%d").tar.gz
WebBakName=Web_$(date +%Y%m%d).tar.gz
OldData=Data_$(date -d -5day +"%Y%m%d").tar.gz
OldWeb=Web_$(date -d -5day +"%Y%m%d").tar.gz
rm -rf /home/backup/Data_$(date -d -3day +"%Y%m%d").tar.gz
/usr/local/mysql/bin/mysqldump -u root -p123456 zhumaohai > /home/backup/zhumaohai.sql
tar zcf /home/backup/$DataBakName /home/backup/*.sql
rm -rf /home/backup/*.sql
tar zcvf /home/backup/$WebBakName /home/wwwroot
ftp -v -n pythonpad.com << END
user username 123456
type binary
cd backup
delete $OldData
delete $OldWeb
put $DataBakName
put $WebBakName
bye
END

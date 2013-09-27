#!/bin/bash
cd /home/backup
#定义数据库的名字和旧数据库的名字
DataBakName=Data_$(date +"%Y%m%d").tar.gz
WebBakName=Web_$(date +%Y%m%d).tar.gz
OldData=Data_$(date -d -5day +"%Y%m%d").tar.gz
OldWeb=Web_$(date -d -5day +"%Y%m%d").tar.gz
#删除本地3天前的数据
rm -rf /home/backup/Data_$(date -d -3day +"%Y%m%d").tar.gz
#导出mysql数据库
/usr/local/mysql/bin/mysqldump -u root -p123456 zhumaohai > /home/backup/zhumaohai.sql
#压缩数据库
tar zcf /home/backup/$DataBakName /home/backup/*.sql
#删除sql文件
rm -rf /home/backup/*.sql
#压缩网站数据
tar zcvf /home/backup/$WebBakName /home/wwwroot
#上传到FTP空间,删除FTP空间5天前的数据
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

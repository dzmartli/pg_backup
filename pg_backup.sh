#! /bin/bash

################
# PG DB backup #
################


user="user"
dir="/home/${USER}/pg_backup/"

if [ ! -e "${dir}/archive" ]
then
        mkdir -p "${dir}/archive"
fi


pg_user="pg_user"
pg_pass="pg_password"
db_name="db_name"
filename="pg_db_dump-$(date +'%Y_%m_%d_%I_%M_%S').pgsql"
max_files=7
files=$(ls -1q $dir | wc -l)
files=$(( ${files} ))
PGPASSWORD=$pg_pass pg_dump -U $pg_user -h localhost $db_name > ${dir}${filename}


if [ "$files" -gt "$max_files" ]
then
	tar czf "${dir}${filename}.tar" "${dir}" --exclude='"archive"'
	mv "${dir}${filename}.tar" "${dir}archive/"
	dir+="*.pgsql"
	rm -f $dir
else
	:
fi
exit 0

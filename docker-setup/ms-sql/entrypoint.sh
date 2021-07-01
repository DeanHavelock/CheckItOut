#!/bin/bash

# start SQL Server
/opt/mssql/bin/sqlservr &

password=Password1

# wait for MSSQL server to start
export STATUS=1
while [[ $STATUS -ne 0 ]] && [[ $i -lt 90 ]]; do
	i=$i+1
	/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0,1433 -t 1 -U SA -P $password -Q "select 1" >> /dev/null
	STATUS=$?
done

if [ $STATUS -ne 0 ]; then
	echo "Error: MSSQL SERVER took more than 90 seconds to start up."
	exit 1
fi

echo "Importing data."

sqlcmd=/opt/mssql-tools/bin/sqlcmd
$sqlcmd -S 0.0.0.0,1433 -U SA -P $password -i init.sql
$sqlcmd -S 0.0.0.0,1433 -U SA -P $password -i add_users.sql

migrations=$(ls migrations/*.sql | sort -V)
seeds=$(ls seed-data/*.sql | sort -V)

echo "Starting migration scripts"

for sql in $migrations
do
  echo Executing $sql
  $sqlcmd -S 0.0.0.0 -U sa -P $password -i $sql
done

echo "Starting Running Seed Data"

for sql in $seeds
do
	echo Executing $sql
	$sqlcmd -S 0.0.0.0 -U sa -P $password -i $sql
done

echo "======= MSSQL CONFIG COMPLETE =======" | tee -a ./config.log

# Call extra command
eval $1
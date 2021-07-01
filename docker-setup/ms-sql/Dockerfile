FROM mcr.microsoft.com/mssql/server:2017-latest
RUN apt-get update && apt-get install -y dos2unix

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app
ADD entrypoint.sh /usr/src/app/

# Grant permissions for the import-data script to be executable
RUN dos2unix /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 1433
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# Tail the setup logs to trap the process
CMD ["tail -f /dev/null"]
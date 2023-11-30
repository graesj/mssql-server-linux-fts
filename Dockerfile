# https://github.com/microsoft/mssql-docker/issues/161?fbclid=IwAR2VDP43xHSkvBqMjcaNsa1kcLjIbmVK9IA7a0scs5BoWZv4_EyvgbRyOxM#issuecomment-1094810699
FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

# Install curl since it is needed to get repo config
# install gnupg2 (not installed in the image)
# see also workaround curl with | tac | tac | : https://syntaxfix.com/question/16804/why-does-curl-return-error-23-failed-writing-body

RUN export DEBIAN_FRONTEND=noninteractive && \
apt-get update --fix-missing && \
apt-get install -y gnupg2 && \
apt-get install -yq curl apt-transport-https && \
curl https://packages.microsoft.com/keys/microsoft.asc | tac | tac | apt-key add - && \
curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list | tac | tac | tee /etc/apt/sources.list.d/mssql-server.list && \
apt-get update

# Install optional packages.
RUN apt-get install -y mssql-server-fts

# Run SQL Server process
CMD /opt/mssql/bin/sqlservr
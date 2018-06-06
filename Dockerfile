# Set the base image
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Robert Herczeg <robert.herczeg@gmail.com>


################## BEGIN INSTALLATION ######################
RUN apt-get update --fix-missing
RUN apt-get -y install build-essential
RUN apt-get -y install ncbi-blast+ sudo wget
RUN apt-get -y install git curl unzip
RUN apt-get -y install apt-utils
# MySQL
ENV MYSQL_PWD Pwd123
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN apt-get -y install mysql-server

RUN apt-get -y install mc
RUN apt-get -y install nano
RUN apt-get -y install libdbd-mysql-perl
RUN apt-get -y install libmariadb-client-lgpl-dev
# install R
RUN apt-get -y install r-base
# install pacakges for mysql
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('DBI')"
RUN Rscript -e "install.packages('RMySQL')"

RUN apt-get clean
# install DBI for perl
RUN cpan install DBI
# get DIGS-tool
RUN cd /root && git clone https://github.com/giffordlabcvr/DIGS-tool.git

# Set environment variables.
ENV DIGS_HOME /root/DIGS-tool/
ENV DIGS_GENOMES /root/DIGS-tool/genomes
ENV DIGS_MYSQL_USER=root
ENV DIGS_MYSQL_PASSWORD=Pwd123

# Define working directory.
WORKDIR /root/DIGS-tool

# copy files
# start mysql
COPY start.sh /root/DIGS-tool
# grab results from database to file
COPY result.R /root/DIGS-tool
# copy control file
COPY example_ctl.txt /root/DIGS-tool

# set file permissions
RUN chmod u+x start.sh
RUN mkdir genomes
# copy example dataset
RUN cp -R  example/targets/Mammalia genomes/

# Define default command.
CMD ["bash"]

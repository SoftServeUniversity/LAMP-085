sudo apt-get install redis-server
sudo apt-get install python2.6
sudo apt-get install python-unittest2
sudo apt-get install pylint
sudo apt-get install build-essential git-core
sudo apt-get install curl
\curl -L https://get.rvm.io | bash -s stable
source "/home/`whoami`/.rvm/scripts/rvm"
rvm install 1.9.3
rvm use --default 1.9.3
rvm rubygems current
sudo apt-get install mysql-client mysql-server libmysql-ruby libmysqlclient-dev
sudo apt-get --no-install-recommends install build-essential openssl libreadline6 
libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev 
libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev 
ncurses-dev automake libtool bison subversion pkg-config libffi-dev
sudo apt-get install p7zip-full 
sudo apt-get install rails
sudo apt-get install nodejs
cd ..
git clone https://github.com/SoftServeUniversity/LAMP-085.git
cd "`pwd`/LAMP-085/rails-app"
sudo apt-get install rails
sudo apt-get install ruby-rspec-core
sudo gem install bundler
bundle install
sudo gem install passenger 
passenger start

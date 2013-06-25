LAMP-085
========

## HOME WORK CHECKER
Is a Rails application for automatic home works checking jobs, 
based on Resque
Suport ruby and python language
## Instalation 
**Install redis**
```bash
$ wget http://download.redis.io/redis-stable.tar.gz
$ tar xvzf redis-stable.tar.gz
$ cd redis-stable
$ make
```
Start server.
```bash
$ redis-server
```
**Install ruby** 
```bash
$ \curl -L https://get.rvm.io | bash -s stable
$ source "/home/`whoami`/.rvm/scripts/rvm"
$ rvm install 1.9.3
$ rvm use --default 1.9.3
$ sudo apt-get install rubygems 
$ sudo gem install bundler
```

**Additional dependents**
```bash
$ sudo apt-get install mysql-client mysql-server libmysql-ruby libmysqlclient-dev
$ sudo apt-get --no-install-recommends install build-essential openssl libreadline6 
libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev 
sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake 
libtool bison subversion pkg-config libffi-dev
```

**Install python environment**
```bash
$ sudo apt-get install python2.6
$ sudo apt-get install python-unittest2
$ sudo apt-get install pylint
```
**Install 7zip archivator**
```bash
$ sudo apt-get install p7zip-full
```

**Install nodejs**
```bash
$ sudo apt-get install nodejs
```
## Using
Download Rails application and run `$ bundle install`
All archives with home works must be puted in `app/received` directory

## Adding support for new languages

To implement new languages support you need create two new classes in 
`HomeWorkChecker::ArchiveResult` module. This  classes must be inherited from "abstract" classes
`TestRun` and `CodeQuality`. 
`TestRun` must reseive two arguments  in initialize method. The first one is temporary 
directory path and the second one is title of directory where unpacked files lie.
Second method which named perform must scan for tests, run them and calculate 
passed/failed ratio. CodeQuality implements same logic but it must calculate quality.

In `default.yml` add identificator for your language and describe module:
```bash
HomeWorkChecker::ArchiveResult::<Your TestRun class> HomeWorkChecker::ArchiveResult::<Your CodeQuality class>
```



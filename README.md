LAMP-085
========

Ruby app to check homework
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
$ rvm install 1.9.3 
```
**Install python environment**
```bash
$ sudo apt-get install python2.6
$ sudo apt-get install python-unittest2
$ sudo apt-get install python-nose
$ sudo apt-get install pylint
```
## Using
Download Rails application and run `$ bundle install`
All archives with home works must be puted in `app/reseived` directory

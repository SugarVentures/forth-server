# forth-server

## Installation

Install ruby with enable-shared option

ruby
```shell
$ rbenv install 2.2.1
```

```shell
$ bundle install
$ rake db:drop db:create db:migrate db:seed
$ rails s
```
Access to your local host
http://localhost:3000/

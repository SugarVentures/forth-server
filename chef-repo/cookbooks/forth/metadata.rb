name             'forth'
maintainer       'shinya'
maintainer_email 'shinya.kitamura@sugar.sg'
license          'All rights reserved'
description      'Configures Forth servers'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "ntp"
depends "apt"
depends "rvm"
depends "nginx"
depends "logrotate"
depends "magic_shell"

# Puppet modules for Anthill Platform

This repository contains a list of Puppet modules (along with dependencies) that
are required for Anthill Platform to run on your server.

## Installation

To install the main module (required), add these lines to your Puppetfile:

```
mod 'anthillplatform-anthill',
    :git => 'https://github.com/anthill-platform/puppet-anthill.git',
    :path => "modules/anthill"
```

To optionally install a module for certain service, add these lines:

```
mod 'anthillplatform-anthill_<service>',
    :git => 'https://github.com/anthill-platform/puppet-anthill.git',
    :path => "modules/anthill_<service>"
```

For example, to additionally install a module for login service, add these lines:

```
mod 'anthillplatform-anthill_login',
    :git => 'https://github.com/anthill-platform/puppet-anthill.git',
    :path => "modules/anthill_login"
```

Please see a [Puppetfile example](https://github.com/anthill-platform/puppet-anthill-dev/blob/master/Puppetfile) file on how to install all the modules.

## How to manage Puppetfile

You need [Librarian Puppet](https://librarian-puppet.com/) to manage Puppetfile. Install Ruby on your machine, install `gem install librarian-puppet` and just do `librarian-puppet install` in the repository folder. 

Alternatively, you can install [Hiera Editor](https://github.com/desertkun/hiera-editor) and then simply open the repositorin in it, the editor will setup everything automatically.
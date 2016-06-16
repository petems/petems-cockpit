# Cockpit Puppet Module
[![Build Status](https://secure.travis-ci.org/petems/petems-cockpit.svg)](https://travis-ci.org/petems/petems-cockpit)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with cockpit](#setup)
    * [What cockpit affects](#what-cockpit-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cockpit](#beginning-with-cockpit)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module for installing, configuring, and managing [Cockpit](http://cockpit-project.org), a free and open source web interface fronten for server management.

## Module Description

This module manages the installation of Cockpit.

If you'd prefer, you can also disable the repo after the agent's been installed, or opt out of repo management altogether.

## Setup

### What cockpit affects

By default, this module will:
* Set up the package repository
* Install the Cockpit package
* Configure the /etc/cockpit/cockpit.conf file
* Set up and enable the Cockpit service.

### Beginning with cockpit

Most of cockpit's setup is handled by the package itself.

Configuration is mainly configured in `/etc/cockpit/cockpit.conf` but there's also changes in the invidual `systemd` files for things like listening port, such as `/etc/systemd/system/cockpit.socket.d/listen.conf`.

On RHEL, Cockpit exists in most upstream repos by default, but you can also get preview releases also (See https://copr.fedorainfracloud.org/coprs/g/cockpit/cockpit-preview/)

On other Operating Systems, repositories are maintained seperately:

* Ubuntu: https://launchpad.net/~jpsutton/+archive/ubuntu/cockpit
* Debian: https://fedorapeople.org/groups/cockpit/debian

Full docs are avaliable here: http://cockpit-project.org/guide/latest/

## Usage

This module includes a single class:
```puppet
include '::cockpit'
```

You'll more than likely want to provide the appropriate values for your setup.

To opt out of repo management altogether, you'd specify it like so:
```puppet
class { '::cockpit':
  manage_repo => false,
}
```

To change the port that Cockpit runs on (the default is 9090)
```puppet
class { '::cockpit':
  port => '443',
}
```

## Limitations

* Arch support is currently not implemented.
* Changing the port that Cockpit runs on seems with `path` parameter to be broken in older versions. On Fedora's avaliable base package `cockpit-0.67-2.fc22.x86_64` the service refuses to start. The latest version of the package works (`cockpit-0.106-1.fc22.x86_64`). You can use this package by enabling preview repos; `yum_preview_repo => true`.

## Development

If you'd like to other features or anything else, check out the contributing guidelines in CONTRIBUTING.md.

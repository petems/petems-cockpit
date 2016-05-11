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
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module for installing, configuring, and managing [Cockpit](http://cockpit-project.org), a free and open source web interface fronten for server management.

## Module Description

This module manages the installation of the Hyperic agent and allows you to automatically deploy the latest version of the agent to your machines and configure the agent to report in to your server.

If you'd prefer, you can also disable the repo after the agent's been installed, or opt out of repo management altogether.

Note that you'll need your preferred distro of Java on the machine. While it isn't a direct dependency, the puppetlabs-java module works well for this purpose.

## Setup

### What cockpit affects

By default, this module will:
* Set up the package repository
* Install the Cockpit package
* Configure the /etc/cockpit/cockpit.conf file
* Set up and enable the Cockpit service.

### Beginning with cockpit

On RHEL, Cockpit exists in most upstream repos by default, but you can also get preview releases (See https://copr.fedorainfracloud.org/coprs/g/cockpit/cockpit-preview/)

On other Operating Systems, repositories are maintained seperately.

Configuration is mainly configured in `/etc/cockpit/cockpit.conf`

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

## Reference



## Limitations

This module currently only works with CentOS 7, but I'm working on extending it for most standard RHEL distributions.

Cockpit is also avaliable for Arch, Debian and Ubuntu. I might eventually get around to setting it up for those OS's in the future.

## Development

If you'd like to other features or anything else, check out the contributing guidelines in CONTRIBUTING.md.

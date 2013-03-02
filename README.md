# Puppet Simple Text edits Module

Puppet Module for Simple Text edits

Tested on CentOS 6, patches to support other operating systems are welcome.

## Installation

Clone this repo to your Puppet modules directory

    git clone git://github.com/ahaitoute/puppet-line.git line

## Usage

Usage example: Add 'dummy' to the list of automatically loaded modules

    file { "/etc/modules": ensure => present, }

    line { dummy_module:
      file => "/etc/modules",
      line => "dummy",
    }

Usage example: Remove 'dummy' from the list of automatically loaded modules

    file { "/etc/modules": ensure => present, }

    line { dummy_module:
      file => "/etc/modules",
      line => "dummy",
      ensure => absent
    }

Usage example: Comment 'dummy' from the list of automatically loaded modules

    file { "/etc/modules": ensure => present, }

    line { dummy_module:
      file => "/etc/modules",
      line => "dummy",
      ensure => comment
    }

Usage example: Uncomment 'dummy' from the list of automatically loaded modules

    file { "/etc/modules": ensure => present, }

    line { dummy_module:
      file => "/etc/modules",
      line => "dummy",
      ensure => uncomment
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

I'd like to thank http://projects.puppetlabs.com/projects/1/wiki/Simple_Text_Patterns for providing the necessary puppet-code. I only collected the code into a module.

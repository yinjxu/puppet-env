puppet-env
==========

Puppet module for cross platform environment variables configuration. Now this module only support windows platform. I will add other platform support later.

Basic usage
-----------

Set a system level envionment variable

```
env { 'PYTHON_HOME':
    value => 'c:\python27',
    ignore_case => true,
    ensure => present,
}
```

Unset a system level envionment variable

```
env { 'PYTHON_HOME':
    value => 'c:\python27',
    ignore_case => true,
    ensure => absent,
}
```

Add python to system path and remove ruby from system path    

```
env_path { 'c:\python27':
    ensure => absent,
    ignore_case => true,
}
```

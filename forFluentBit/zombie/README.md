# Zombie

Monitoring the amount of (Linux) Zombie processes using Fluent-Bit.

This configuration features:

- States

>Report only on changes, not on each cycle.

- Maintenance mode

>Where all monitoring is de-configured until we go out of maintenance.

Note that I used the yaml format, but it can be rewritten as ini.


### States

Using global Lua variables, we remember the value (the previous amount of zombies) of the previous run, and using this, we only report when a change is detected. Note that each Lua program runs with it's own global variables, so you can't share them across

### Maintenance mode

Where all monitoring is de-configured until we go out of maintenance. When we detect a maintenance file, we swap the configuration file with an empty one, then trigger a hot restart of Fluent-Bit, which re-reads the configuration file (and wipes the global memory when doing so)

## Usage

To start using it, copy the "on" in place (one-time action), then start [Fluent-Bit](https://fluentbit.io/):

```
cp zombie.yaml-on zombie.yaml
fluent-bit -c ./zombie.yaml
```

## Go in and out of maintenance mode

To switch between the two monitoring files, use:

```
touch /tmp/MAINTENANCEMODE
rm /tmp/MAINTENANCEMODE
```

## Create a zombie process
You can force a zombie process to be created using the following helper scripts:

### Using perl
```
perl zombie_create.pl &
```

### Using gcc
```
gcc -o zombie zombie.c
./zombie
```

### Using Tiny C Compiler
```
tcc -run zombie.c
``` 




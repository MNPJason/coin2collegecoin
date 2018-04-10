Sample init scripts and service configuration for coin2colleged
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/coin2colleged.service:    systemd service unit configuration
    contrib/init/coin2colleged.openrc:     OpenRC compatible SysV style init script
    contrib/init/coin2colleged.openrcconf: OpenRC conf.d file
    contrib/init/coin2colleged.conf:       Upstart service configuration file
    contrib/init/coin2colleged.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "coin2collegecore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes coin2colleged will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, coin2colleged requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, coin2colleged will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that coin2colleged and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If coin2colleged is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running coin2colleged without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/coin2college.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/coin2colleged`  
Configuration file:  `/etc/coin2collegecore/coin2college.conf`  
Data directory:      `/var/lib/coin2colleged`  
PID file:            `/var/run/coin2colleged/coin2colleged.pid` (OpenRC and Upstart) or `/var/lib/coin2colleged/coin2colleged.pid` (systemd)  
Lock file:           `/var/lock/subsys/coin2colleged` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the coin2collegecore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
coin2collegecore user and group.  Access to coin2college-cli and other coin2colleged rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/coin2colleged`  
Configuration file:  `~/Library/Application Support/Coin2CollegeCore/coin2college.conf`  
Data directory:      `~/Library/Application Support/Coin2CollegeCore`
Lock file:           `~/Library/Application Support/Coin2CollegeCore/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start coin2colleged` and to enable for system startup run
`systemctl enable coin2colleged`

4b) OpenRC

Rename coin2colleged.openrc to coin2colleged and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/coin2colleged start` and configure it to run on startup with
`rc-update add coin2colleged`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop coin2colleged.conf in /etc/init.  Test by running `service coin2colleged start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy coin2colleged.init to /etc/init.d/coin2colleged. Test by running `service coin2colleged start`.

Using this script, you can adjust the path and flags to the coin2colleged program by
setting the COIN2COLLEGED and FLAGS environment variables in the file
/etc/sysconfig/coin2colleged. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.coin2college.coin2colleged.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.coin2college.coin2colleged.plist`.

This Launch Agent will cause coin2colleged to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run coin2colleged as the current user.
You will need to modify org.coin2college.coin2colleged.plist if you intend to use it as a
Launch Daemon with a dedicated coin2collegecore user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.

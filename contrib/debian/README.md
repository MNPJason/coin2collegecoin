
Debian
====================
This directory contains files used to package coin2colleged/coin2college-qt
for Debian-based Linux systems. If you compile coin2colleged/coin2college-qt yourself, there are some useful files here.

## coin2college: URI support ##


coin2college-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install coin2college-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your coin2college-qt binary to `/usr/bin`
and the `../../share/pixmaps/coin2college128.png` to `/usr/share/pixmaps`

coin2college-qt.protocol (KDE)


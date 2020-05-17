![Test](https://github.com/adborden/zoom-overlay/workflows/Test/badge.svg)
![New ebuild](https://github.com/adborden/zoom-overlay/workflows/New%20ebuild/badge.svg)


# zoom-overlay

Gentoo overlay for the [Zoom.us](https://zoom.us/) video conferencing client.


## Usage

We recommend using eselect to manage the overlay.

    $ sudo eselect repository add zoom-overlay git https://github.com/adborden/zoom-overlay.git

Sync the repository.

    $ sudo emerge --sync zoom-overlay

Review and accept the EULA license.

    # Read the license
    $ less /var/db/repos/zoom/licenses/zoom-eula
    # Add the license to /etc/portage/package.license
    net-im/zoom zoom-eula

Install the Zoom client.

    $ sudo emerge -q net-im/zoom


## Development

The latest linux tarball is available here and will redirect to the specific
version/URL.

    https://zoom.us/client/latest/zoom_x86_64.tar.xz

`update_ebuilds.sh` will test this URL to figure out the latest version, and
copy the most recent ebuild to the new version.

    $ ./update_ebuilds.sh

Update the manifest.

    $ DISTDIR=/tmp repoman manifest

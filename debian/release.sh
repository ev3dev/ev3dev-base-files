#!/bin/bash
#
# Maintainer script for publishing releases.

set -e

source=$(dpkg-parsechangelog -S Source)
version=$(dpkg-parsechangelog -S Version)
distribution=$(dpkg-parsechangelog -S Distribution)

OS=debian DIST=${distribution} ARCH=amd64 pbuilder-ev3dev build

debsign ~/pbuilder-ev3dev/debian/${distribution}-amd64/${source}_${version}_amd64.changes

dput ev3dev-debian ~/pbuilder-ev3dev/debian/${distribution}-amd64/${source}_${version}_amd64.changes

gbp buildpackage --git-tag-only

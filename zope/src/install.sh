#!/bin/bash

mkdir -p "$ZOPE_HOME/zeo_instances" "$ZOPE_HOME/zope_instances"

mkzeoinstance "$ZOPE_HOME/zeo_instances/plinn"
mv "$ZOPE_HOME/zeo.conf" "$ZOPE_HOME/zeo_instances/plinn/etc/zeo.conf"

mkzopeinstance -d "$ZOPE_HOME/zope_instances/plinn" -u admin:admin
mv "$ZOPE_HOME/zope.conf" "$ZOPE_HOME/zope_instances/plinn/etc/zope.conf"

exit 0
#
# Buildout config file to use. Default: base.cfg
#
if [ -z "$ZOPE_HOME" ]; then
  ZOPE_HOME="/opt/zope"
fi

if [ -z "$CONFIG" ]; then
    CONFIG="base.cfg"
fi
echo "Using $CONFIG"
echo ""
# Use python version. Default: 2.7
#
if [ -z "$PYTHON" ]; then
  PYTHON="/usr/bin/env python"
fi
echo "Using Python: "
echo `$PYTHON --version`
#
# Cleanup
#
echo "Cleanup $ZOPE_HOME/parts"
rm -vrf $ZOPE_HOME/parts
#
#
# Run buildout
#
echo "Running buildout -c $CONFIG"
buildout -c $CONFIG

#
# Fix permissions
#
chown -R 500:500 $ZOPE_HOME

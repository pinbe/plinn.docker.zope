#!/bin/bash

mkdir -p "$ZOPE_HOME/zeo_instances" "$ZOPE_HOME/zope_instances"

mkzeoinstance "$ZOPE_HOME/zeo_instances/plinn"
mv "$ZOPE_HOME/zeo.conf" "$ZOPE_HOME/zeo_instances/plinn/etc/zeo.conf"

mkzopeinstance -d "$ZOPE_HOME/zope_instances/plinn" -u admin:admin
mv "$ZOPE_HOME/zope.conf" "$ZOPE_HOME/zope_instances/plinn/etc/zope.conf"

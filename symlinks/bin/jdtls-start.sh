#!/usr/bin/env bash

JAR="$HOME/lsp/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
UNAME=$(sh -c 'uname 2>/dev/null || echo Unknown')
CONFIGURATION="$HOME/lsp/java/jdtls/config_"

if [[ "$UNAME" == "Windows_NT" ]]; then
  UNAME="Windows"
fi

case $UNAME in
  Linux)
    CONFIGURATION="${CONFIGURATION}linux"
    ;;
  Windows)
    CONFIGURATION="${CONFIGURATION}win"
    ;;
  Darwin)
    CONFIGURATION="${CONFIGURATION}mac"
    ;;
esac

java \
  -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration $(echo "$CONFIGURATION") \
  -data "$1" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED

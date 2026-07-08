#!/bin/bash
set -ex

SHARE_DIR=$PREFIX/share/$PKG_NAME-$PKG_VERSION-$PKG_BUILDNUM
BIN_DIR=$PREFIX/bin

mkdir -p $SHARE_DIR
mkdir -p $BIN_DIR

cp -r diann-$PKG_VERSION/* $SHARE_DIR/

chmod +x $SHARE_DIR/diann-linux

cat <<EOF > $BIN_DIR/diann
#!/bin/bash
export LD_LIBRARY_PATH=$SHARE_DIR:\$LD_LIBRARY_PATH
exec $SHARE_DIR/diann-linux "\$@"
EOF

chmod +x $BIN_DIR/diann

cat <<EOF > $BIN_DIR/diann-stats
#!/bin/bash
exec $PREFIX/bin/python $SHARE_DIR/diann-stats.py "\$@"
EOF
chmod +x $BIN_DIR/diann-stats
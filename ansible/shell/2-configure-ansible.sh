#!/bin/bash

set -e

cat > /tmp/hosts << "EOF"
[all]
127.0.0.1

[application]
127.0.0.1

[vm]
127.0.0.1

[development]
127.0.0.1

[mysql]
127.0.0.1

[redis]
127.0.0.1

[resque]
127.0.0.1

EOF

sudo mv -f /tmp/hosts /etc/ansible/hosts

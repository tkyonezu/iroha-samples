#!/bin/bash


echo ">>> GetRoles <<<"
docker exec -i iroha_node_1 /opt/iroha/bin/iroha-cli \
  --account_name=admin@test \
  --key_path=/opt/iroha/config \
  <<EOF | grep 2018 | sed 's/^>.*: //'
2
5
1
0.0.0.0
50051
EOF

exit 0

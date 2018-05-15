#!/bin/bash

echo ">>> CreateDomain (iroha) <<<"
docker exec -i iroha_node_1 /opt/iroha/bin/iroha-cli \
  --account_name=admin@test \
  --key_path=/opt/iroha/config \
  <<EOF | grep 2018 | sed 's/^>.*: //'
1
10
iroha
user
2
0.0.0.0
50051
EOF

echo ">>>  CreateAsset (usd#test) <<<"
docker exec -i iroha_node_1 /opt/iroha/bin/iroha-cli \
  --account_name=admin@test \
  --key_path=/opt/iroha/config \
  <<EOF | grep 2018 | sed 's/^>.*: //'
1
14
usd
test
2
2
0.0.0.0
50051
EOF

echo ">>> GetAccount (alice@test) <<<"
docker exec -i iroha_node_1 /opt/iroha/bin/iroha-cli \
  --account_name=admin@test \
  --key_path=/opt/iroha/config \
  <<EOF | grep 2018 | sed 's/^>.*: //'
2
8
alice@test
1
0.0.0.0
50051
EOF

echo ">>> CreateAcdount (alice@test) <<<"
if [ ! -f alice@test.pub ]; then
  docker exec -i iroha_node_1 /opt/iroha/bin/iroha-cli \
    --new_account --name alice@test --passphrase magicseed_alice
fi

echo ">>> GetAccount (alice@test) <<<"
docker exec -i iroha_node_1 /opt/iroha/bin/iroha-cli \
  --account_name=admin@test \
  --key_path=/opt/iroha/config \
  <<EOF | grep 2018 | sed 's/^>.*: //'
2
8
alice@test
1
0.0.0.0
50051
EOF

echo ">>> CreateAccount (bob@test) <<<"
if [ ! -f bob@test.pub ]; then
  docker exec -i iroha_node_1 /opt/iroha/bin/iroha-cli \
    --new_account --name bob@test --passphrase magicseed_bob
fi

# GetAccount (bob@test)
# AddSignatory (bob@test)
# GetSignatories (bob@test)
# AddAssetQuantity (alice@test, usd#test, 20000, 2)
# GetAccountAssets (alice@test)
# AddAssetQuantity (bob@test, usd#test, 10000, 2)
# GetAccountAssets (bob@test)
# TransferAsset (alice@test, bob@test, usd#test, 180, 2)
# GetAccountAssets (alice@test)
# GetAccountAssets (bob@test)
# GetAccountTransactions (alice@test)
# GetAccountTransactions (bob@test)

exit 0

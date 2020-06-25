#!/usr/bin/env bash

# Create Notary configuration
printf "*********************************************************************************\n"
printf "Create Notary configuration\n"
printf "*********************************************************************************\n"

install -m 644 /dev/null ./mynetwork/notary_node.conf
cat <<EOF >./mynetwork/notary_node.conf
devMode=true
emailAddress="test@test.com"
myLegalName="O=Notary, L=London, C=GB"
p2pAddress="notary:10200"
notary { 
  validating : false 
}
rpcSettings {
    address="0.0.0.0:10201"
    adminAddress="0.0.0.0:10202"
}
EOF

printf "Created in: ./mynetwork/notary_node.conf\n\n"

# Create PartyA configuration
printf "*********************************************************************************\n"
printf "Create PartyA configuration\n"
printf "*********************************************************************************\n\n"

install -m 644 /dev/null ./mynetwork/partya_node.conf
cat <<EOF >./mynetwork/partya_node.conf
devMode=true
emailAddress="test@test.com"
myLegalName="O=PartyA, L=London, C=GB"
p2pAddress="partya:10200"
rpcSettings {
    address="0.0.0.0:10201"
    adminAddress="0.0.0.0:10202"
}
security {
    authService {
        dataSource {
            type=INMEMORY
            users=[
                {
                    password="password"
                    permissions=[
                        ALL
                    ]
                    username=user
                }
            ]
        }
    }
}
cordappSignerKeyFingerprintBlacklist = []
sshd {
  port = 2222
}
EOF

printf "Created in: ./mynetwork/partya_node.conf\n\n"

# Create PartyB configuration
printf "*********************************************************************************\n"
printf "Create PartyB configuration\n"
printf "*********************************************************************************\n\n"

install -m 644 /dev/null ./mynetwork/partyb_node.conf
cat <<EOF >./mynetwork/partyb_node.conf
devMode=true
emailAddress="test@test.com"
myLegalName="O=PartyB, L=London, C=GB"
p2pAddress="partyb:10200"
rpcSettings {
    address="0.0.0.0:10201"
    adminAddress="0.0.0.0:10202"
}
security {
    authService {
        dataSource {
            type=INMEMORY
            users=[
                {
                    password="password"
                    permissions=[
                        ALL
                    ]
                    username=user
                }
            ]
        }
    }
}
cordappSignerKeyFingerprintBlacklist = []
sshd {
  port = 2222
}
EOF

printf "Created in: ./mynetwork/partyb_node.conf\n\n"

printf "*********************************************************************************\n"
printf "COMPLETE\n"
printf "*********************************************************************************\n"
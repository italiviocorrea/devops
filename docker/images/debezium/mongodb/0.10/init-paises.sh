HOSTNAME=`hostname`

mongo localhost:27017/paises <<-EOF
    rs.initiate({
        _id: "rs0",
        members: [ { _id: 0, host: "${HOSTNAME}:27017" } ]
    });
EOF
echo "Initiated replica set"

sleep 3
mongo localhost:27017/admin <<-EOF
    db.createUser({ user: 'admin', pwd: 'senha123', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });
EOF

mongo -u admin -p senha123 localhost:27017/admin <<-EOF
    db.runCommand({
        createRole: "listDatabases",
        privileges: [
            { resource: { cluster : true }, actions: ["listDatabases"]}
        ],
        roles: []
    });

    db.createUser({
        user: 'icorrea',
        pwd: 'senha123',
        roles: [
            { role: "readWrite", db: "paises" },
            { role: "read", db: "local" },
            { role: "listDatabases", db: "admin" },
            { role: "read", db: "config" },
            { role: "read", db: "admin" }
        ]
    });
EOF

echo "Created users"

mongo -u icorrea -p senha123 --authenticationDatabase admin localhost:27017/paises <<-EOF
    use paises;

    db.paises.insert([
        { _id : NumberLong("132"), nome : 'AFEGANISTAO', inicio_vigencia : ISODate("2006-01-01T00:00:00Z") },
        { _id : NumberLong("153"), nome : 'ALAND, ILHAS', inicio_vigencia : ISODate("2017-01-01T00:00:00Z")  },
        { _id : NumberLong("175"), nome : 'ALBANIA, REPUBLICA', inicio_vigencia : ISODate("2006-01-01T00:00:00Z") },
        { _id : NumberLong("200"), nome : 'CURACAO', inicio_vigencia : ISODate("2015-12-07T00:00:00Z")  }
    ]);

EOF

echo "Inserted example data"

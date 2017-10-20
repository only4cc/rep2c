use DBI;
use Data::Dumper;

my $user=''; 
my $password=''; 
my $host="192.168.8.105";

my $dbh = DBI->connect("dbi:Cassandra:host=$host;keyspace=derivacion", $user, $password, { RaiseError => 1 });
my $rows = $dbh->selectall_arrayref("SELECT srv_nombre, tenant_dbid, srv_descripcion FROM servicio");
 
for my $row (@$rows) {
    print Dumper $row;
}

$dbh->do("COPY derivacion.servicio TO '/tmp/servicio.txt';");

 
#$dbh->do("INSERT INTO some_table (id, field_one, field_two) VALUES (?, ?, ?)",
#    { Consistency => "quorum" },
#    1, "String value", 38962986
#);
 
$dbh->disconnect;

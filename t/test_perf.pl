#!/home/rep2c/localperl/bin/perl
#
# Autor:   julio.trumper
# Obetivo: Tests de querys a Cassandra
#

use strict;
use warnings;
use DBI;
use Time::Elapse;

my $MAXITER = 1000;

my $ranis = load_anis();
my %anis = %$ranis;

my $cassuser = 'exp_derivacion';
my $casspass = 'derivacion';

my $host = '10.33.32.151';

my $dbh = DBI->connect("dbi:Cassandra:host=$host;keyspace=derivacion;consistency=one", $cassuser, $casspass, { RaiseError => 1 });

my $p_ani;
my $QUERY = "select * from nc_clientes where ani = $p_ani ";

for ( my $iter = 0; $iter < $MAXITER; ++$iter ) {
    $p_ani = $anis{ int(rand(10000000)) } || 0;
    $QUERY = "select * from nc_clientes where ani = \'$p_ani\' ";
    Time::Elapse->lapse(my $now); 
    my $rows = $dbh->selectall_arrayref($QUERY);
    for my $row (@$rows) {
        print "$iter \t $row->[0]\n";
    }
    print "Time Wasted: $now\n";
    if ( $DBI::errstr  ) {
      print "-------------------------------------------------------\n";
      print $DBI::errstr."\n";
      print "-------------------------------------------------------\n";
    } 
}

$dbh->disconnect;

sub load_anis {
   my $file='lista_ani.txt';
   open(my $data, '<', $file) or die "Error: No pude leer el archivo '$file' $!\n";
   my $l;
   my $i = 0;
   my %anis;
   while ( $l = <$data> ) {
      chomp($l);
      $anis{$i} = $l;
      ++$i;
   }
   close($data);
   return \%anis;
}

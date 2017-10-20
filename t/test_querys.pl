use strict;
use warnings;
use Time::Limit '0.5';
#my $SEG=shift;
my $SENT=shift;

open ( my $P,  "|/cassandra/apache-cassandra-3.9/bin/cqlsh 10.33.32.151 -u exp_derivacion -p derivacion") 
    or die "$!\n";
my $i=0;
print $P "use derivacion\;\n";
while ( 1 ) {
    print $P $SENT;
    ++$i;
    print "$i\t";
}
print "$i iteraciones\n";
close($P);

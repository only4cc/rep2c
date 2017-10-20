use strict;
use warnings;
use Simple::Timer; 

my $MAX=shift; 
my $SENT=shift;

open ( my $P,  "|/cassandra/apache-cassandra-3.9/bin/cqlsh 10.33.32.151 -u exp_derivacion -p derivacion") 
    or die "$!\n";
my $i=0;
print $P "use derivacion\;\n";
my $TIMER = 0; 

timer {
   while ( $i<$MAX ) {
       print $P $SENT;
       ++$i;
   }
   print "$i iteraciones\n";
   close($P);
}

#print "MAX:$MAX SENT:$SENT\n";

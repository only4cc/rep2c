# simula_sec.pl

use strict;
use warnings;

use lib '/home/rep2c/proy/rep2c';
use lib::Passtore qw(get_pass add_secret);

#add_secret('sa','econtact2010');
add_secret('julio','mipassword');

print "User: ";
my $tt = <STDIN>;
chomp($tt);
my $pp = get_pass($tt);
if ( $pp ) {
	print "password: $pp\n";
} else {
	print "no existe.\n";
}


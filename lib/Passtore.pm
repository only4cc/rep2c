package Passtore;
use strict;
use warnings;

use Path::Tiny qw(path);
use Crypt::CBC;

use Exporter qw(import);
 
our @EXPORT_OK = qw(add_secret get_pass);

my $key    = 'econtact';
my $cipher = 'Blowfish';
my $wallet_file='.secreto';   


sub add_secret {
    my $user=shift;
    my $pass=shift;
    open(my $FH, '+>>', $wallet_file ) or die "$!\n";
    print $FH encr($user)."\t".encr($pass)."\n";
    close($FH);
}

sub get_pass {
    my $acc = shift;
    my $pass;
    open(my $FH, '<', $wallet_file ) or die "$! [$wallet_file]\n";
    my $l;
    my @token;
    while( $l=<$FH> ) {
        @token=split(/\t/,$l);
        my $user = decr($token[0]);
        if ( $user eq $acc ) {
            $pass = decr($token[1]);
            $pass =~ s/\n//g;
        }
    }
    close($FH);
    return $pass;
}

sub decr {
    my $todecrypt = shift;
	my $cipher = Crypt::CBC->new( -key    =>  $key,
                                  -cipher =>  $cipher
                                );
	my $plaintext  = $cipher->decrypt($todecrypt);
    return $plaintext;
}

sub encr {
    my $toencrypt = shift;
    my $cipher = Crypt::CBC->new( -key    => $key,
                                  -cipher => $cipher
                                );
    my $ciphertext = $cipher->encrypt($toencrypt);
    return $ciphertext;     
}

1;



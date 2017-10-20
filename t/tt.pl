use Crypt::CBC;
$cipher = Crypt::CBC->new( -key    => 'my secret key',
                           -cipher => 'Blowfish'
                          );
 
$ciphertext = $cipher->encrypt("Thisda");
$plaintext  = $cipher->decrypt($ciphertext);

print "$plaintext $ciphertext\n";

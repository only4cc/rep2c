#!/home/rep2c/localperl/bin/perl
#
# Autor:   julio.trumper
# Obetivo: Replica tabla nc_clientes desde SQL Server a Cassandra (pasa x formato salida CSV)
#

use DBI;
use strict;
use warnings;
use Text::CSV;
use Sys::Hostname;
use Config::Scoped;
use Try::Tiny;
use Log::Log4perl qw(:easy);
use Log::Log4perl::Level ();

my $cid   = 'derivacion.nc_clientes';
my $DEBUG =0;

# Config. logging
Log::Log4perl->easy_init(Log::Log4perl::Level::to_priority( 'INFO' ));

my $log_conf = q(
    log4perl.rootLogger              = DEBUG, LOG1, screen
    log4perl.appender.LOG1           = Log::Log4perl::Appender::File
    log4perl.appender.LOG1.filename  = /home/rep2c/proy/rep2c/log/rep2c.log
    log4perl.appender.LOG1.mode      = append
    log4perl.appender.LOG1.layout    = Log::Log4perl::Layout::PatternLayout
    log4perl.appender.LOG1.layout.ConversionPattern = %d %p %m %n
    log4perl.appender.LOG1.size      = 10485760
    log4perl.appender.LOG1.max       = 7

    log4perl.appender.screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.screen.stderr  = 0
    log4perl.appender.screen.layout  = Log::Log4perl::Layout::PatternLayout
    log4perl.appender.screen.layout.ConversionPattern = %d [%M:%L] %p  %F{2} - %m%n
);
Log::Log4perl::init(\$log_conf);
my $logger = Log::Log4perl->get_logger();

my $file_cfg ="config.cfg";
my $config;
try {
    $config = Config::Scoped->new( file => $file_cfg )->parse;
} catch {
    my $msg = "No se pudo leer la configuracion desde $file_cfg";
    $logger->error($msg);
    avisa("Error proceso de carga", $msg);
    exit -1;
};

my $dir_csv = $config->{dir_cmd}{dircsv};   # Directorio de extraccion de CSV de Clientes
my $file    = $dir_csv."/derivacion.nc_clientes.csv";

my $user=''; 
my $password=''; 
my $host=hostname; 

my $csv = Text::CSV->new({ sep_char => '|' });

open(my $data, "<:encoding(UTF-8)", $file) or die "Error: No pude leer el archivo '$file' $!\n";

my $cassuser = 'exp_derivacion';
my $casspass = 'derivacion';

my $dbh = DBI->connect("dbi:Cassandra:host=$host;keyspace=derivacion;consistency=one", $cassuser, $casspass, { RaiseError => 1 });

# ejecuta la carga de la data
$logger->info( "carga [$cid] iniciada");

my $MAX = 99999999999;
my ($i,$cargados) = (0,0);
while (my $line = <$data>) {
  chomp $line;
  $line =~ s/\'/\"/g;
  if ($csv->parse($line)) {
      my @fields = $csv->fields();
      @fields = map {$_ =~ s/NULL/null/; "'$_'"} @fields;
      $fields[3] =~ s/\'//g;      # Son numeros
      $fields[5] =~ s/\'//g;      # Son numeros
      print "fila $i:".join("|",@fields)."\n"  if $DEBUG;

#     $dbh->do("INSERT INTO derivacion.nc_clientes (rut,ani,tipo_producto,ranking,tipo_cliente,contador_llamadas,campo_01,campo_02,campo_03,campo_04) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
#     @fields

     $dbh->do("INSERT INTO derivacion.nc_clientes (rut,ani,tipo_producto,ranking,tipo_cliente,contador_llamadas,campo_01,campo_02,campo_03,campo_04) VALUES ($fields[0], $fields[1], $fields[2], $fields[3], $fields[4], $fields[5], $fields[6], $fields[7], $fields[8], $fields[9])"
      );

      if ( $DBI::errstr  ) {
        print "-------------------------------------------------------\n";
        print $DBI::errstr."\n";
        $logger->info("$DBI::errstr");
        print "INSERT INTO derivacion.nc_clientes (rut,ani,tipo_producto,ranking,tipo_cliente,contador_llamadas,campo_01,campo_02,campo_03,campo_04) VALUES ($fields[0], $fields[1], $fields[2], $fields[3], $fields[4], $fields[5], $fields[6], $fields[7], $fields[8], $fields[9])\n";
        print "-------------------------------------------------------\n";
      } else {
        ++$cargados;
        if ( $cargados % 500 == 0 ) {
            print localtime()." cargados: $cargados ...\n"; 
        }
      }
  } else {
      warn "Linea no pudo ser parseada: $line\n";
      $logger->info( "Error: [$line]\n");
  }
  ++$i;
  last  if ( $i > $MAX );
}
$logger->info( "carga finalizada");

$dbh->disconnect;

# registra resultado
log_result($cid, $cargados, "filas cargadas [ $cargados ]");
exit 1;

sub log_result {
    my $cid       = shift;
    my $resultado = shift;
    my $texto     = shift;
    my $text_result;
    if ( $resultado < 0 ) {
      $text_result = 'ERROR';
    }
    else {
      $text_result = 'OK';
    }
    my $subj = "carga: [$cid] resultado: $text_result | $texto";
    # print "logeando resultado ...\n[ $subj ]\n" if $DEBUG;   ### Apender
    $logger->error( $subj ) if ( $resultado < 0 );
    $logger->info( $subj ) if ( $resultado >= 0 );
}


sub avisa {
    my $subj=shift;
    my $text=shift;
    my $diravisa = "/home/rep2c/proy/rep2c";
    my $ts = localtime();
    system("$diravisa/avisa.sh \"$host $ts: $subj\" \"$text\"");
    my $facility = 1;
    my $severityName = 3;
    my $logmsg = $subj;
    open(my $fh, "| logger -p $facility.$severityName");
    print $fh $logmsg . "\n";
    close($fh);
}


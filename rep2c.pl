#!/home/rep2c/localperl/bin/perl
#
# Autor:   julio.trumper
# Obetivo: Replica data de querys ejecutadas desde SQL Server a Cassandra (pasa x formato salida CSV)
# Archivo de configuracion config.cfg
# Parametros:
#       keyspace.tabledest  kesyspace y "column family" de DESTINO en Cassandra
#

use strict;
use warnings;

use FindBin;
use FindBin::libs;
use lib '/home/rep2c/proy/rep2c';

use Config::Scoped;
use Try::Tiny;
use Capture::Tiny ':all';
use Sys::Hostname;
use lib::Passtore qw(get_pass);

# Para logging
use Log::Log4perl qw(:easy);
use Log::Log4perl::Level ();

my $DEBUG = 0;    # 1 mas "Verboso" (QA) | 0 no "Verboso" (Produccion)
my $host  = hostname;  # Para logging y alertas x mail

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

my $file_cfg="/home/rep2c/proy/rep2c/config.cfg";
$logger->info( "replicacion iniciada, configuracion desde $file_cfg");

my $config;
try {
    $config = Config::Scoped->new( file => $file_cfg )->parse;
} catch {
    my $msg = "No se pudo leer la configuracion desde $file_cfg";
    $logger->error($msg);
    avisa("Error proceso de carga", $msg);
    exit -1;
};

# Configuraciones
my $logfile = $config->{resultados}{fileresult};    # Archivo de Log
my $dir_csv = $config->{dir_cmd}{dircsv};   # Directorio de extraccion de CSV
my $dircql  = $config->{dir_cmd}{dircql};   # Directorio de los comandos CQLSH
my $dirsql  = $config->{dir_cmd}{dirsql};   # Directorio con los SQLs
my $direrr  = $config->{errores}{direrr};   # Directorio de Errores
my $file_err= $config->{errores}{file_err}; # Errores
my $port    = $config->{nodos}{port};       # Puerto para cqlsh (9042 es el default)
my $ip_sql  = $config->{sqlserver}{ip};     # IP del SQL Server
my $acc_sql = $config->{sqlserver}{cuenta}; # Cuenta SQL Server
my $dirsqlcmd=$config->{odbc}{sqlcmd};      # Directorio del ODBC y sqlcmd
my $ip      = $config->{nodos}{ip};         # IP del Nodo C* donde se cargara

# Otras constantes    
my $extsql="sql";
my $extcql="cql";

# obtiene parametro keyspace.tabla a cargar
my $cid=shift;
if ( ! $cid ) {
   $logger->error( "Error: $0 requiere keyspace.tabla" );
   exit -1;
} 
my ($keyspace,$tname)=split(/\./,$cid);
if ( ! $keyspace or ! $tname ) {
   $logger->error( "Error: $0 requiere keyspace.tabla" );
   exit -1;
} 

#=begin
# ejecuta la extraccion de la data
$logger->info( "extraccion iniciada [$keyspace\.$tname]");
my $res_extraccion = extrae($cid);
$logger->info( "extraccion finalizada");
$res_extraccion =~ s/\n//g;
my ($filas_e, $err_ext)=split(/\|/,$res_extraccion);
$logger->info( "Filas Extraidas: $filas_e");
if ( $filas_e < 0 ) {
    $err_ext =~ s/\n//g;
    my $txt2log = "filas extraidas:[ $filas_e ] | [ $err_ext ]"; 
    log_result($cid,-1,$txt2log);    #registra resultado si hay errores
    my $ts = localtime();
    avisa("Error extraccion $cid", "Error al extraer [ $cid ] Error: [ $err_ext ]");
    $logger->error( "Error extraccion:$cid $ts: Error al extraer [ $cid ] Error: [ $err_ext ]");
    exit -1;
}
#=cut

# ejecuta carga a C*
my $res_carga = carga($cid);
my ($result,$filas_c,$errtxt)=split(/\|/,$res_carga);
my $res_text;
if ( $result == 1 ) {
  $res_text = 'OK';
} else {
  $res_text = 'ERROR';
}

$logger->info( "Resultado Carga: $res_text");
$logger->info( "Filas Cargadas : $filas_c") if ( ! $errtxt );
if ( $errtxt ) {
   print ( "---[ Errores ] ------------------------------------------------------\n");
   $logger->info( "Errores        : \n");
   print ( "$errtxt\n") if ( $errtxt );
   print ( "---------------------------------------------------------------------\n");
}

# registra resultado
log_result($cid,$result,"filas cargadas [ $filas_c ]");
exit 1;

#avisa si hay error
if ( $result < 0 ) {
    my $ts = localtime();
    avisa("Error carga $cid", "Error al cargar [ $cid ] [ $errtxt ]");
    exit -1;
}

sub extrae {
    my $cid = shift;
    my $SQL = get_com_sql($cid);   # carga sentencia sql a ejecutar
    print "[ extrayendo filas ] ====================================\n" if $DEBUG;
    print $SQL if $DEBUG;
    prp();

    my $user   = $acc_sql;
    my $contra = 'Aa123456' || get_pass($user); 
    my $CSVFILE= $dir_csv."/$cid.csv";
    my ($stdout, $stderr) = capture {
         #system("$dirsqlcmd/sqlcmd -S $ip_sql -U $user -P $contra -s \"|\" -W -h-1 -Q \"$SQL\" -o $CSVFILE");
         system("$dirsqlcmd/sqlcmd -S $ip_sql -U $user -P $contra -s \"|\" -W -h-1 -Q \"$SQL\" | egrep -v Changed >$CSVFILE");
    };

    print "Primeras 4 lineas del CSV:\n" if $DEBUG;
    system("head -4 $CSVFILE")  if $DEBUG;   # Solo en Desarrollo 
    print "\n";
    
    print $stdout if $DEBUG;
    if ( $stderr ) {
        my $stderr_2show = $stderr;
        $stderr_2show =~  s/$contra/_________/ig;
        $contra = '                 ';
        # Dado que hubo error lo Logea 
        print "[ errores de extraccion ] ===============================\n" if $DEBUG;
        print $stderr_2show if $DEBUG;
        prp();
        my $ferr;        
        open ( $ferr, '+>>', $file_err ) or do {
            my $subj ="$0: No pude registrar el error en [ $file_err ]\n$!\n";
            warn $subj;
            $logger->info( $subj );
            avisa($subj,$subj);
            close( $ferr);
            exit -1;
        };
        my $ts = localtime();
        print $ferr "$host - $ts: Error extraccion del proceso [ $cid ]:\n";
        print $ferr $stderr_2show."\n\n";
        close( $ferr);
        return "-1|$stderr_2show";
    } else {
        $contra = '                 ';
        # Contar filas extraidas 
        my $filas_extraidas = 0;
        my ($stdout, $stderr) = capture {
          $filas_extraidas =`wc -l < $CSVFILE`;
        };
        return "$filas_extraidas|";
    }
}

sub carga {
    my $cid = shift;
    #print "lee csv desde $dir_csv","\n";
    my $cql_comand_file="$dircql/$cid\.$extcql";
    my $cmd = get_com_cql($cql_comand_file);      # carga sentencia cql a ejecutar
  
    my $CSVFILE= $dir_csv."/$cid.csv";    
    
    $cmd =~ s/%%filename%%/$CSVFILE/ig;   # Reemplaza en el template cql

    print "[ cargando ] ========================================\n" if $DEBUG;
    print "$cmd\n" if $DEBUG;
    prp();

    my $IP  =$ip;
    my $PORT=$port;
    my $cassuser = 'exp_derivacion';
    my $casspass = 'derivacion';

    my $CQLSH="/cassandra/apache-cassandra-3.9/bin/cqlsh -u $cassuser -p $casspass $IP $PORT ";

    my ($stdout, $stderr) = capture {
        open my $in, "| $CQLSH ";
        print $in $cmd;
        close( $in );
    };

    print "[ salida: stdout ] ======================================\n" if $DEBUG;
    print $stdout if $DEBUG;
    print $stdout ;
    prp();

    # Mueve errores a directorio de errores "err"
    system("mv /home/rep2c/proy/rep2c/import_*.err* $direrr/ 2>/dev/null");
    system("mv /home/rep2c/import_*.err* $direrr/ 2>/dev/null");   

    $stdout =~ /(\d+) rows imported/;
    my $rows = $1 ||'0';
    if ( ! $rows or $rows == 0 ) { 
        return "-1|$rows|$stderr";
    } else {
        print "[ filas cargadas ]=======================================\n" if $DEBUG;
        print "Se cargaron [ $rows ] filas ...\n"  if $DEBUG;
        prp();
        return "1|$rows|";
    }
}

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

sub get_com_cql {
   my $cql_comand_file = shift;
   open( my $fh, '<', $cql_comand_file ) or do {
       my $subj ="$0: No pude leer $cql_comand_file\n$!\n";
       warn $subj;
       $logger->info( $subj );
       avisa($subj,$subj);
       exit -1;
   };
   my $l;
   my $comand;
   while ( $l=<$fh> ) {
       $comand .= $l;
   }
   close( $fh );
   return $comand;
}

sub get_com_sql {
   my $cid = shift;
   my $sql_comand_file="$dirsql/$cid\.$extsql";
   open( my $fh, '<', $sql_comand_file ) or do {
       my $subj ="$0: No pude leer $sql_comand_file\n$!\n";
       warn $subj;
       $logger->info( $subj );
       avisa($subj,$subj);
       exit -1;
   };
   my $comand;
   my $l;
   while ( $l=<$fh> ) {
      $comand .= $l;
   }
   close( $fh );
   return $comand;
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

sub prp {
    print "=========================================================\n" if $DEBUG;
}


CREATE KEYSPACE derivacion
  WITH REPLICATION = { 
   'class' : 'SimpleStrategy', 
   'replication_factor' : 2 
  };


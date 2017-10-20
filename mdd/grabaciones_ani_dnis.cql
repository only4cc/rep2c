use derivacion;

create table grabaciones_ani_dnis (
	ani varchar,				
	dnis varchar,				
	cuenta int,					
	primary key ( ani, dnis )
);

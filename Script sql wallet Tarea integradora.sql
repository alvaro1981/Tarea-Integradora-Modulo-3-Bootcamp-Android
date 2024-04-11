CREATE DATABASE IF NOT EXISTS wallet_final;
use wallet_final;

-- crear tabla monedas 
CREATE TABLE monedas(
moneda_Id int primary key auto_increment,
nombre_moneda varchar(50) not null,
simbolo_moneda varchar(5)
);

-- ingreso registros a la tabla usuario
insert into monedas(nombre_moneda,simbolo_moneda)
values
('dolar estadounidense','$'),
('euro','EUR'),
('libra', 'GBP');

-- creacion tabla usuarios 
create table Usuarios (
user_id int primary key  auto_increment,
nombre varchar(100) not null,
correo_electronico varchar(80) NOT NULL,
contrasenia varchar(100) not null);

-- ingreso resgistros a la tabla usuario
insert into usuarios( nombre,correo_electronico, contrasenia) values
("Juan Perez Gonzales","correo1@ejemplo.cl",sha2('123456',256)),
("Julito Videla riveros","correo2@ejemplo.cl",sha2('234567',256)),
("Pedro Engel zapata","correo3@ejemplo.cl",sha2('345678',256)),
("Kan Saito Toriyama","correo4@ejemplo.cl",sha2('456789',256));

-- crear tabla cuenta corriente
create table cuentasCorrientes(
cuenta_corriente_id int primary key auto_increment, 
saldo decimal(10,2) default 0,
fecha_creacion date not null,
user_id int ,
foreign key  (user_id) references Usuarios(user_id)
);

insert into cuentascorrientes(saldo, fecha_creacion, user_id) values
(1500000, '2024-06-01',1),
(2000000, '2024-06-06',2),
(2500000, '2024-06-07',3),
(1000000, '2024-06-09',4);

-- crear tabla transacciones 
create table transacciones(
transaccion_id int primary key auto_increment,
importe decimal(10,2) not null,
fecha_transaccion timestamp default current_timestamp,
sender_user_id int not null,
receiver_user_id int not null,
moneda_id int not null,
-- cuenta_corriente int not null,
foreign key(sender_user_id) references Usuarios(user_id),
foreign key(receiver_user_id) references Usuarios(user_id),
foreign key(moneda_id) references monedas(moneda_id)
-- foreign key(cuenta_corriente) references cuentascorrientes(user_id) segun yo esta esta demas 
);

insert into transacciones( importe, sender_user_id, receiver_user_id, moneda_id) values
(50000  ,  1,2,1),
(100000 ,  3,4,2),
(300000 ,  3,1,3),
(200000 ,  2,4,2),
(150000 ,  4,1,1),
(200000 ,  2,3,3),
(120000 ,  1,2,2),
( 50000 ,  4,2,1);


-- Consulta para obtener el nombre de la moneda elegida por un usuario específico

select monedas.nombre_moneda as Moneda , transacciones.sender_user_id  from
transacciones inner join monedas on transacciones.moneda_id = monedas.moneda_id
where transacciones.sender_user_id =1;

-- Consulta para obtener todos los usuarios registrados
select nombre  from wallet_final.usuarios ;

-- Consulta para obtener todas las monedas registradas
select nombre_moneda as MONEDA , simbolo_moneda as SIMBOLO from wallet_final.monedas;

-- cosulta para todas las transacciones registradas 
select transaccion_id , importe , fecha_transaccion from transacciones;

-- Consulta para obtener todas las transacciones realizadas por un usuario específico
select transaccion_id, fecha_transaccion from transacciones where
sender_user_id = 1 or receiver_user_id = 1 ;

-- Consulta para obtener todas las transacciones recibidas por un usuario específico
select transaccion_id, fecha_transaccion from transacciones 
where receiver_user_id = 1 ;

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico

update usuarios  SET  correo_electronico = 'kan_saito_tori@test.com' 
WHERE user_id = 4;

select correo_electronico from usuarios where user_id = 4;


-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
select * from transacciones;
DELETE from  transacciones  WHERE transaccion_id = 4;
select * from transacciones;

-- Sentencia para DDL modificar el nombre de la columna correo_electronico por email
ALTER TABLE wallet_final.usuarios CHANGE correo_electronico email  varchar(100) not null;
select * from usuarios;

-- consultar todos los usuarios y sus saldo acutales 



   
   




























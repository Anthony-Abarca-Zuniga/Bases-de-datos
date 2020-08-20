--Se crea la base de datos 

create database Practica_1_Antony
ON 

--Se le dan las especificaciones a la base de datos 
( NAME = Practica_1_Antony, 

    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Practica_1_Antony.mdf', 

    SIZE = 25MB, 

    MAXSIZE = 50MB, 

    FILEGROWTH = 10MB ) 

LOG ON 

( NAME = Practica_1_Antonylog, 

    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Practica_1_Antony.ldf', 

    SIZE = 25MB, 

    MAXSIZE = 50MB, 

    FILEGROWTH = 10MB ) 

go
--Se crea el esquema 
create schema practica1
go

use Practica_1_Antony

--Se crea la tabla de la entidad matricula
create table practica1.tbMatricula(
		id_matricula int primary key identity(1,1),
		tipo_matricula varchar(50) not null,
		fecha_registro datetime not null,
		estado int not null,
	)
	go

	--Se crea la tabla de la entidad estudiante 
create table practica1.tbEstudiante(
		id_usuario int primary key identity(1,1),
		nombre varchar(50) not null,
		pApellido varchar (50) not null,
		sApellido varchar (50) not null,
		identificacion varchar(20) not null,
		id_matricula int,
		constraint FK_tbMatricula_matricula_id foreign key (id_matricula) references practica1.tbMatricula(id_matricula)
	)
	go

	--Se crea la tabla de la tabla curso
	create table practica1.tbCurso(
		id_curso int primary key identity(1,1),
		nombre varchar(50) not null,
		descripcion varchar(150) ,
		fecha_registro datetime not null,
		estado int not null,
		
	)
	go

	--Se crea la tabla de la materia 
	create table practica1.tbMateria(
		id_materia int primary key identity(1,1),
		nombre varchar(50) not null,
		nrc varchar (50) not null,
		id_curso int not null,
		constraint FK_tbCurso_curso_id foreign key (id_curso) references practica1.tbCurso(id_curso)
	)
	go

	
	--Se crea la tabla de la intermedia de la tabla curso y matricula
	create table practica1.tbCurso_matricula(
		id_curso_matricula int primary key identity(1,1),
		id_cursoM int,
		id_matriculaC int,
		constraint FK_tbCurso_cursoM_id foreign key (id_cursoM) references practica1.tbCurso(id_curso),
		constraint FK_tbMatricula_matriculaC_id foreign key (id_matriculaC) references practica1.tbMatricula(id_matricula)
	)
	go

	--Se crea la tabla requerida en el documento 
	create table practica1.Logs(
	id int primary key identity(1,1),
	fecha datetime not null,
	texto varchar(25),
	usuario int 
	)
	go

	--Procedimientos almacenados
	
	--Procedimiento de insertar en la tabla  curso
	create procedure practica1.Curso(@nombre varchar(50),@descripcion varchar(150),@fecha_registro datetime,@estado int)
	as
	begin 
		
		insert into practica1.tbCurso(nombre,descripcion,fecha_registro,estado)
		values(@nombre,@descripcion,@fecha_registro,@estado);
		end
		go


		--Proceso de eliminar en la tabla curso
		create procedure practica1.EliminarCurso(@nombre varchar(50),@descripcion varchar(150),@fecha_registro datetime,@estado int)
			as
			begin 
		
			insert into practica1.tbCurso(nombre,descripcion,fecha_registro,estado)
			values(@nombre,@descripcion,@fecha_registro,@estado);
			end
		go

		--Proceso de select en la tabla curso 
		CREATE PROCEDURE practica1.selectCurso
			AS 
			begin
			SELECT * FROM practica1.tbCurso WHERE estado = 1
			end
		GO
		

		--Proceso de modificar de la tabla curso
CREATE PROCEDURE practica1.updateCurso  (@id_curso INT,@nombre VARCHAR(50), @descripcion VARCHAR(150))
		AS 
		begin
		UPDATE practica1.tbCurso SET  
       nombre = @nombre,
       descripcion = @descripcion
       WHERE id_curso= @id_curso 
	   end

GO

create procedure practica1.eliminarCurso(@id_curso int )
as
begin
set nocount on;
delete from practica1.tbCurso where id_curso = @id_curso;
end
go



-- Vistas

--Muestra los nombres de la tabla curso
	create view practica1.vista1_Curso as 
	select nombre from practica1.tbCurso
	go

	--Muestra solo los campos de nombre donde coincida con la igualdad en nombre
	create view practica1.vista1_Curso_nombre as 
	select  nombre='Algebra' from practica1.tbCurso
	go



	--Disparador

	--Este  trigger hace que muestre un mensaje de error si la cantidad de letras sdel nombre de la tabla curso es igual a 10
	--esto sucede a la hora a l insercion 
	create trigger practica1.tbCurso_inser on practica1.tbCurso
after insert
as
begin
set nocount on;
	 if exists(select 1 from inserted where len(inserted.nombre)=10)
	 begin
		RAISERROR('Valor equivocado',16,1)
		rollback transaction;
		return;
	 end
end
 go

 --Despues de una insercion va ir a registrar la actividad en la tabla logs 
 create trigger practica1.tbLogs_insert on practica1.Logs
after insert
as
begin
insert into [practica1].[Logs]
values (GETDATE(),'inserto',1)
end
 go


	
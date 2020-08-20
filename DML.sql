select * from sys.procedures
declare @fechaInput datetime = (select GETDATE())
exec practica1.Curso @nombre = 'Algebra',@descripcion = 'mate',@fecha_registro = @fechaInput,@estado = 1


select * from[practica1].[tbCurso_matricula];

insert into [practica1].[tbMateria]
values ('Matematica','MAT402',2)

insert into [practica1].[tbMatricula]
values ('Todo pago',GETDATE(),1)

insert into[practica1].[tbEstudiante]
values ('Antony','Abarca','Zuniga','304810947',1)

insert into[practica1].[tbCurso_matricula]
values (2,1)
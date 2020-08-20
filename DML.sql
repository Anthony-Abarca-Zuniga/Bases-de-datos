insert into [practica1].[tbCurso]([nombre],[descripcion],[fecha_registro],[estado])
values ('Sistemas operativos','dificil',GETDATE(),1);

insert into [practica1].[tbEstudiante]([nombre],[pApellido],[sApellido],[identificacion],[id_matricula])
values ('Antony','Abarca','Abarca',304810947,1);

insert into [practica1].[tbMateria]([nombre],[nrc],[id_curso])
values ('Programacion','AFR85',2);

insert into [practica1].[tbMatricula]([tipo_matricula],[fecha_registro],[estado])
values ('Pago',GETDATE(),1);
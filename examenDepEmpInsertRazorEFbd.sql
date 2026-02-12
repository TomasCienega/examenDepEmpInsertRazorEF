create database examenDepEmpInsertRazorEF
use examenDepEmpInsertRazorEF

create table Departamento
(
	idDepartamento int identity(1,1) not null,
	nombreDepartamento varchar(50) not null,
	constraint PK_Departamento primary key (idDepartamento)
)

create table Empleado
(
	idEmpleado int identity(1,1) not null,
	nombreEmpleado varchar(100) not null,
	idDepartamento int not null,
	constraint PK_Empleado primary key (idEmpleado),
	constraint FK_Empleado_Departamento foreign key (idDepartamento)
										references Departamento(idDepartamento)
)

--insert into Departamento(nombreDepartamento) values('TI'),('RH'),('VENTAS'),('COMPRAS')
--insert into Empleado(nombreEmpleado,idDepartamento)
--values('Tomas',4),('Alan',1),('Carlos',2),('Adrian',3)
--select * from [dbo].[Departamento]
--select * from [dbo].[Empleado]

--=================== CREAR PROCEDIMIENTOS ALMACENADOS PARA DEPARTAMENTOS =========================

create procedure sp_ListarDepartamentos
as
begin
	select idDepartamento,nombreDepartamento from Departamento
end

--=================== CREAR PROCEDIMIENTOS ALMACENADOS PARA EMPLEADOS =============================

create procedure sp_ListarEmpleados
as
begin
	select e.idEmpleado,e.nombreEmpleado,d.idDepartamento,d.nombreDepartamento 
	from Empleado e inner join Departamento d 
	on e.idDepartamento = d.idDepartamento
end

create procedure sp_ListarEmpleadosPorDep
(
	@idDepartamento int
)
as
begin
	select e.idEmpleado,e.nombreEmpleado,d.idDepartamento,d.nombreDepartamento
	from Empleado e inner join Departamento d
	on e.idDepartamento = d.idDepartamento
	where d.idDepartamento = @idDepartamento
end

create procedure sp_InsertarEmpleado
(
	@nombreEmpleado varchar(100),
	@idDepartamento int
)
as
begin
	insert into Empleado(nombreEmpleado,idDepartamento)values(@nombreEmpleado,@idDepartamento)
end


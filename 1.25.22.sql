--baza de date CompanieIT
--tema bazei de date: evidenta angajatilor la compania Moldtelecom
CREATE DATABASE CompanieIT
USE master
DROP DATABASE CompanieIT
USE CompanieIT --accesam baza de date
CREATE TABLE Departamente
(
    idDept int PRIMARY KEY identity(1, 1) --identificatorul departamentului[PK]
    ,Dept varchar(15)         --denumirea departamentului
    ,Adresa varchar(15)       --strada departamentului
    ,Oras varchar(15)         --orasul departamentului
)
CREATE TABLE Functii
(
    idFunctie int PRIMARY KEY identity(1,1)
   ,DenFunctie varchar(20)
   ,Salariu smallint
)
CREATE TABLE Angajati
(
    idAngajat int PRIMARY KEY identity(1, 1)      --identificatorul angajatului[PK]
    ,Nume varchar(15)
    ,Prenume varchar(15)
    ,Birou smallint           --nr biroului
    ,Stagiu smallint         --clasa de salarizare
    ,idDept int--foreign key
    ,idFunctie int
)
--stabilim relatii intre tabele
ALTER TABLE Angajati
    ADD CONSTRAINT FK_Angajati_idFunctie
        FOREIGN KEY (idFunctie) REFERENCES Functii (idFunctie)
ALTER TABLE Angajati
    ADD CONSTRAINT FK_Angajati_idDept
        FOREIGN KEY (idDept) REFERENCES Departamente (idDept)
--inseram valori in tabele
INSERT INTO Departamente( Dept, Adresa, Oras)
VALUES ( 'Administratie', 'Independentei', 'Iasi')
       ,( 'Productie', 'Primaverii', 'Bucuresti')
       ,( 'Distributie', 'Central', 'Focsani')
       ,( 'Planificare', 'Nicolina', 'Iasi')
       ,( 'Cercetare', 'Trandafirului', 'Cluj')

INSERT INTO Angajati( Nume, Prenume, Birou, Stagiu, idDept,idFunctie)
VALUES ( 'Ionescu', 'Maria', 10, 1, 1,2)
      ,( 'Popescu', 'Ion', 20, 15, 2,5)
      ,( 'Danilov', 'Stefan', 20, 20, 1,7)
      ,( 'Dumitrescu', 'Vasile', 16, 20, 3,8)
      ,( 'Ionescu', 'Ion', 14, 7, 4,10)
      ,( 'Manole', 'Radu', 7, 0, 4,6)
      ,( 'Luca', 'Doru', 75, 5, 1,7)
      ,( 'Vasile', 'Alina', 20, 3, 2,11)
	  
	  /* Inserați în câmpul DenFuncție valorile: manager, asistent
	  manager, contabil, contabil șef, operator, administrator BD, 
	  technician de site-uri WEB, programator, 
	  tehnician rețelistică, technician securitate, tester)*/
INSERT INTO Functii (DenFunctie,Salariu)
VALUES
	   ('Manager',3000)
	  ,('Asistent Manager',4000)
	  ,('Contabil',2000)
	  ,('Contabil Sef',5000)
	  ,('Operator',2500)
	  ,('Administrator BD',7000)
	  ,('Tehnician Web',9000)
	  ,('Programator',11000)
	  ,('Tehnician Realistica',11000)
	  ,('Tehnician Securitate',2000)
	  ,('Tester',14000)
	  SELECT *FROM Functii
  
	  /*SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);
*/
SELECT *FROM Departamente
SELECT *FROM Angajati
--interogarea bazei de date(10 sarcini conform resursei oferite de profesor)

--Interogarea 1 -S ă se găsească prenumele angajaţilor cu numele Ionescu
--care lucrează în departamentele Administratie sau
--Productie. 
select Prenume
from Angajati
where Nume='Manole' and (idDept=1 or idDept=2)
--Interogarea 2 -Să se găsească Salariul angajaţilor cu numele Manole
--care lucrează în departamentele Planificare sau distributie
select Salariu
from Angajati
where Nume='Manole' and (idDept=3 or idDept=4)
--Interogarea 3 Să se găsească birourile în care locuiesc persoanele cu numele Ionescu
select Birou
from Angajati
where Nume = 'Ionescu' 
--Interogarea 4: Se consideră baza de date de mai sus. Să se găsească
--toţi angajaţii ce au acelaşi nume (dar prenume diferite)
select a1.Nume, a1.Prenume
from Angajati a1, Angajati a2
where a1.Nume = a2.Nume and
 a1.Prenume <> a2.Prenume 
 --Inerogarea 5 : Să se găsească numărul angajaţilor din departamentul Productie.
 select count (*)
from Angajati
where IdDept = 2 
 --Inerogarea 6 : Să se găsească numărul valorilor distincte pentru atributul
--Salariu pentru toţi angajaţii din tabela ANGAJAŢI. 
select count (distinct Salariu)
from Angajati 
--Inerogarea 7 : Să se găsească numărul de linii din tabelul ANGAJATI
--care au valori diferite de NULL pentru atributul Salariu.
select count (all Salariu)
from Angajati
--Inerogarea 8 : Să se găsească salariul maxim, mediu şi minim pentru toţi
--angajaţii din tabela ANGAJAŢI. 
select max(Salariu) SalariuMaxinim, avg(Salariu) as SalariuMediu, min(Salariu) "Salariu Minim"
from Angajati 
--Inerogarea 9 : Să se găsească salariul maxim pentru angajaţii care
--lucrează într-un departament din Bucuresti. 
select max(Salariu) SalariuMaxim
from Angajati a, Departamente d
where a.IdDept = d.idDept and Oras = 'Bucuresti'
--iNTEROGAREA 10 : Să se găsească suma salariilor angajaţilor din acelaşi
--departament.
select idDept,  sum(Salariu)
from Angajati
group by IdDept

select nume,prenume,Adresa from angajati a
	  inner join departamente d
	  on a.idDept=d.idDept

-- afisati numele ,prenumele, salariul si departamentul
		select nume,prenume,Dept as departament,birou as 'biroul angajatului' from angajati as a
			  full join departamente as d
			  on a.idDept=d.idDept
			  where birou=20
-- afisati angajatii,salariul care se integreaza intre 
select nume,prenume,salariu from angajati a
	  inner join departamente d
	  on a.idDept=d.idDept
	  WHERE salariu BETWEEN 45 AND 50;
	 -- 12: Să se găsească numărul angajaţilor din departamentul Productie. 
	 select count (*)
from Angajati
 
	  --13: Să se găsească numărul valorilor distincte pentru atributul
--Salariu pentru toţi angajaţii din tabela ANGAJAŢI.
	  select count (distinct Salariu)
from Angajati
--14: Să se găsească numărul de linii din tabelul ANGAJATI
--care au valori diferite de NULL pentru atributul Salariu. 

select count (Salariu)
from Angajati 
where Salariu>45
--15: Să se găsească salariul maxim, mediu şi minim pentru toţi
--angajaţii din tabela ANGAJAŢI. 
select max(Salariu) as"Salariul maxim", avg(Salariu)  as"Salariul mediu", min(Salariu) as"Salariul minim"
from Angajati 

--16: Să se găsească salariul maxim pentru angajaţii care
--lucrează într-un departament din Iasi.                ASTA
select max(Salariu)
from Angajati ag , departamente as dp
where ag.idDept = dp.Dept and Oras = 'Iasi' 
--17: Să se găsească suma salariilor angajaţilor din acelaşi
--departament.
select departamente as  d, sum(Salariu) as s
from Angajati

--18: Să se găsească departamentele în care salariul mediu al
--angajaţilor din biroul 20 este mai mare ca 25.
select idDept
from Angajati
where Birou = '20'
group by idDept
having avg(Salariu) > 25 
--19: Să se găsească angajaţii ce lucrează într-un departament ASTA
--din Iaşi.
select Nume, Prenume
from Angajati
where iddept = any (select Dept from Departamente where Oras = 'Iasi')
--Să se găsească departamentele în care nu lucrează nici
--un angajat cu numele Ionescu.
Select Dept 
from DepartamentE
where Dept <> all (select Dept
 from Angajati
 where Nume = 'Ionescu')
--Interogarea 21: Să se găsească departamentele în care lucrează angajaţii
--ce câştigă cel mai mare salariu.
select idDept
from Angajati
where Salariu = any (select max(Salariu)
 from Angajati)
--22: Să se găsească persoanele care au acelaşi nume şi
--prenume, dar coduri diferite.
select *
from Persoana P where exists (select * from Persoana P1
 where P1.Nume = P.Nume
 and P1.Prenume = P.Prenume
 and P1.Cod <> P.Cod )
-- Interogarea 23: Să se găsească toate persoanele ce nu au omonime.
select *
from Persoana P
where (Nume, Prenume) not in (select Nume, Prenume
 from Persoana P1
 where P1.Cod <> P.Cod ) 




 ----------------------------------------------
 --Afisati acei angajați care activează în departamentul cu identificatorul   
 select Nume ,Prenume 
from Angajati
where IdDept = 2 
	  
	--Afisati numele angajatilor, departamentul si salariul acestora
	select nume,prenume, dept,salariu "Salariul angajatului"
	from Angajati as a 
	inner join departamente as d on a.idDept=d.idDept
    inner join Functii as f on a.idFunctie=f.idFunctie
	--Selectati numele angajaților si orașul în care aceștea activează
		select nume,prenume, Oras
		from Angajati as a 
		inner join departamente as d on a.idDept=d.idDept
--Cautati persoana cu numele “Danilov” si afisati datele acesteia
select Nume, Prenume, Birou, Stagiu,DenFunctie,Salariu,Dept, Adresa, Oras
from Angajati as a 
	inner join departamente as d on a.idDept=d.idDept
    inner join Functii as f on a.idFunctie=f.idFunctie
	where nume='Danilov'
	
create database clinique;
use  clinique;
create table Patient(
NoPatient int primary key auto_increment not null,
NoAssSociale int,
Nom varchar(40),
Prenom varchar(20)
);
create table Medecin(
NoMedecin int primary key not null,
Nom varchar(40),
Prenom varchar(20)
);
create table Diagnostic(
NoDiagnostic int primary key,
description text
);
create table Traitement(
NoTraitement int primary key,
description text
);
create table Entree_Dossier(
NoDossier int primary key not null,
Datevisite date,
NoPatient int,
NoMedecin int,
NoTraitement int,
NoDiagnostic int,
foreign key (NoPatient) references Patient (NoPatient),
foreign key (NoMedecin) references Medecin (NoMedecin),
foreign key (NoTraitement) references Traitement (NoTraitement),
foreign key (NoDiagnostic) references Diagnostic (NoDiagnostic)
);
#Q2 
alter table diagnostic 
drop column description ;
alter table diagnostic add column description varchar(255);
#Q3 
alter table  Patient add column Notelephone varchar(15);
alter table Patient add constraint chk_Notelephone check (Notelephone like'__________');
alter table  Patient add column DateNaissance date;
#Q4
insert into Patient values(111111,12345678,'Delisle','Pierre','1977-04-11',2233443322),
(111112,87654321,'Delise','Sylvain','1975-08-21',3322443355),
(111113,23234433,'Tremblay','Sylvain','1980-01-30',4182751232);

insert into Medecin values(12345,'Lajoie','Rene'),
(67899,'Dion','Celine');

insert into Diagnostic values(1,'Migraine'),
(2,'Fracture au bras');

insert into Traitement values(1,'2 cachets a toutes les 4 heurs'),
(2,'Placer le bras dans un platre');

insert into Entree_Dossier values(1,'2008-04-25',111111,12345,1,1),
(2,'2008-04-26',111111,67899,2,2),
(3,'2008-04-26',111111,12345,1,2),
(4,'2008-04-26',111112,67899,1,1);
select * from Entree_Dossier;
#Q5
select * from Patient;
select Nom, Prenom from Patient;
select Nom, Prenom from Patient where Nom = 'Delisle';
select Nom, DateNaissance from Patient where year(DateNaissance) > 1976;
select Nom from Patient;
select Nom from Patient order by Nom asc;
select NoDossier, NoPatient, NoMedecin  from Entree_Dossier where NoPatient = 111111 and NoMedecin = 67899;
#Q6
select E.NoDossier, E.Datevisite, P.NoPatient, P.NoAssSociale, P.Nom, P.prenom from Entree_Dossier E inner join Patient P on E.NoPatient = P.NoPatient;
select E.NoDossier, E.Datevisite, P.NoPatient, P.NoAssSociale, P.Nom, P.prenom from Entree_Dossier E inner join Patient P on E.NoPatient = P.NoPatient where P.Nom = 'Delisle' and P.prenom = 'Pierre';
select P.Nom, P.Prenom,T.description as descriptionTraitement from Traitement T join Entree_Dossier E  on T.NoTraitement = E.NoTraitement join Patient P on E.NoPatient = P.NoPatient where P.Nom = 'Delisle' and P.prenom = 'Pierre'; 
select P.Nom, P.Prenom from Entree_Dossier E join Patient P on E.NoPatient = P.NoPatient join Medecin M on E.NoMedecin = M.NoMedecin where M.Nom = 'Lajoie' and M.prenom = 'Rene' and E.DateVisite = '2008-04-26' order by P.DateNaissance asc;


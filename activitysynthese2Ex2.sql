create database Bibliotheque;
use Bibliotheque;
create table Specialite (
NoSpecialite int primary key auto_increment,
Description text
);
create table Section(
NoSection int primary key,
Emplacement varchar(45),
Description text
);
create table Livre(
CodeISBN int primary key,
Titre varchar(45),
NoSpecialite int,
NoSection int,
foreign key (NoSpecialite) references Specialite (NoSpecialite),
foreign key (NoSection) references Section (NoSection)
);
create table Fournisseur (
NoFournisseur int primary key,
Nom varchar(45)
);
create table Exemplaire(
NoExemplaire int primary key,
CodeISBN int,
NoFournisseur int,
foreign key (CodeISBN) references Livre (CodeISBN),
foreign key (NoFournisseur) references Fournisseur (NoFournisseur)
);
create table Abonne (
NoAbonne int primary key,
Nom varchar(45),
Prenom varchar(45)
);
create table Carte (
NoCarte int primary key,
DateDebut date,
DateFin date,
NoAbonne int,
foreign key (NoAbonne) references Abonne (NoAbonne)
);
create table Emprunt (
DateLocation date,
DateRetour date,
NoExemplaire int,
NoCarte int,
foreign key (NoExemplaire) references Exemplaire (NoExemplaire),
foreign key (NoCarte) references Carte (NoCarte)
);
#Q1
select L.CodeISBN, L.Titre, S.NoSection, S.Description as descriptionSection from Livre L join Section S on L.NoSection = S.NoSection where S.NoSection in (1,4);
#Q2
alter table Abonne add column addresse varchar(120);
#Q3
insert into Fournisseur (NoFournisseur, Nom) values (1,'Livres du Quebec inc.');
#Q4
select A.Nom, A.Prenom from Abonne A join Carte C on A.NoAbonne = C.NoAbonne where year(C.DateDebut) = 2012 or year(C.DateFin) = 2012;
#Q5
select L.CodeISBN, L.Titre from Emprunt E join Exemplaire Ex on E.NoExemplaire = L.CodeISBN where E.DateLocation = '2012-04-28' order by L.Titre asc;
#Q6
select A.Nom, A.Prenom from Abonne A join Carte C on A.NoAbonne = C.NoAbonne join Emprunt E on C.NoCarte = E.NoCarte join Exemplaire Ex on E.NoExemplaire = Ex.NoExemplaire join Livre L on Ex.CodeISBN = L.CodeISBN where L.Titre = 'Nos amis les francais';
#Q7
update Carte set DateFin = '2012-05-25' where DateFin <= '2012-04-25';
#Q8 
select L.Titre from Emprunt E join Exemplaire Ex on E.NoExemplaire = Ex.NoExemplaire join Livre L on Ex.CodeISBN = L.CodeISBN join Section S on L.NoSection = S.NoSection join Specialite Sp on L.NoSpecialite = Sp.NoSpecialite 
where S.Description = 'Science-fiction' and month(E.DateLocation) = 4 and year(E.DateLocation) = 2012;
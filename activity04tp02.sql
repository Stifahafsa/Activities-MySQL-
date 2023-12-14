create database stylistte;
use stylistte;
create table ProduitFini(
CodProFini int primary key,
NomPro varchar(30),
QteEnStock int
);
create table Mouvement(
NumMvt int primary key not null,
TypeMvt text,
Quantite int,
CodProFini int,
foreign key (CodProFini) references ProduitFini (CodProFini)
);
create table ProduitBrut(
CodProdBrut int primary key,
NomProdBrut varchar(30),
PrixAchat decimal,
NumFour int,
foreign key (NumFour) references Fournisseur (NumFour)
);
create table Fournisseur(
NumFour int primary key,
RsFour int,
AdrFour text,
NbrProduitsfournis int
);
create table composition(
CodProdBrut int,
CodProFini int,
foreign key (CodProFini) references ProduitFini (CodProFini),
foreign key (CodProdBrut) references ProduitBrut (CodProdBrut),
primary key (CodProdBrut,CodProFini)
);
#Q2
select Pb.CodProdBrut ,count(*) as nombreProduitBruts from ProduitBrut Pb inner join composition C on Pb.CodProdBrut = C.CodProdBrut group by Pb.CodProdBrut ;
#Q3
select max(PrixAchat) as maximum from ProduitBrut;
#Q4
select CodProFini,count(*) as Produits_Finis from composition group by CodProFini having count(*)>=2;
#Q5
select f.* from Fournisseur f inner join ProduitBrut Pb on f.NumFour = Pb.NumFour where Pb.NumFour = f.RsFour;
#Q6
select m.* from Mouvement m inner join ProduitFini Pb on m.CodProFini = Pb.CodProFini where Pb.NomPro = '?' and m.TypeMvt = 'sortie';
#Q7
select m.* from Mouvement m inner join ProduitFini Pb on m.CodProFini = Pb.CodProFini;
#Q8
select m.CodProFini, Pf.QteEnStock, if(m.TypeMvt='Entree', sum(m.Quantite), 0) as Quantite_Entree, if(m.TypeMvt='Sortie', sum(m.Quantite), 0) as Quantite_Sortie, (Quantite_Entree - Quantite_Sortie) as Diff, if(Diff > Pf.QteEnStock, 'Stock ok', 'Probleme de stock') as Difference from Mouvement m inner join ProduitFini Pf on m.CodProFini = Pf.CodProFini group by m.CodProFini, Pf.QteEnStock;
#Q9-Q10
select C.CodProdBrut, sum(C.QteUtilise * Pb.PrixAchat) from composition C left join ProduitBrut Pb on C.CodProdBrut = Pb.CodProdBrut group by C.CodProdBrut, sum(C.QteUtilise * Pb.PrixAchat);




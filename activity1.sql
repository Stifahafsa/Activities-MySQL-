create database gestion_commercial;
use  gestion_commercial;
create table clients(
numclient int primary key not null,
raisonsocial varchar(45),
adresseclient varchar(45),
villeclient varchar(45),
telephone varchar(45)
);
create table commande(
numcommande int primary key ,
datecommande text,
numclient int,
foreign key (numclient) references clients(numclient)
);
create table produit(
refproduit int primary key,
nomproduit text,
prixunitaire int,
Qtestockee int,
Disponible text
);
create table details_commande(
Qtecommandee int,
numcommande int,
refproduit int,
foreign key (numcommande) references commande(numcommande),
foreign key (refproduit) references produit(refproduit),
primary key (numcommande,refproduit)
);
Q1)   select * from clients;
Q2)   select * from produit;
Q3)   select numclient,villeclient from clients; 
Q4)   select numclient,raisonsocial,telephone from clients;
Q5)   select * from clients where numclient=15;
Q6)   select * from clients order by raisonsocial desc;
Q7)   select * from clients order by raisonsocial desc, villeclient asc; 
Q8)   select * from clients where raisonsocial like 'S%';
Q9)   select * from clients where raisonsocial like '%E';
Q10)  select * from clients where raisonsocial like 'A%' and '%E';
Q11)  select * from clients where raisonsocial like 'A%' or '%E';
Q12)  select * from clients where raisonsocial like '%AR%';
Q13)  select * from clients where raisonsocial not like 'Souss gaz';
Q14)  select * from clients where raisonsocial not like 'R%';
Q15)  select * from clients where raisonsocial like 'A%' and '%E';
Q16)  select * from clients where raisonsocial like '_______';
Q17)  select * from clients where raisonsocial like '_R%';
Q18)  select * from clients where raisonsocial like '_R%' and '_______';
Q19)  select * from clients where raisonsocial like '_R%' or '_______';
Q20)  select * from clients where villeclient in ('casablanca','rabat','ouarzazate');
Q21)  select * from produit where prixunitaire=300;
Q22)  select * from produit where prixunitaire<300;
Q23)  select * from produit where prixunitaire between 300 and 5000;
Q24)  select Disponible from produit; 
Q25)  select * from produit where prixunitaire>300 and Disponible='no';
Q26)  select * from commande where datecommande='2016-01-11';
Q27)  select * from commande where datecommande>'2016-01-11';
Q28)  select * from commande where datecommande between '2016-02-01' and '2016-03-31';
Q29)  select * from commande where datecommande between '2014-02-11' and '2016-03-31';
Q30)  select * from commande where datecommande=current_date();
Q31)  select * from commande where year(datecommande)= year(current_date());
Q32)  select * from commande where month(datecommande)=07;
Q33)  select * from commande where day(datecommande)=09;
Q34)  select * from commande where month(datecommande)= year(current_date());
Q35)  select nomproduit,prixunitaire*Qtestockee as valeurstock from produit;
Q36)  select prixunitaire*1.2 as prixTTC from produit;
Q37)  select numcommande,(year(current_date())- year(datecommande))as nombre_annee from commande;
Q38)  select distinct villeclient as ville from clients;
Q39)  select distinct numclient from commande;
Q40)  select refproduit,Qtecommandee from details_commande;
Q41)  select * from commande where numclient=15;
Q42)  select * from commande where numclient=102;
Q43)  select refproduit,numcommande from details_commande where numcommande=5;
Q44)  select P.* from produit P join details_commande DC on P.refproduit = DC.refproduit join commande C on DC.numcommande = C.numcommande where date(C.datecommande) = '1998-09-19';
Q45)  select P.* from produit P join details_commande DC on P.refproduit = DC.refproduit join commande C on DC.numcommande = C.numcommande join clients Cl on C.numclient = Cl.numclient where Cl.villeclient="madrid";
Q46)  select * from details_commande where numcommande=15;
Q47)  select count(*) from clients;
Q48)  select count(*) from clients where villeclient='Berlin';
Q49)  select count(*) from produit where Disponible='yes';
Q50)  select count(*) from produit where Disponible='no';
Q51)  select max(prixunitaire) from produit;
Q52)  select min(prixunitaire) from produit;
Q53)  select AVG(prixunitaire) as moyenne from produit;
Q54)  select sum(prixunitaire) as total from produit;
Q55)  select count(*) from commande where numclient=101;
Q56)  select Cl.numclient,count(*) as nombreCommande from clients Cl inner join commande C on Cl.numclient = C.numclient group by C.numclient having nombreCommande>2;
Q57)  select Cl.raisonsocial, count(distinct DC.refproduit) as nombreProduitsCommandee from clients Cl join commande C on Cl.numclient = C.numclient join details_commande DC on C.numcommande = Dc.numcommande group by Cl.raisonsocial;
Q58)  select Cl.numclient, count(*) from clients Cl left join commande C on Cl.numclient = C.numclient where C.numclient is null group by Cl.numclient;
Q59)  select P.refproduit, count(*) from produit P left join details_commande DC on P.refproduit = DC.refproduit where DC.refproduit is  null group by P.refproduit ;
Q60)  select nomproduit,(prixunitaire*Qtestockee) as valeurDeStock from produit;
Q61)  select C.numcommande, sum(P.prixunitaire*DC.Qtecommandee) as Montant from commande C inner join details_commande DC on C.numcommande = DC.numcommande inner join produit P on DC.refproduit = P.refproduit group by C.numcommande;
Q62)  select refproduit, if (Qtestockee<10, "Besoin en reapprovisionnement", "quantite suffisante") as etat from produit;
alter table commande add column ville_livraison text ;
alter table clients add column type text;
Q63) select * from commande C inner join clients Cl on C.numclient = Cl.numclient where Cl.villeclient="madrid" or C.ville_livraison="madrid";
Q64) select * from commande C inner join clients Cl on C.numclient = Cl.numclient where Cl.villeclient="madrid" and C.ville_livraison="madrid";
Q65) select C.numcommande from commande C inner join clients Cl on C.numclient = Cl.numclient where Cl.villeclient and C.ville_livraison;
Q66) select adresseclient,villeclient from clients;
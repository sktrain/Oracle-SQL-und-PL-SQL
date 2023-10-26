REM   Script: Pivot and unpivot examples using Olympic data
REM   Examples of pivoting and unpivoting data. Uses a subset of the results from the Rio Olympics as a data source.

create table olympic_medal_winners (   
  olympic_year int,  
  sport        varchar2( 30 ),  
  gender       varchar2( 1 ),  
  event        varchar2( 128 ),  
  medal        varchar2( 10 ),  
  noc          varchar2( 3 ),  
  athlete      varchar2( 128 ) 
);

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Archery','M','Men''s Individual','Gold','KOR','KU Bonchan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Archery','M','Men''s Individual','Silver','FRA','VALLADONT Jean-Charles');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Archery','M','Men''s Individual','Bronze','USA','ELLISON Brady');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Archery','M','Men''s Team','Gold','KOR','Republic of Korea');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Archery','M','Men''s Team','Bronze','AUS','Australia');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Archery','M','Men''s Team','Silver','USA','United States');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Artistic Gymnastics','M','Men''s Floor Exercise','Gold','GBR','WHITLOCK Max');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Artistic Gymnastics','M','Men''s Floor Exercise','Bronze','BRA','MARIANO Arthur');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Artistic Gymnastics','M','Men''s Floor Exercise','Silver','BRA','HYPOLITO Diego');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Artistic Gymnastics','M','Men''s Horizontal Bar','Gold','GER','HAMBUECHEN Fabian');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Artistic Gymnastics','M','Men''s Horizontal Bar','Bronze','GBR','WILSON Nile');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Artistic Gymnastics','M','Men''s Horizontal Bar','Silver','USA','LEYVA Danell');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Athletics','M','Men''s 10,000m','Gold','GBR','FARAH Mohamed');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Athletics','M','Men''s 10,000m','Bronze','ETH','TOLA Tamirat');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Athletics','M','Men''s 10,000m','Silver','KEN','TANUI Paul Kipngetich');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Athletics','M','Men''s 100m','Gold','JAM','BOLT Usain');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Athletics','M','Men''s 100m','Silver','USA','GATLIN Justin');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Athletics','M','Men''s 100m','Bronze','CAN','DE GRASSE Andre');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Badminton','M','Men''s Doubles','Gold','CHN','Zhang');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Badminton','M','Men''s Doubles','Bronze','GBR','Langridge');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Badminton','M','Men''s Doubles','Bronze','GBR','Ellis');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Badminton','M','Men''s Doubles','Silver','MAS','Tan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Badminton','M','Men''s Doubles','Silver','MAS','Goh');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Badminton','M','Men''s Doubles','Gold','CHN','Fu');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Beach Volleyball','M','Men','Gold','BRA','Cerutti');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Beach Volleyball','M','Men','Gold','BRA','Oscar Schmidt');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Beach Volleyball','M','Men','Silver','ITA','Nicolai');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Beach Volleyball','M','Men','Silver','ITA','Lupo');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Beach Volleyball','M','Men','Bronze','NED','Meeuwsen');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Beach Volleyball','M','Men','Bronze','NED','Brouwer');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Boxing','M','Men''s Bantam (56kg)','Gold','CUB','RAMIREZ Robeisy');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Boxing','M','Men''s Bantam (56kg)','Bronze','UZB','AKHMADALIEV Murodjon');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Boxing','M','Men''s Bantam (56kg)','Bronze','RUS','NIKITIN Vladimir');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Boxing','M','Men''s Bantam (56kg)','Silver','USA','STEVENSON Shakur');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Boxing','M','Men''s Fly (52kg)','Gold','UZB','ZOIROV Shakhobidin');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Boxing','M','Men''s Fly (52kg)','Bronze','CHN','HU Jianguan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Slalom','M','Canoe Double (C2) Men','Gold','SVK','PETER Skantar');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Slalom','M','Canoe Double (C2) Men','Bronze','FRA','GAUTHIER Klauss');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Slalom','M','Canoe Double (C2) Men','Bronze','FRA','MATTHIEU Peche');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Slalom','M','Canoe Double (C2) Men','Silver','GBR','RICHARD Hounslow');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Slalom','M','Canoe Double (C2) Men','Silver','GBR','DAVID Florence');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Slalom','M','Canoe Double (C2) Men','Gold','SVK','LADISLAV Skantar');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Sprint','M','Men''s Canoe Double 1000m','Gold','GER','Brendel');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Sprint','M','Men''s Canoe Double 1000m','Bronze','UKR','Mishchuk');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Sprint','M','Men''s Canoe Double 1000m','Bronze','UKR','Ianchuk');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Sprint','M','Men''s Canoe Double 1000m','Silver','BRA','Queiroz dos Santos');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Sprint','M','Men''s Canoe Double 1000m','Silver','BRA','de Souza Silva');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Canoe Sprint','M','Men''s Canoe Double 1000m','Gold','GER','Vandrey');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Road','M','Men''s Individual Time Trial','Gold','SUI','CANCELLARA Fabian');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Road','M','Men''s Individual Time Trial','Bronze','GBR','FROOME Christopher');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Road','M','Men''s Individual Time Trial','Silver','NED','DUMOULIN Tom');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Road','M','Men''s Road Race','Gold','BEL','VAN AVERMAET Greg');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Road','M','Men''s Road Race','Silver','DEN','FUGLSANG Jakob');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Road','M','Men''s Road Race','Bronze','POL','MAJKA Rafal');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Track','M','Men''s Keirin','Gold','GBR','KENNY Jason');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Track','M','Men''s Keirin','Bronze','MAS','AWANG Azizulhasni');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Track','M','Men''s Keirin','Silver','NED','BUCHLI Matthijs');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Track','M','Men''s Omnium','Gold','ITA','VIVIANI Elia');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Track','M','Men''s Omnium','Bronze','DEN','HANSEN Lasse Norman');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Cycling Track','M','Men''s Omnium','Silver','GBR','CAVENDISH Mark');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Diving','M','Men''s 10m Platform','Gold','CHN','CHEN Aisen');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Diving','M','Men''s 10m Platform','Bronze','USA','BOUDIA David');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Diving','M','Men''s 10m Platform','Silver','MEX','SANCHEZ German');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Diving','M','Men''s 3m Springboard','Gold','CHN','CAO Yuan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Diving','M','Men''s 3m Springboard','Silver','GBR','LAUGHER Jack');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Diving','M','Men''s 3m Springboard','Bronze','GER','HAUSDING Patrick');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Equestrian','X','Dressage Individual','Gold','GBR','DUJARDIN Charlotte');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Equestrian','X','Dressage Individual','Bronze','GER','BRORING-SPREHE Kristina');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Equestrian','X','Dressage Individual','Silver','GER','WERTH Isabell');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Equestrian','X','Dressage Team','Gold','GER','Germany');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Equestrian','X','Dressage Team','Bronze','USA','United States');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Equestrian','X','Dressage Team','Silver','GBR','Great Britain');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Fencing','M','Men''s Foil Individual','Gold','ITA','GAROZZO Daniele');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Fencing','M','Men''s Foil Individual','Silver','USA','MASSIALAS Alexander');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Fencing','M','Men''s Foil Individual','Bronze','RUS','SAFIN Timur');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Fencing','M','Men''s Foil Team','Gold','RUS','Russian Federation');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Fencing','M','Men''s Foil Team','Bronze','USA','United States');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Fencing','M','Men''s Foil Team','Silver','FRA','France');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Handball','M','Men','Gold','DEN','Denmark');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Handball','M','Men','Silver','FRA','France');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Handball','M','Men','Bronze','GER','Germany');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Handball','W','Women','Gold','RUS','Russian Federation');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Handball','W','Women','Silver','FRA','France');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Handball','W','Women','Bronze','NOR','Norway');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Hockey','M','Men','Gold','ARG','Argentina');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Hockey','M','Men','Silver','BEL','Belgium');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Hockey','M','Men','Bronze','GER','Germany');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Hockey','W','Women','Gold','GBR','Great Britain');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Hockey','W','Women','Silver','NED','Netherlands');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Hockey','W','Women','Bronze','GER','Germany');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Judo','M','Men +100 kg','Gold','FRA','RINER Teddy');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Judo','M','Men +100 kg','Bronze','BRA','SILVA Rafael');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Judo','M','Men +100 kg','Bronze','ISR','SASSON Or');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Judo','M','Men +100 kg','Silver','JPN','HARASAWA Hisayoshi');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Judo','M','Men -100 kg','Gold','CZE','KRPALEK Lukas');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Judo','M','Men -100 kg','Bronze','FRA','MARET Cyrille');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Modern Pentathlon','M','Men''s Individual','Gold','RUS','LESUN Alexander');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Modern Pentathlon','M','Men''s Individual','Silver','UKR','TYMOSHCHENKO Pavlo');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Modern Pentathlon','M','Men''s Individual','Bronze','MEX','HERNANDEZ USCANGA Ismael Marcelo');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Modern Pentathlon','W','Women''s Individual','Gold','AUS','ESPOSITO Chloe');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Modern Pentathlon','W','Women''s Individual','Silver','FRA','CLOUVEL Elodie');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Modern Pentathlon','W','Women''s Individual','Bronze','POL','NOWACKA Oktawia');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rhythmic Gymnastics','W','Group All-Around','Gold','RUS','Russian Federation');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rhythmic Gymnastics','W','Group All-Around','Bronze','BUL','Bulgaria');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rhythmic Gymnastics','W','Group All-Around','Silver','ESP','Spain');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rhythmic Gymnastics','W','Individual All-Around','Gold','RUS','MAMUN Margarita');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rhythmic Gymnastics','W','Individual All-Around','Silver','RUS','KUDRYAVTSEVA Yana');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rhythmic Gymnastics','W','Individual All-Around','Bronze','UKR','RIZATDINOVA Ganna');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rowing','M','Lightweight Men''s Double Sculls','Gold','FRA','Azou');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rowing','M','Lightweight Men''s Double Sculls','Bronze','NOR','Brun');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rowing','M','Lightweight Men''s Double Sculls','Bronze','NOR','Strandli');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rowing','M','Lightweight Men''s Double Sculls','Silver','IRL','O''Donovan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rowing','M','Lightweight Men''s Double Sculls','Silver','IRL','O''Donovan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Rowing','M','Lightweight Men''s Double Sculls','Gold','FRA','Houin');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Sailing','M','470 Men','Gold','CRO','Fantela');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Sailing','M','470 Men','Bronze','GRE','Kagialis');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Sailing','M','470 Men','Bronze','GRE','Mantis');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Sailing','M','470 Men','Silver','AUS','Ryan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Sailing','M','470 Men','Silver','AUS','Belcher');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Sailing','M','470 Men','Gold','CRO','Marenic');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Swimming','M','Men''s 100m Backstroke','Gold','USA','MURPHY Ryan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Swimming','M','Men''s 100m Backstroke','Bronze','USA','PLUMMER David');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Swimming','M','Men''s 100m Backstroke','Silver','CHN','XU Jiayu');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Swimming','M','Men''s 100m Breaststroke','Gold','GBR','PEATY Adam');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Swimming','M','Men''s 100m Breaststroke','Bronze','USA','MILLER Cody');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Swimming','M','Men''s 100m Breaststroke','Silver','RSA','VAN DER BURGH Cameron');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Table Tennis','M','Men''s Singles','Gold','CHN','MA Long');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Table Tennis','M','Men''s Singles','Bronze','JPN','MIZUTANI Jun');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Table Tennis','M','Men''s Singles','Silver','CHN','ZHANG Jike');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Table Tennis','M','Men''s Team','Gold','CHN','China');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Table Tennis','M','Men''s Team','Bronze','GER','Germany');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Table Tennis','M','Men''s Team','Silver','JPN','Japan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Taekwondo','M','Men +80kg','Gold','AZE','ISAEV Radik');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Taekwondo','M','Men +80kg','Bronze','KOR','CHA Dongmin');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Taekwondo','M','Men +80kg','Bronze','BRA','SIQUEIRA Maicon');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Taekwondo','M','Men +80kg','Silver','NIG','ISSOUFOU ALFAGA Abdoulrazak');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Taekwondo','M','Men -58kg','Gold','CHN','ZHAO Shuai');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Taekwondo','M','Men -58kg','Silver','THA','HANPRAB Tawin');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Tennis','M','Men''s Doubles','Gold','ESP','Lopez');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Tennis','M','Men''s Doubles','Bronze','USA','Johnson');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Tennis','M','Men''s Doubles','Bronze','USA','Sock');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Tennis','M','Men''s Doubles','Silver','ROU','Tecau');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Tennis','M','Men''s Doubles','Silver','ROU','Mergea');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Tennis','M','Men''s Doubles','Gold','ESP','Nadal');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Trampoline Gymnastics','M','Men','Gold','BLR','HANCHAROU Uladzislau');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Trampoline Gymnastics','M','Men','Silver','CHN','DONG Dong');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Trampoline Gymnastics','M','Men','Bronze','CHN','GAO Lei');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Trampoline Gymnastics','W','Women','Gold','CAN','MACLENNAN Rosannagh');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Trampoline Gymnastics','W','Women','Silver','GBR','PAGE Bryony');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Trampoline Gymnastics','W','Women','Bronze','CHN','LI Dan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Triathlon','M','Men','Gold','GBR','BROWNLEE Alistair');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Triathlon','M','Men','Silver','GBR','BROWNLEE Jonathan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Triathlon','M','Men','Bronze','RSA','SCHOEMAN Henri');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Triathlon','W','Women','Gold','USA','JORGENSEN Gwen');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Triathlon','W','Women','Silver','SUI','SPIRIG HUG Nicola');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Triathlon','W','Women','Bronze','GBR','HOLLAND Vicky');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Volleyball','M','Men','Gold','BRA','Brazil');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Volleyball','M','Men','Silver','ITA','Italy');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Volleyball','M','Men','Bronze','USA','United States');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Volleyball','W','Women','Gold','CHN','China');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Volleyball','W','Women','Silver','SRB','Serbia');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Volleyball','W','Women','Bronze','USA','United States');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Water Polo','M','Men','Gold','SRB','Serbia');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Water Polo','M','Men','Silver','CRO','Croatia');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Water Polo','M','Men','Bronze','ITA','Italy');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Water Polo','W','Women','Gold','USA','United States');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Water Polo','W','Women','Silver','ITA','Italy');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Water Polo','W','Women','Bronze','RUS','Russian Federation');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Weightlifting','M','Men''s +105kg','Gold','GEO','TALAKHADZE Lasha');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Weightlifting','M','Men''s +105kg','Bronze','GEO','TURMANIDZE Irakli');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Weightlifting','M','Men''s +105kg','Silver','ARM','MINASYAN Gor');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Weightlifting','M','Men''s 105kg','Gold','UZB','NURUDINOV Ruslan');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Weightlifting','M','Men''s 105kg','Bronze','KAZ','ZAICHIKOV Alexandr');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Weightlifting','M','Men''s 105kg','Silver','ARM','MARTIROSYAN Simon');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Wrestling','M','Men''s Freestyle 125 kg','Gold','TUR','AKGUL Taha');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Wrestling','M','Men''s Freestyle 125 kg','Bronze','BLR','SAIDAU Ibrahim');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Wrestling','M','Men''s Freestyle 125 kg','Bronze','GEO','PETRIASHVILI Geno');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Wrestling','M','Men''s Freestyle 125 kg','Silver','IRI','GHASEMI Komeil Nemat');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Wrestling','M','Men''s Freestyle 57 kg','Gold','GEO','KHINCHEGASHVILI Vladimer');

Insert into olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE) values (2016,'Wrestling','M','Men''s Freestyle 57 kg','Bronze','AZE','ALIYEV Haji');

Commit
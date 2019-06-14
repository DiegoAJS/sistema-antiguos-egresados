-- Generation time: Wed, 10 Apr 2019 02:38:12 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_24
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `table_person`;
CREATE TABLE `table_person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ci` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `cellphone` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephone` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT current_timestamp(),
  `updated` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `ci` (`ci`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `table_person` VALUES ('1','Molly','Collier','45183','rzulauf@example.org','1-541-616-8775','01370600884','Wardhaven','635 Jordane Skyway Apt. 665\nEast Korey, DE 25103-9003','luub','1998-10-16 05:24:23','1970-12-13 10:45:43'),
('2','Erica','Veum','0400','drunolfsdottir@example.net','1-997-606-0929','(396)267-3979x17','Barretthaven','663 Wolff Mountain Suite 801\nLindgrenmouth, WA 54626-0975','ocfb','2007-10-14 07:21:55','2000-07-14 01:11:31'),
('3','Forest','Sauer','051','kaya40@example.com','264-021-3552x610','729.009.2087x753','North Selmer','572 Brianne View\nKreigerberg, ND 10510-1193','wfii','1989-03-18 13:00:23','1983-06-26 16:05:56'),
('4','Ezra','Hegmann','19786','friesen.bailey@example.net','03905096276','(925)942-8431x07','Doylehaven','3907 O\'Hara Causeway\nCruickshankville, UT 78270','hvor','1998-03-07 21:05:16','1975-04-03 11:39:14'),
('5','Edgar','Stark','547','mschimmel@example.org','+44(2)2313486286','1-859-277-8958x2','New Joanie','470 Russel Hollow Apt. 688\nJessiechester, CO 69263','gvid','1998-07-05 01:53:29','1983-08-02 07:13:10'),
('6','Ubaldo','Conroy','7737','kim74@example.com','1-222-137-0041x7','216.364.0260x766','Klockofort','762 Emmitt Path Apt. 370\nKuhicmouth, OK 03709','ooer','2004-03-17 15:24:18','2013-12-14 06:38:40'),
('7','Gussie','Ernser','3063','nia18@example.com','(381)036-5357x85','324-184-2518','West Roy','98236 Lubowitz Light\nHarveychester, OH 90422','apkg','1982-06-08 03:24:30','2019-02-20 18:43:58'),
('8','Gerda','Pollich','63121','ulockman@example.net','833-836-2698x484','(052)467-9168','West Domingoshire','66156 Keanu Common Apt. 514\nTreutelton, DC 47764','bnsf','1998-05-11 13:25:51','1977-10-13 02:56:24'),
('9','Cleve','Thiel','90147','ariel32@example.org','+38(5)7975733614','1-695-851-5649x0','East Martinemouth','747 Brisa Plain\nPort Malindafort, CO 06963','wzya','1992-12-01 01:26:28','1993-05-28 20:28:53'),
('10','Cathy','O\'Keefe','996','kenneth.heaney@example.net','155.499.1547x125','+60(6)1212699748','Bufordfurt','256 Thiel Club Suite 873\nMinervaview, OH 30815','ruhu','1978-10-16 23:19:57','1989-01-18 19:15:55'),
('11','Astrid','Lakin','5965','xturcotte@example.com','745.881.1025','276-480-2803','Kaileyside','697 Lakin Dale Apt. 732\nNorth Coltonside, GA 70424','lgzz','2004-12-05 10:15:20','2009-02-27 05:45:04'),
('12','Mariam','Thompson','01072','melvin.ryan@example.net','939-412-3368x467','505-627-8630x680','South Lavonview','8395 Osinski Village Apt. 858\nEast Gage, SD 81055-8401','kmee','2010-10-18 18:59:51','1983-10-24 11:38:14'),
('13','Laurence','Prohaska','2486','walker.triston@example.com','1-133-082-5589','1-141-221-4475x8','Malcolmshire','87104 Cassandra Vista\nKayleighside, WV 42420','zfyr','2015-10-04 11:33:41','2011-03-17 20:50:07'),
('14','Katherine','Beer','561','turner.maximillia@example.com','315-934-8054','354-457-3602x646','Port Tomasside','97172 Connelly Common Suite 436\nEast Trevionhaven, VT 23333','hmry','2016-08-13 06:20:45','1985-01-22 17:04:28'),
('15','Arlene','Hermann','4529','block.missouri@example.net','(704)103-3285x13','1-655-849-1498','Brownmouth','9476 Orlo Underpass\nZiemannberg, IL 67167','ltui','2001-01-13 00:24:29','1988-11-18 18:14:14'),
('16','Hayley','Skiles','175','benedict21@example.com','1-015-584-0927','+67(9)9371686854','South Rachaelbury','6384 Verla Glen Suite 456\nHaneland, KY 61140','itiu','2012-06-22 19:26:12','2001-01-08 12:57:57'),
('17','Israel','Becker','3301','connelly.beth@example.org','05515765358','862-146-5961x902','New Judgebury','9528 Amos Burg Suite 796\nNew Howell, AK 27631-2969','vgmj','1999-06-14 02:13:25','1992-11-10 19:22:43'),
('18','Wendy','Kling','270','lucile.beahan@example.net','(109)331-9562x90','+00(0)6308243861','Dallinville','101 Kerluke Plains\nVedaside, UT 25208','hkva','2013-11-23 03:41:52','1973-11-16 03:11:56'),
('19','Raleigh','Runte','87703','aurelie.rutherford@example.net','03454740977','1-878-225-2453x4','Turnerborough','1416 Fabiola Parkways\nBeahanstad, CA 98238','tlvc','1992-11-27 12:39:50','1991-03-04 17:19:48'),
('20','Abigail','Klein','295','koch.giovani@example.com','229.245.8006x969','(847)415-7742','East Oletamouth','891 Rutherford Hills Suite 200\nRossieview, ID 28069-1790','qsdu','1970-10-08 01:13:36','2008-10-16 20:43:56'),
('21','Jaleel','Stehr','4524','krista61@example.org','1-764-422-8946x5','1-867-845-3082','Evabury','82380 Grady Fork Apt. 044\nBrekkestad, CO 94725-2349','itet','2000-08-30 22:08:59','1999-02-04 19:36:51'),
('22','Ruthie','Grant','35696','gennaro17@example.net','06325955806','1-725-007-6406x5','Lake Rigoberto','413 Friesen Plaza\nNorth Nikki, NC 25207','voht','1991-02-11 11:11:30','1999-10-04 07:15:55'),
('23','Kirsten','Osinski','966','koelpin.donny@example.org','+98(2)2397380967','1-354-455-0218','Westburgh','500 Triston Villages Apt. 173\nPablostad, SD 59631','yzrp','2015-10-30 00:26:56','1992-10-08 10:25:47'),
('24','Ilene','Collier','9807','maxie.dare@example.net','(124)009-3936','769-270-3103x379','Gillianburgh','1843 Eleanora Common Suite 491\nWest Vickyfort, OR 93153','wllk','1978-11-09 23:59:06','1970-06-27 18:42:20'),
('25','Cristobal','Weimann','8128','coby.champlin@example.com','956-576-2981','346-352-0817x251','Considineview','08594 Fae Meadow\nNorth Alexiefurt, OH 64925-0377','hkgj','2011-01-09 18:34:49','1989-06-03 00:29:14'),
('26','Keshawn','Mante','28556','krajcik.lauryn@example.net','+74(8)7275065186','144.931.7737','West Dejuanburgh','890 Adams Tunnel\nWest Raymundo, NY 58003','srzt','1980-07-29 04:23:56','1975-07-07 13:59:05'),
('27','Ernest','Jacobi','6952','oleta.strosin@example.org','1-830-454-3896x6','+97(1)7193441564','West Kip','4512 Michelle Orchard\nPort Alyson, AZ 21409-4442','qzhx','2006-04-06 07:47:59','1982-07-05 10:21:42'),
('28','Alexander','Boehm','8603','qvandervort@example.com','1-527-354-6359','1-026-603-3500','South Meredith','97457 Huel Knolls\nNorth Imogeneborough, MI 77928-5482','eikb','2006-11-15 00:04:30','2011-06-13 21:52:04'),
('29','Simone','Considine','961','constance53@example.net','(945)447-3605x01','1-228-329-7992','Port Carolinaside','25942 Reed Walks\nGrayceshire, DC 74507-3067','yala','1970-05-18 08:27:05','2008-04-27 03:47:39'),
('30','Hollie','Fahey','5711','connor67@example.net','(684)848-5785x90','649-943-5021x917','Elroybury','89375 Reilly Street Suite 976\nMarcelmouth, OH 39579','khkg','2004-03-13 03:02:20','1972-10-15 01:39:27'),
('31','Catharine','Kris','6280','carmine97@example.net','1-631-957-0846x5','06085566903','Port Lamont','608 DuBuque Branch Apt. 078\nGeorgiannaside, MD 57280-7241','anok','1994-05-23 15:45:53','1984-02-02 18:23:52'),
('32','Korbin','Fritsch','4111','conroy.roger@example.org','+72(6)7701171168','1-628-575-6648','Port Lemuel','96792 Sylvia Cliff Apt. 754\nLake Hosea, MA 65641-4795','bksu','1986-09-27 13:44:03','1977-12-18 18:50:53'),
('33','Davion','Kub','24292','sipes.shawn@example.net','1-652-583-1317','(089)289-3267','South Ewell','777 Gorczany Knoll\nWindlermouth, IL 39601','rcan','1983-06-10 17:53:47','2015-07-05 00:34:01'),
('34','Giovani','Jacobi','191','dvolkman@example.com','770.938.1227x017','1-679-671-0516x0','Rosenbaumfurt','47188 Dickinson Villages\nPort Alena, AR 31559-0664','ftse','2014-05-27 10:02:32','1999-05-25 02:24:58'),
('35','Maryjane','Gerhold','885','bailey.william@example.com','1-958-422-8841','470.482.0616','Schaeferton','931 Orn Hills\nEast Bonita, WA 38884','kdgy','1986-03-31 07:36:20','2003-08-14 03:18:02'),
('36','Jillian','Blanda','2914','ignacio.becker@example.com','1-501-734-5834x0','(656)648-6916','Breanafurt','397 Enid Spurs Apt. 408\nMarjolainestad, MI 60671','uauc','1974-12-16 01:42:42','1997-08-07 18:29:01'),
('37','Damian','Gislason','5844','amparo.dubuque@example.org','(898)958-5522','720.032.0677','East Adolphus','49308 Shirley Drive Suite 986\nNorth Paulafurt, OK 70936-9658','abwo','1981-06-30 21:08:05','2005-06-28 20:09:58'),
('38','Corene','Kessler','0315','o\'keefe.niko@example.com','+82(1)7575720754','(976)382-8171','Stokestown','5781 Glenda Creek Apt. 411\nSouth Yoshikofort, KY 15808-0161','mvpa','2016-06-25 04:51:57','1995-06-24 13:43:54'),
('39','Minerva','Gorczany','9332','lakin.monica@example.net','(986)371-7155x03','645-883-8018','Mrazhaven','33783 Barry Track\nPort Rosiefort, WA 59810','msdm','1971-06-04 09:21:17','1987-10-21 05:39:56'),
('40','Golda','Zboncak','1849','lziemann@example.com','1-278-337-7849x5','(050)906-2094','Missouriberg','082 Kaylie Branch\nEast Dollyside, IN 32985-0569','dngu','2001-10-21 22:44:25','1975-03-09 11:51:29'),
('41','Glenda','Wisozk','7094','walton78@example.com','955.985.8943x432','380-559-2308x625','Ulicesburgh','304 Millie Street Apt. 305\nVirgilland, AZ 27835','onzy','1973-02-17 09:55:44','1975-05-11 04:24:14'),
('42','Haskell','Schiller','229','dietrich.sonny@example.org','(279)866-5440x08','971.295.6676','West Harrisonville','36192 Daron Squares Apt. 234\nAngusfurt, WA 30365','iatp','1999-11-22 02:56:21','1983-02-08 22:47:36'),
('43','Margie','Conn','78277','abernathy.patricia@example.com','(092)665-9854x49','+41(7)7477284201','East Deronland','573 Goodwin Mountains Suite 649\nBoyleshire, ID 55124','jtqi','2008-07-17 23:42:01','1986-09-01 18:10:02'),
('44','Amalia','Swaniawski','94933','hallie48@example.com','496.826.7539x392','(384)578-9808','South Kavontown','71071 Terry Street\nNew Pattieton, ND 94818','wlrm','1997-10-15 18:30:14','1998-10-27 02:08:14'),
('45','Ofelia','Wilderman','3098','ryan.kari@example.com','952-132-6962x299','032.954.2606','East Lavadafort','32737 Koepp Light\nPort Bonitafort, VA 37053','jafu','1994-02-03 12:30:35','2012-07-02 20:07:51'),
('46','Shyann','Nienow','025','berge.sonya@example.net','135-530-2324x794','+69(8)1950198533','New Javier','52358 Vada Squares\nEast Jerrod, WV 56531-3561','buwg','1982-04-27 19:14:14','1990-05-31 21:15:03'),
('47','Eldora','Larson','51777','konopelski.gino@example.org','1-609-993-4464','748.117.4705x092','Shemartown','79623 Celia Drive Suite 620\nZemlakview, IA 49000-0812','rmfl','1986-06-20 12:29:07','1980-11-03 16:58:49'),
('48','Delores','Cremin','66642','cleora.zboncak@example.com','1-181-151-1754','212.739.0881','Elmorebury','3195 Mona Walks Suite 476\nNew Elverahaven, NC 64459-7311','fhnl','2018-01-04 15:47:48','1978-02-12 18:01:07'),
('49','Leilani','O\'Kon','2351','rbechtelar@example.net','702-271-3218x872','788-261-2592','Hamillchester','3602 Rosie Ports Apt. 870\nSouth Hilbert, OK 45509-6638','tjwn','2013-01-26 09:29:54','1982-03-15 23:41:03'),
('50','Keeley','Donnelly','835','ternser@example.com','(259)113-4934','1-844-486-7267','North Braeden','62700 Jesse Village Apt. 657\nCarleyfurt, CA 96903-6539','vhpg','2010-11-30 10:11:48','2006-02-09 22:17:51'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


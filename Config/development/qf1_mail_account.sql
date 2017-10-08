-- MySQL dump 10.13  Distrib 5.7.19, for osx10.12 (x86_64)
--
-- Host: localhost    Database: book
-- ------------------------------------------------------
-- Server version	5.7.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `book_classifys`
--

LOCK TABLES `book_classifys` WRITE;
/*!40000 ALTER TABLE `book_classifys` DISABLE KEYS */;
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (1,'文学小说',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (2,'轻小说/漫画',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (3,'心理/宗教',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (4,'知识学习',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (5,'商业理财',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (6,'人文史地',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (7,'社会科学',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (8,'艺术设计',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (9,'生活风格/饮食',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (10,'教科读物',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (11,'旅游',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (12,'自然科普',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (13,'恐怖/惊悚小说',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (14,'悬疑推理小说',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (15,'翻译文学',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (16,'科幻小说',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (17,'历史武侠',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (18,'古典文学',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (19,'言情小说',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (20,'现代文学',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (21,'现代小说',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (22,'儿童文学',1,'0/1');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (23,'历史战役漫画',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (24,'图文书/绘本',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (25,'华文轻小说',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (26,'奇幻/魔法漫书',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (27,'动作冒险漫画',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (28,'悬疑推理漫画',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (29,'BL/GL',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (30,'日本轻小说',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (31,'运动/竞技漫画',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (32,'科幻漫画',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (33,'灵异漫画',2,'0/2');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (34,'励志/散文',3,'0/3');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (35,'人际关系',3,'0/3');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (36,'两性/家庭关系',3,'0/3');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (37,'宗教命理',3,'0/3');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (38,'心理学',3,'0/3');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (39,'个人成长',3,'0/3');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (40,'韩语',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (41,'中文',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (42,'日语',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (43,'外语',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (44,'英语',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (45,'语言能力',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (46,'电脑资讯',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (47,'音乐',4,'0/4');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (48,'电子商务',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (49,'成功法',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (50,'管理',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (51,'经济',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (52,'传记',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (53,'投资理财',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (54,'广告/业务',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (55,'职场',5,'0/5');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (56,'中国历史',6,'0/6');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (57,'哲学',6,'0/6');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (58,'当代',6,'0/6');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (59,'世界历史',6,'0/6');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (60,'逻辑/思考',6,'0/6');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (61,'社会议题',7,'0/7');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (62,'文化研究',7,'0/7');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (63,'新闻学',7,'0/7');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (64,'报道文学',7,'0/7');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (65,'性别研究',7,'0/7');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (66,'政治',7,'0/7');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (67,'军事',7,'0/7');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (68,'室内设计',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (69,'电影',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (70,'摄影',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (71,'戏剧',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (72,'设计',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (73,'绘图',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (74,'建筑',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (75,'音乐',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (76,'收藏鉴赏',8,'0/8');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (77,'休闲',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (78,'居家生活',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (79,'个人护理',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (80,'宠物',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (81,'户外',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (82,'手作',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (83,'食谱',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (84,'饮食文化',9,'0/9');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (85,'小学',10,'0/10');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (86,'初中',10,'0/10');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (87,'高中',10,'0/10');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (88,'大学',10,'0/10');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (89,'中国',11,'0/11');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (90,'旅游文学',11,'0/11');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (91,'美洲',11,'0/11');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (92,'欧洲',11,'0/11');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (93,'非洲/大洋洲',11,'0/11');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (94,'亚洲',11,'0/11');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (95,'主题旅游',11,'0/11');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (96,'应用科学',12,'0/12');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (97,'工程',12,'0/12');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (98,'天文学',12,'0/12');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (99,'计算机',0,'0');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (100,'程序设计',99,'0/99');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (101,'期刊',99,'0/99');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (102,'操作系统',99,'0/99');
INSERT  IGNORE INTO `book_classifys` (`id`, `name`, `parent_id`, `path`) VALUES (103,'基础知识',99,'0/99');
/*!40000 ALTER TABLE `book_classifys` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-08 10:18:12

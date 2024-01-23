-- MySQL dump 10.13  Distrib 8.2.0, for macos13 (arm64)
--
-- Host: localhost    Database: userDB
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `movie_reviews`
--

DROP TABLE IF EXISTS `movie_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_reviews` (
  `reviewId` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(50) DEFAULT NULL,
  `movieId` varchar(50) DEFAULT NULL,
  `movieTitle` varchar(255) DEFAULT NULL,
  `rating` varchar(10) DEFAULT NULL,
  `review` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reviewId`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_reviews`
--

LOCK TABLES `movie_reviews` WRITE;
/*!40000 ALTER TABLE `movie_reviews` DISABLE KEYS */;
INSERT INTO `movie_reviews` VALUES (35,'harry12','872585','Oppenheimer','5','The structure and plot itself are powerful nuclear bombs!','2023-12-15 20:21:32'),(36,'harry12','507089','Five Nights at Freddy\'s','2','It was easy to enjoy with a light atmosphere, but the story was sloppy and predictable, making it difficult to arouse any eye-opening interest. When I watched a unique American low-budget movie, I felt a shallow depth, and the story that was built with tension completely collapsed.','2023-12-15 20:24:07'),(37,'harry12','862','Toy Story','4','All the characters are lovely!','2023-12-15 20:25:12'),(38,'harry12','1858','Transformers','4','Watched it when I was young and it was so much fun.','2023-12-15 20:26:46'),(39,'tom123','466420','Killers of the Flower Moon','4','Secrets and lies of those who stare at the stars of the sky in the mud..','2023-12-15 20:27:52'),(42,'tom123','575264','Mission: Impossible - Dead Reckoning Part One','3','Although there are many characters, it is a work that feels excellent as an action blockbuster, such as the excellent distribution of parts, the Car Chase sequence in Rome, a sequence reminiscent of a disaster movie, and the presence of an actor named Tom Cruise, who just runs.','2023-12-15 20:34:26'),(45,'harry12','575264','Mission: Impossible - Dead Reckoning Part One','4','Loved this movie!','2023-12-16 10:54:30'),(48,'martin123','335977','Indiana Jones and the Dial of Destiny','4','Great movie!!','2023-12-16 11:21:40'),(49,'martin123','1726','Iron Man','5','it was very fun!','2023-12-16 11:22:42');
/*!40000 ALTER TABLE `movie_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('harry12','123456','harry','01012344321'),('martin123','123456','martin','01012341234'),('tom123','123456','tom','01012345678');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16 20:37:43

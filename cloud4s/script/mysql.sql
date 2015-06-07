--
-- Database: `cloud4s`
--
-- --------------------------------------------------------

--
-- Table structure for table `users`
--
CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  `email` varchar(255) NOT NULL,
  `publickey` longtext NOT NULL,
  `privateKey` longtext NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user_roles`
--
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`user_role_id`),
  UNIQUE KEY `uni_username_role` (`role`,`username`),
  UNIQUE KEY `UK_stlxfukw77ov5w1wo1tm3omca` (`role`,`username`),
  KEY `fk_username_idx` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Table structure for table `files`
--
CREATE TABLE IF NOT EXISTS `files` (
  `username` varchar(45) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `filekey` varchar(255) NOT NULL,
  PRIMARY KEY (`username`,`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `shared`
--
CREATE TABLE IF NOT EXISTS `shared` (
  `username` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `sharedBy` varchar(255) NOT NULL,
  `filekey` longtext NOT NULL,
  `revoked` bit(1) NOT NULL,
  PRIMARY KEY (`username`,`filename`,`sharedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `key_recovery`
--
CREATE TABLE IF NOT EXISTS `key_recovery` (
  `username` varchar(255) NOT NULL,
  `requires` int(10) NOT NULL,
  `shares` int(10) NOT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Key recovery information.';





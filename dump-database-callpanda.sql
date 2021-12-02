-- -------------------------------------------------------------
-- TablePlus 4.5.0(396)
--
-- https://tableplus.com/
--
-- Database: callpanda
-- Generation Time: 2021-10-25 17:56:36.4200
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `admin_user` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varbinary(1137) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `analytic_data` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `ip_address` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `candidate_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  `test_answer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `user_id` (`user_id`),
  KEY `candidate_id` (`candidate_id`),
  KEY `client_id` (`client_id`),
  KEY `test_id` (`test_id`),
  KEY `test_answer_id` (`test_answer_id`),
  CONSTRAINT `analytic_data_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `analytic_type` (`id`),
  CONSTRAINT `analytic_data_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `analytic_data_ibfk_3` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`),
  CONSTRAINT `analytic_data_ibfk_4` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  CONSTRAINT `analytic_data_ibfk_5` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`),
  CONSTRAINT `analytic_data_ibfk_6` FOREIGN KEY (`test_answer_id`) REFERENCES `test_answer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `analytic_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_analytic_type_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `application_event` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) NOT NULL,
  `read` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `application_event_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `vacancy_application` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `application_event_description` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `application_identity_event` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_event_id` int(11) NOT NULL,
  `event_description_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `application_event_id` (`application_event_id`),
  KEY `event_description_id` (`event_description_id`),
  CONSTRAINT `application_identity_event_ibfk_1` FOREIGN KEY (`application_event_id`) REFERENCES `application_event` (`id`),
  CONSTRAINT `application_identity_event_ibfk_2` FOREIGN KEY (`event_description_id`) REFERENCES `application_event_description` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candidate_description_last_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `is_new` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `fk_candidate_candidate_description_id` (`candidate_description_last_id`),
  CONSTRAINT `candidate_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  CONSTRAINT `fk_candidate_candidate_description_id` FOREIGN KEY (`candidate_description_last_id`) REFERENCES `candidate_description` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_action_history` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_name_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action_name_id` (`action_name_id`),
  KEY `candidate_id` (`candidate_id`),
  CONSTRAINT `candidate_action_history_ibfk_1` FOREIGN KEY (`action_name_id`) REFERENCES `candidate_action_name` (`id`),
  CONSTRAINT `candidate_action_history_ibfk_2` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_action_name` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_candidate_tag` (
  `candidate_tag_id` int(11) DEFAULT NULL,
  `candidate_id` int(11) DEFAULT NULL,
  KEY `candidate_tag_id` (`candidate_tag_id`),
  KEY `candidate_id` (`candidate_id`),
  CONSTRAINT `candidate_candidate_tag_ibfk_1` FOREIGN KEY (`candidate_tag_id`) REFERENCES `candidate_tag` (`id`),
  CONSTRAINT `candidate_candidate_tag_ibfk_2` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_description` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candidate_id` int(11) NOT NULL,
  `avatar_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `candidate_id` (`candidate_id`),
  CONSTRAINT `candidate_description_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_education` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candidate_description_id` int(11) NOT NULL,
  `school` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `specialization` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `candidate_description_id` (`candidate_description_id`),
  CONSTRAINT `candidate_education_ibfk_1` FOREIGN KEY (`candidate_description_id`) REFERENCES `candidate_description` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_email_invitation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `candidate_description_id` int(11) NOT NULL,
  `invite_key_id` int(11) NOT NULL,
  `vacancy_id` int(11) NOT NULL,
  `vacancy_description_history_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `candidate_id` (`candidate_id`),
  KEY `candidate_description_id` (`candidate_description_id`),
  KEY `invite_key_id` (`invite_key_id`),
  KEY `vacancy_id` (`vacancy_id`),
  KEY `vacancy_description_history_id` (`vacancy_description_history_id`),
  CONSTRAINT `candidate_email_invitation_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`),
  CONSTRAINT `candidate_email_invitation_ibfk_2` FOREIGN KEY (`candidate_description_id`) REFERENCES `candidate_description` (`id`),
  CONSTRAINT `candidate_email_invitation_ibfk_3` FOREIGN KEY (`invite_key_id`) REFERENCES `candidate_invite_key` (`id`),
  CONSTRAINT `candidate_email_invitation_ibfk_4` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`id`),
  CONSTRAINT `candidate_email_invitation_ibfk_5` FOREIGN KEY (`vacancy_description_history_id`) REFERENCES `vacancy_description_history` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_invite_key` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` binary(16) DEFAULT NULL,
  `base_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `application_id` int(11) NOT NULL,
  `used` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_candidate_invite_key_key` (`key`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `candidate_invite_key_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `vacancy_application` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_status` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_tag` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`,`title`),
  CONSTRAINT `candidate_tag_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_user` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varbinary(1137) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `candidate_id` (`candidate_id`),
  KEY `ix_candidate_user_email` (`email`),
  CONSTRAINT `candidate_user_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_user_info` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candidate_user_id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rights_and_obligation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `candidate_user_id` (`candidate_user_id`),
  KEY `rights_and_obligation_id` (`rights_and_obligation_id`),
  CONSTRAINT `candidate_user_info_ibfk_1` FOREIGN KEY (`candidate_user_id`) REFERENCES `candidate_user` (`id`),
  CONSTRAINT `candidate_user_info_ibfk_2` FOREIGN KEY (`rights_and_obligation_id`) REFERENCES `rights_and_obligations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `candidate_work_experience` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candidate_description_id` int(11) NOT NULL,
  `begin_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `candidate_description_id` (`candidate_description_id`),
  CONSTRAINT `candidate_work_experience_ibfk_1` FOREIGN KEY (`candidate_description_id`) REFERENCES `candidate_description` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `client` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `license_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry_id` int(11) NOT NULL,
  `is_new` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `client_description_id` int(11) NOT NULL,
  `referral_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `industry_id` (`industry_id`),
  KEY `client_description_id` (`client_description_id`),
  KEY `referral_user_id` (`referral_user_id`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`industry_id`) REFERENCES `industry` (`id`),
  CONSTRAINT `client_ibfk_2` FOREIGN KEY (`client_description_id`) REFERENCES `client_description` (`id`),
  CONSTRAINT `client_ibfk_3` FOREIGN KEY (`referral_user_id`) REFERENCES `referral_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `client_description` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cv_upload` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` enum('STARTED','PENDING','FINISHED') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_cv_upload_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cv_upload_file` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `s3_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `s3_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` enum('STARTED','PENDING','FINISHED','ERRORED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `error_message` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `candidate_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_cv_upload_file_uuid` (`uuid`),
  KEY `candidate_id` (`candidate_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `cv_upload_file_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`),
  CONSTRAINT `cv_upload_file_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `email_template` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `email_template_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `industry` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `referral_bank_info` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iban` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `referral_company` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `industry_id` (`industry_id`),
  CONSTRAINT `referral_company_ibfk_1` FOREIGN KEY (`industry_id`) REFERENCES `industry` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `referral_document` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referral_user_id` int(11) NOT NULL,
  `type` enum('ID_CARD','ID_CARD_BACK','PASSPORT','PASSPORT_VISA','LICENSE','PHOTO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_s3_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_referral_document_uuid` (`uuid`),
  KEY `referral_user_id` (`referral_user_id`),
  CONSTRAINT `referral_document_ibfk_1` FOREIGN KEY (`referral_user_id`) REFERENCES `referral_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `referral_info` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `referral_user` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varbinary(1137) NOT NULL,
  `key` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `right_and_obligation_id` int(11) NOT NULL,
  `referral_company_id` int(11) DEFAULT NULL,
  `referral_bank_info_id` int(11) NOT NULL,
  `referral_info_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `right_and_obligation_id` (`right_and_obligation_id`),
  KEY `referral_company_id` (`referral_company_id`),
  KEY `referral_bank_info_id` (`referral_bank_info_id`),
  KEY `referral_info_id` (`referral_info_id`),
  KEY `ix_referral_user_key` (`key`),
  CONSTRAINT `referral_user_ibfk_1` FOREIGN KEY (`right_and_obligation_id`) REFERENCES `rights_and_obligations` (`id`),
  CONSTRAINT `referral_user_ibfk_2` FOREIGN KEY (`referral_company_id`) REFERENCES `referral_company` (`id`),
  CONSTRAINT `referral_user_ibfk_3` FOREIGN KEY (`referral_bank_info_id`) REFERENCES `referral_bank_info` (`id`),
  CONSTRAINT `referral_user_ibfk_4` FOREIGN KEY (`referral_info_id`) REFERENCES `referral_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `rights_and_obligations` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('TEMP_USER','USER','CANDIDATE','REFERRAL','SELLER','ADMIN','SYSTEM') COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_rights_and_obligations_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `seller_document` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_user_id` int(11) NOT NULL,
  `uuid` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_s3_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_seller_document_uuid` (`uuid`),
  KEY `seller_user_id` (`seller_user_id`),
  CONSTRAINT `seller_document_ibfk_1` FOREIGN KEY (`seller_user_id`) REFERENCES `seller_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `seller_info` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_user_id` int(11) NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `num_id_card` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seller_user_id` (`seller_user_id`),
  CONSTRAINT `seller_info_ibfk_1` FOREIGN KEY (`seller_user_id`) REFERENCES `seller_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `seller_invited` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_user_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seller_user_id` (`seller_user_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `seller_invited_ibfk_1` FOREIGN KEY (`seller_user_id`) REFERENCES `seller_user` (`id`),
  CONSTRAINT `seller_invited_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `seller_plan` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_user_id` int(11) NOT NULL,
  `plan` int(11) NOT NULL,
  `calendar_segment` enum('DAY','MONTH','YEAR') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seller_user_id` (`seller_user_id`),
  CONSTRAINT `seller_plan_ibfk_1` FOREIGN KEY (`seller_user_id`) REFERENCES `seller_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `seller_user` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varbinary(1137) NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_seller_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `temp_referral` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `right_and_obligation_id` int(11) DEFAULT NULL,
  `temp_referral_phone_id` int(11) DEFAULT NULL,
  `temp_referral_email_id` int(11) DEFAULT NULL,
  `referral_info_id` int(11) DEFAULT NULL,
  `referral_company_id` int(11) DEFAULT NULL,
  `referral_bank_info_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `right_and_obligation_id` (`right_and_obligation_id`),
  KEY `temp_referral_phone_id` (`temp_referral_phone_id`),
  KEY `temp_referral_email_id` (`temp_referral_email_id`),
  KEY `referral_info_id` (`referral_info_id`),
  KEY `referral_company_id` (`referral_company_id`),
  KEY `referral_bank_info_id` (`referral_bank_info_id`),
  CONSTRAINT `temp_referral_ibfk_1` FOREIGN KEY (`right_and_obligation_id`) REFERENCES `rights_and_obligations` (`id`),
  CONSTRAINT `temp_referral_ibfk_2` FOREIGN KEY (`temp_referral_phone_id`) REFERENCES `temp_referral_phone` (`id`),
  CONSTRAINT `temp_referral_ibfk_3` FOREIGN KEY (`temp_referral_email_id`) REFERENCES `temp_referral_email` (`id`),
  CONSTRAINT `temp_referral_ibfk_4` FOREIGN KEY (`referral_info_id`) REFERENCES `referral_info` (`id`),
  CONSTRAINT `temp_referral_ibfk_5` FOREIGN KEY (`referral_company_id`) REFERENCES `referral_company` (`id`),
  CONSTRAINT `temp_referral_ibfk_6` FOREIGN KEY (`referral_bank_info_id`) REFERENCES `referral_bank_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `temp_referral_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_referral_id` int(11) NOT NULL,
  `type` enum('ID_CARD','ID_CARD_BACK','PASSPORT','PASSPORT_VISA','LICENSE','PHOTO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_s3_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_temp_referral_document_uuid` (`uuid`),
  KEY `temp_referral_id` (`temp_referral_id`),
  CONSTRAINT `temp_referral_document_ibfk_1` FOREIGN KEY (`temp_referral_id`) REFERENCES `temp_referral` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `temp_referral_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `temp_referral_phone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `temp_user` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_code` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_active` tinyint(1) DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_code` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_active` tinyint(1) DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number_peoples` int(11) DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number_client` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry_id` int(11) DEFAULT NULL,
  `rights_id` int(11) DEFAULT NULL,
  `license_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_s3_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referral_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `industry_id` (`industry_id`),
  KEY `rights_id` (`rights_id`),
  KEY `referral_user_id` (`referral_user_id`),
  CONSTRAINT `temp_user_ibfk_1` FOREIGN KEY (`industry_id`) REFERENCES `industry` (`id`),
  CONSTRAINT `temp_user_ibfk_2` FOREIGN KEY (`rights_id`) REFERENCES `rights_and_obligations` (`id`),
  CONSTRAINT `temp_user_ibfk_3` FOREIGN KEY (`referral_user_id`) REFERENCES `referral_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('BASIC','PSYCHOLOGICAL') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `time` int(11) DEFAULT NULL,
  `title` varchar(2047) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_answer` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `test_answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `test_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_question` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) DEFAULT NULL,
  `test_section_id` int(11) DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `outdated` tinyint(1) DEFAULT NULL,
  `max_score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `test_section_id` (`test_section_id`),
  CONSTRAINT `test_question_ibfk_1` FOREIGN KEY (`test_section_id`) REFERENCES `test_section` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_result` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `application_id` (`application_id`),
  KEY `test_id` (`test_id`),
  CONSTRAINT `test_result_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `vacancy_application` (`id`),
  CONSTRAINT `test_result_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_result_answer` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_result_id` int(11) NOT NULL,
  `test_answer_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `test_result_id` (`test_result_id`),
  KEY `test_answer_id` (`test_answer_id`),
  CONSTRAINT `test_result_answer_ibfk_1` FOREIGN KEY (`test_result_id`) REFERENCES `test_result` (`id`),
  CONSTRAINT `test_result_answer_ibfk_2` FOREIGN KEY (`test_answer_id`) REFERENCES `test_answer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_section` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(4095) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_score` int(11) DEFAULT NULL,
  `outdated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `test_id` (`test_id`),
  CONSTRAINT `test_section_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_total_score_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_result_id` int(11) NOT NULL,
  `test_section_id` int(11) NOT NULL,
  `total_score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `test_total_score_unique_index` (`test_result_id`,`test_section_id`),
  KEY `test_section_id` (`test_section_id`),
  CONSTRAINT `test_total_score_result_ibfk_1` FOREIGN KEY (`test_result_id`) REFERENCES `test_result` (`id`),
  CONSTRAINT `test_total_score_result_ibfk_2` FOREIGN KEY (`test_section_id`) REFERENCES `test_section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_vacancy` (
  `test_id` int(11) DEFAULT NULL,
  `vacancy_id` int(11) DEFAULT NULL,
  KEY `test_id` (`test_id`),
  KEY `vacancy_id` (`vacancy_id`),
  CONSTRAINT `test_vacancy_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`),
  CONSTRAINT `test_vacancy_ibfk_2` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `token_blocklist` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jti` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `token_logged_in` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub` int(11) NOT NULL,
  `role` enum('TEMP_USER','USER','CANDIDATE','REFERRAL','SELLER','ADMIN','SYSTEM') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varbinary(1137) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_new` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `rights_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rights_id` (`rights_id`),
  KEY `client_id` (`client_id`),
  KEY `ix_user_email` (`email`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`rights_id`) REFERENCES `rights_and_obligations` (`id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_notification` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` enum('TEMP_USER','USER','CANDIDATE','REFERRAL','SELLER','ADMIN','SYSTEM') COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `arguments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`arguments`)),
  `sent_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sent_status`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_vacancy_group_subscription` (
  `vacancy_group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  KEY `vacancy_group_id` (`vacancy_group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_vacancy_group_subscription_ibfk_1` FOREIGN KEY (`vacancy_group_id`) REFERENCES `vacancy_group` (`id`),
  CONSTRAINT `user_vacancy_group_subscription_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_vacancy_subscription` (
  `vacancy_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  KEY `vacancy_id` (`vacancy_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_vacancy_subscription_ibfk_1` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`id`),
  CONSTRAINT `user_vacancy_subscription_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vacancy` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vacancy_description_last_id` int(11) DEFAULT NULL,
  `vacancy_group_id` int(11) NOT NULL,
  `is_new` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vacancy_group_id` (`vacancy_group_id`),
  KEY `fk_vacancy_vacancy_description_id` (`vacancy_description_last_id`),
  CONSTRAINT `fk_vacancy_vacancy_description_id` FOREIGN KEY (`vacancy_description_last_id`) REFERENCES `vacancy_description_history` (`id`),
  CONSTRAINT `vacancy_ibfk_1` FOREIGN KEY (`vacancy_group_id`) REFERENCES `vacancy_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vacancy_application` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candidate_id` int(11) NOT NULL,
  `vacancy_id` int(11) NOT NULL,
  `candidate_status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `candidate_id` (`candidate_id`,`vacancy_id`),
  KEY `vacancy_id` (`vacancy_id`),
  KEY `candidate_status_id` (`candidate_status_id`),
  CONSTRAINT `vacancy_application_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`),
  CONSTRAINT `vacancy_application_ibfk_2` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`id`),
  CONSTRAINT `vacancy_application_ibfk_3` FOREIGN KEY (`candidate_status_id`) REFERENCES `candidate_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vacancy_chat_message` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_event_id` int(11) NOT NULL,
  `candidate_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `application_event_id` (`application_event_id`),
  KEY `candidate_user_id` (`candidate_user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `vacancy_chat_message_ibfk_1` FOREIGN KEY (`application_event_id`) REFERENCES `application_event` (`id`),
  CONSTRAINT `vacancy_chat_message_ibfk_2` FOREIGN KEY (`candidate_user_id`) REFERENCES `candidate_user` (`id`),
  CONSTRAINT `vacancy_chat_message_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vacancy_description_history` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary_from` int(11) NOT NULL,
  `salary_to` int(11) NOT NULL,
  `closing_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skills` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vacancy_id` int(11) NOT NULL,
  `client_description_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vacancy_id` (`vacancy_id`),
  KEY `client_description_id` (`client_description_id`),
  CONSTRAINT `vacancy_description_history_ibfk_1` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`id`),
  CONSTRAINT `vacancy_description_history_ibfk_2` FOREIGN KEY (`client_description_id`) REFERENCES `client_description` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vacancy_group` (
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` int(11) NOT NULL,
  `client_description_id` int(11) NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `client_description_id` (`client_description_id`),
  CONSTRAINT `vacancy_group_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  CONSTRAINT `vacancy_group_ibfk_2` FOREIGN KEY (`client_description_id`) REFERENCES `client_description` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `admin_user` (`created`, `updated`, `id`, `email`, `password`, `first_name`, `last_name`, `phone`) VALUES
('2021-10-25 04:41:27', '2021-10-25 04:41:27', 1, 'test@admin.test', '$pbkdf2-sha512$25000$XAtByFnrHeOcM.bcW4txjg$z/ubV4NJtEfihsNaauZJWDP2JhZRu9M2G7uNlt/7tj/IKRD2l9qeey4pfy2YOG11.UD2VmK.ZLo80EqBQi/LWA', 'Joshua', 'Forbes', '+171746657389');

INSERT INTO `analytic_data` (`created`, `updated`, `id`, `type_id`, `ip_address`, `platform`, `browser`, `version`, `user_id`, `candidate_id`, `client_id`, `test_id`, `test_answer_id`) VALUES
('2021-10-25 06:29:20', '2021-10-25 06:29:20', 1, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 06:29:20', '2021-10-25 06:29:20', 2, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 06:30:40', '2021-10-25 06:30:40', 3, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 06:31:14', '2021-10-25 06:31:14', 4, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 06:54:36', '2021-10-25 06:54:36', 5, 35, '178.214.243.24', 'Other', 'curl', '7.68.0', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:09:16', '2021-10-25 07:09:16', 6, 3, '37.112.72.143', 'Mac OS X', 'Safari', '14.1.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:09:17', '2021-10-25 07:09:17', 7, 22, '37.112.72.143', 'Mac OS X', 'Safari', '14.1.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:16:43', '2021-10-25 07:16:43', 8, 35, '178.214.243.24', 'Other', 'curl', '7.68.0', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:17:00', '2021-10-25 07:17:00', 9, 3, '37.112.72.143', 'Mac OS X', 'Safari', '14.1.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:17:01', '2021-10-25 07:17:01', 10, 22, '37.112.72.143', 'Mac OS X', 'Safari', '14.1.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:18:54', '2021-10-25 07:18:54', 11, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:18:58', '2021-10-25 07:18:58', 12, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:18:59', '2021-10-25 07:18:59', 13, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:19:13', '2021-10-25 07:19:13', 14, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:19:21', '2021-10-25 07:19:21', 15, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:19:30', '2021-10-25 07:19:30', 16, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:08', '2021-10-25 07:20:08', 17, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:09', '2021-10-25 07:20:09', 18, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:12', '2021-10-25 07:20:12', 19, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:14', '2021-10-25 07:20:14', 20, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:18', '2021-10-25 07:20:18', 21, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:34', '2021-10-25 07:20:34', 22, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:41', '2021-10-25 07:20:41', 23, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:20:48', '2021-10-25 07:20:48', 24, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:21:51', '2021-10-25 07:21:51', 25, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:22:33', '2021-10-25 07:22:33', 26, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:22:41', '2021-10-25 07:22:41', 27, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:25:24', '2021-10-25 07:25:24', 28, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:25:34', '2021-10-25 07:25:34', 29, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:25:57', '2021-10-25 07:25:57', 30, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:26:00', '2021-10-25 07:26:00', 31, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:26:43', '2021-10-25 07:26:43', 32, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:29:13', '2021-10-25 07:29:13', 33, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:29:17', '2021-10-25 07:29:17', 34, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:29:22', '2021-10-25 07:29:22', 35, 35, '178.214.243.24', 'Other', 'curl', '7.68.0', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:30:17', '2021-10-25 07:30:17', 36, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:32:44', '2021-10-25 07:32:44', 37, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:32:48', '2021-10-25 07:32:48', 38, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:32:55', '2021-10-25 07:32:55', 39, 22, '95.24.9.115', 'iOS', 'Other', '', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:33:00', '2021-10-25 07:33:00', 40, 21, '95.24.9.115', 'iOS', 'Other', '', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:33:18', '2021-10-25 07:33:18', 41, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:33:26', '2021-10-25 07:33:26', 42, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:33:26', '2021-10-25 07:33:26', 43, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:33:27', '2021-10-25 07:33:27', 44, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:36:26', '2021-10-25 07:36:26', 45, 3, '37.112.72.143', 'Mac OS X', 'Safari', '14.1.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:36:27', '2021-10-25 07:36:27', 46, 22, '37.112.72.143', 'Mac OS X', 'Safari', '14.1.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:38:38', '2021-10-25 07:38:38', 47, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:38:46', '2021-10-25 07:38:46', 48, 22, '37.112.72.143', 'Mac OS X', 'Chrome', '94.0.4606', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:50:41', '2021-10-25 07:50:41', 49, 21, '95.24.9.115', 'iOS', 'Other', '', 1, NULL, 1, NULL, NULL),
('2021-10-25 07:50:41', '2021-10-25 07:50:41', 50, 22, '95.24.9.115', 'iOS', 'Other', '', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:23:25', '2021-10-25 08:23:25', 51, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:23:30', '2021-10-25 08:23:30', 52, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:23:55', '2021-10-25 08:23:55', 53, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:23:56', '2021-10-25 08:23:56', 54, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:24:01', '2021-10-25 08:24:01', 55, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:24:46', '2021-10-25 08:24:46', 56, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:24:46', '2021-10-25 08:24:46', 57, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:43:52', '2021-10-25 08:43:52', 58, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:43:55', '2021-10-25 08:43:55', 59, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 08:43:57', '2021-10-25 08:43:57', 60, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:02:53', '2021-10-25 09:02:53', 61, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:02:53', '2021-10-25 09:02:53', 62, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:03:05', '2021-10-25 09:03:05', 63, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:03:28', '2021-10-25 09:03:28', 64, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:03:28', '2021-10-25 09:03:28', 65, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:03:30', '2021-10-25 09:03:30', 66, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:07:10', '2021-10-25 09:07:10', 67, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:07:10', '2021-10-25 09:07:10', 68, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:07:28', '2021-10-25 09:07:28', 69, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:07:28', '2021-10-25 09:07:28', 70, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:07:31', '2021-10-25 09:07:31', 71, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:09:23', '2021-10-25 09:09:23', 72, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:09:23', '2021-10-25 09:09:23', 73, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:09:28', '2021-10-25 09:09:28', 74, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:13:37', '2021-10-25 09:13:37', 75, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:13:37', '2021-10-25 09:13:37', 76, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:13:58', '2021-10-25 09:13:58', 77, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:14:39', '2021-10-25 09:14:39', 78, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:14:39', '2021-10-25 09:14:39', 79, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:14:42', '2021-10-25 09:14:42', 80, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:17:01', '2021-10-25 09:17:01', 81, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:17:01', '2021-10-25 09:17:01', 82, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:17:24', '2021-10-25 09:17:24', 83, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:17:24', '2021-10-25 09:17:24', 84, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:17:27', '2021-10-25 09:17:27', 85, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:18:33', '2021-10-25 09:18:33', 86, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:18:38', '2021-10-25 09:18:38', 87, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:18:56', '2021-10-25 09:18:56', 88, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:18:56', '2021-10-25 09:18:56', 89, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:19:00', '2021-10-25 09:19:00', 90, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:20:24', '2021-10-25 09:20:24', 91, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:20:24', '2021-10-25 09:20:24', 92, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:20:39', '2021-10-25 09:20:39', 93, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:20:40', '2021-10-25 09:20:40', 94, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:20:40', '2021-10-25 09:20:40', 95, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:21:51', '2021-10-25 09:21:51', 96, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:21:51', '2021-10-25 09:21:51', 97, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:22:06', '2021-10-25 09:22:06', 98, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:22:06', '2021-10-25 09:22:06', 99, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:22:08', '2021-10-25 09:22:08', 100, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:25:20', '2021-10-25 09:25:20', 101, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:25:44', '2021-10-25 09:25:44', 102, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:25:44', '2021-10-25 09:25:44', 103, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:25:48', '2021-10-25 09:25:48', 104, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:27:31', '2021-10-25 09:27:31', 105, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:27:31', '2021-10-25 09:27:31', 106, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:27:54', '2021-10-25 09:27:54', 107, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:27:54', '2021-10-25 09:27:54', 108, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:27:55', '2021-10-25 09:27:55', 109, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:31:50', '2021-10-25 09:31:50', 110, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:31:50', '2021-10-25 09:31:50', 111, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:31:54', '2021-10-25 09:31:54', 112, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:31:56', '2021-10-25 09:31:56', 113, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:31:57', '2021-10-25 09:31:57', 114, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:32:04', '2021-10-25 09:32:04', 115, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:33:17', '2021-10-25 09:33:17', 116, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:33:17', '2021-10-25 09:33:17', 117, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:33:21', '2021-10-25 09:33:21', 118, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:33:23', '2021-10-25 09:33:23', 119, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:33:25', '2021-10-25 09:33:25', 120, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:33:32', '2021-10-25 09:33:32', 121, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:35:15', '2021-10-25 09:35:15', 122, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:35:15', '2021-10-25 09:35:15', 123, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:35:17', '2021-10-25 09:35:17', 124, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:35:18', '2021-10-25 09:35:18', 125, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:35:20', '2021-10-25 09:35:20', 126, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:35:28', '2021-10-25 09:35:28', 127, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:40:39', '2021-10-25 09:40:39', 128, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:40:39', '2021-10-25 09:40:39', 129, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:40:45', '2021-10-25 09:40:45', 130, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:40:47', '2021-10-25 09:40:47', 131, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:40:49', '2021-10-25 09:40:49', 132, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:41:02', '2021-10-25 09:41:02', 133, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:42:15', '2021-10-25 09:42:15', 134, 21, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:42:15', '2021-10-25 09:42:15', 135, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:42:25', '2021-10-25 09:42:25', 136, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:42:27', '2021-10-25 09:42:27', 137, 22, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:42:29', '2021-10-25 09:42:29', 138, 29, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL),
('2021-10-25 09:42:36', '2021-10-25 09:42:36', 139, 35, '188.170.72.151', 'Other', 'okhttp', '4.9.1', 1, NULL, 1, NULL, NULL);

INSERT INTO `analytic_type` (`id`, `title`) VALUES
(1, 'login_wrong_email'),
(2, 'user_visit_login_page'),
(3, 'user_login'),
(4, 'user_wrong_password'),
(5, 'user_logout'),
(6, 'user_begin_registration'),
(7, 'user_registration_email'),
(8, 'user_registration_email_code'),
(9, 'user_registration_phone'),
(10, 'user_registration_phone_code'),
(11, 'user_registration_rights'),
(12, 'user_registration_info'),
(13, 'user_registration_upload_license'),
(14, 'user_end_registration'),
(15, 'user_visit_tariff_plan_page'),
(16, 'user_change_tariff_plan'),
(17, 'user_change_payment_method'),
(18, 'user_create_vacancy_group'),
(19, 'user_create_vacancy'),
(20, 'user_attach_test'),
(21, 'user_visit_vacancy_group_page'),
(22, 'user_visit_vacancy_page'),
(23, 'user_create_test'),
(24, 'user_visit_test_page'),
(25, 'user_edit_test'),
(26, 'user_visit_psych_test_page'),
(27, 'user_edit_psych_test_page'),
(28, 'user_add_test_answer'),
(29, 'user_visit_candidate_list_page'),
(30, 'user_visit_candidate_page'),
(31, 'user_edit_candidate'),
(32, 'user_attach_candidate_vacancy'),
(33, 'user_send_candidate_invitation'),
(34, 'user_change_candidate_status'),
(35, 'user_upload_candidate_cv'),
(36, 'candidate_visit_registration_page'),
(37, 'candidate_start_registration'),
(38, 'candidate_reject_registration'),
(39, 'candidate_registered'),
(40, 'candidate_login'),
(41, 'candidate_logout'),
(42, 'candidate_visit_user_link'),
(43, 'candidate_visit_vacancy_page'),
(44, 'candidate_reject_vacancy'),
(45, 'candidate_send_chat_message'),
(46, 'candidate_begin_test'),
(47, 'candidate_answered_test_question'),
(48, 'candidate_end_test'),
(49, 'candidate_start_recording_video_answer'),
(50, 'candidate_stop_recording_video_answer'),
(51, 'candidate_wrong_password');

INSERT INTO `application_event` (`created`, `updated`, `id`, `application_id`, `read`) VALUES
('2021-10-25 04:39:57', '2021-10-25 04:39:57', 1, 16, 0),
('2021-10-25 04:39:58', '2021-10-25 04:39:58', 2, 16, 0),
('2021-10-25 04:39:59', '2021-10-25 04:39:59', 3, 16, 0),
('2021-10-25 04:40:01', '2021-10-25 04:40:01', 4, 16, 0);

INSERT INTO `application_event_description` (`created`, `updated`, `id`, `text`) VALUES
('2021-10-25 04:39:58', '2021-10-25 04:39:58', 1, 'Candidate sent a message to the chat');

INSERT INTO `application_identity_event` (`created`, `updated`, `id`, `application_event_id`, `event_description_id`) VALUES
('2021-10-25 04:39:58', '2021-10-25 04:39:58', 1, 2, 1);

INSERT INTO `candidate` (`created`, `updated`, `id`, `candidate_description_last_id`, `client_id`, `blocked`, `is_new`, `deleted`) VALUES
('2021-10-25 04:39:05', '2021-10-25 04:39:07', 1, 1, 1, 0, 1, 0),
('2021-10-25 04:39:08', '2021-10-25 04:39:10', 2, 2, 1, 0, 1, 0),
('2021-10-25 04:39:10', '2021-10-25 04:39:12', 3, 3, 1, 0, 1, 0),
('2021-10-25 04:39:13', '2021-10-25 04:39:15', 4, 4, 1, 0, 1, 0),
('2021-10-25 04:39:16', '2021-10-25 04:39:17', 5, 5, 1, 0, 1, 0),
('2021-10-25 04:39:20', '2021-10-25 04:39:22', 6, 6, 1, 0, 1, 0),
('2021-10-25 04:39:22', '2021-10-25 04:39:24', 7, 7, 1, 0, 1, 0),
('2021-10-25 04:39:25', '2021-10-25 04:39:27', 8, 8, 1, 0, 1, 0),
('2021-10-25 04:39:27', '2021-10-25 04:39:30', 9, 9, 1, 0, 1, 0),
('2021-10-25 04:39:30', '2021-10-25 04:39:32', 10, 10, 1, 0, 1, 0),
('2021-10-25 04:39:33', '2021-10-25 04:39:36', 11, 11, 1, 0, 1, 0),
('2021-10-25 04:39:36', '2021-10-25 04:39:38', 12, 12, 1, 0, 1, 0),
('2021-10-25 04:39:39', '2021-10-25 04:39:41', 13, 13, 1, 0, 1, 0),
('2021-10-25 04:39:41', '2021-10-25 04:39:43', 14, 14, 1, 0, 1, 0),
('2021-10-25 04:39:44', '2021-10-25 04:39:46', 15, 15, 1, 0, 1, 0),
('2021-10-25 04:39:46', '2021-10-25 04:39:55', 16, 16, 1, 0, 1, 0),
('2021-10-25 08:26:57', '2021-10-25 08:26:57', 17, 17, 1, 0, 1, 0),
('2021-10-25 09:18:41', '2021-10-25 09:18:42', 18, 18, 1, 0, 1, 0),
('2021-10-25 09:24:08', '2021-10-25 09:24:09', 19, 19, 1, 0, 1, 0),
('2021-10-25 09:31:35', '2021-10-25 09:31:35', 20, 20, 1, 0, 1, 0);

INSERT INTO `candidate_description` (`created`, `updated`, `id`, `candidate_id`, `avatar_url`, `first_name`, `last_name`, `email`, `phone`, `birth_date`, `comments`, `city`) VALUES
('2021-10-25 04:39:06', '2021-10-25 04:39:08', 1, 1, NULL, 'Juan', 'Campos', 'brandy38@gmail.com', NULL, '1985-04-09', 'Would mouth relate own chair. Role together range line. Government first policy daughter. Local tend employee source nature add rest.', 'Seanfurt'),
('2021-10-25 04:39:08', '2021-10-25 04:39:10', 2, 2, NULL, 'Tina', 'Green', 'ivan20@hotmail.com', NULL, '1990-11-26', 'Quickly candidate change although. Together type music hospital.\nMiss dog Democrat quickly stay. Often late produce you true soldier. Food break onto friend.', 'North Davidborough'),
('2021-10-25 04:39:11', '2021-10-25 04:39:13', 3, 3, NULL, 'Catherine', 'Lee', 'woodtina@gmail.com', NULL, '1991-07-01', 'Look road article quickly. International big employee determine positive go Congress.', 'Deborahfurt'),
('2021-10-25 04:39:13', '2021-10-25 04:39:16', 4, 4, NULL, 'Brandon', 'Campbell', 'ellischristian@hotmail.com', NULL, '1989-05-29', 'Good explain grow water plant perform resource. Security stock ball organization recognize civil.', 'Odonnelltown'),
('2021-10-25 04:39:16', '2021-10-25 04:39:18', 5, 5, NULL, 'Amy', 'Mccarty', 'mary06@gmail.com', NULL, '1991-04-25', 'Would I question first. Add senior woman put partner.\nPart cup few read. Beyond take however ball.', 'Staceyshire'),
('2021-10-25 04:39:20', '2021-10-25 04:39:22', 6, 6, NULL, 'Jared', 'Matthews', 'iwatson@gmail.com', '+171101087717', '1981-12-12', 'Character four smile responsibility.\nAlong especially change on guess writer can boy. Value film tax rock few. Federal board night loss front something.', 'South Angelaport'),
('2021-10-25 04:39:23', '2021-10-25 04:39:25', 7, 7, NULL, 'Brenda', 'Jackson', 'rodneyrichardson@yahoo.com', '+171650561659', '1990-04-19', 'Boy state table agree moment sell. Budget huge debate among way.', 'New Chelsea'),
('2021-10-25 04:39:25', '2021-10-25 04:39:27', 8, 8, NULL, 'Nancy', 'Morrison', 'lisa08@gmail.com', '+171500565397', '1988-06-04', 'On responsibility southern at be than. At candidate feel.', 'Port Michelle'),
('2021-10-25 04:39:28', '2021-10-25 04:39:30', 9, 9, NULL, 'Cameron', 'Heath', 'kevinhudson@yahoo.com', '+171222624048', '1985-01-12', 'His himself clearly very dream role. Area along individual man tell response.\nIn partner hit another likely character. Our car food.', 'Port Philipstad'),
('2021-10-25 04:39:31', '2021-10-25 04:39:33', 10, 10, NULL, 'Todd', 'Santana', 'huberrachel@gmail.com', '+171513014907', '1983-11-18', 'Occur democratic behavior standard thousand single recognize. Medical watch certainly through instead base. Indeed between similar safe.', 'Heatherstad'),
('2021-10-25 04:39:33', '2021-10-25 04:39:36', 11, 11, NULL, 'Jamie', 'Nunez', 'chad23@gmail.com', '+171116551297', '1986-01-13', 'Fall ready usually. Teacher cost both general where.\nWhom gun list. Fast there network force or.\nMouth film heavy chair. Source firm drug senior.', 'Chenhaven'),
('2021-10-25 04:39:37', '2021-10-25 04:39:39', 12, 12, NULL, 'Scott', 'Watson', 'butlerjessica@yahoo.com', '+171322410935', '1988-09-16', 'Wear someone everybody newspaper. Somebody land human should. Company where future model green place.', 'Crystaltown'),
('2021-10-25 04:39:39', '2021-10-25 04:39:41', 13, 13, NULL, 'Jennifer', 'Wallace', 'scottalicia@hotmail.com', '+171308589965', '1983-11-12', 'Exist sense training other along society. Move brother teacher three seven.', 'Moralesmouth'),
('2021-10-25 04:39:42', '2021-10-25 04:39:44', 14, 14, NULL, 'Tracy', 'Mason', 'crystal63@yahoo.com', '+171790604616', '1989-03-21', 'Know central many thought. Agent likely thousand act money. Rather bank we under.', 'South Sarah'),
('2021-10-25 04:39:44', '2021-10-25 04:39:46', 15, 15, NULL, 'Kristina', 'Price', 'jasonlopez@yahoo.com', '+171127897377', '1982-07-24', 'Role somebody keep daughter report town. Doctor be cost. Sea quality do father.', 'East Michaelport'),
('2021-10-25 04:39:47', '2021-10-25 04:39:49', 16, 16, NULL, 'Kristin', 'Becker', 'test@candidate.test', '+171503670870', '1988-10-28', 'Newspaper determine cover part paper beat. Follow lay foot agreement and hard. Thank generation study economy rock. Fine team effort gas Republican.', 'Stevensville'),
('2021-10-25 08:26:57', '2021-10-25 08:26:57', 17, 17, NULL, 'Stas', 'Averin', 'averin.developer@gmail.com', NULL, NULL, NULL, NULL),
('2021-10-25 09:18:41', '2021-10-25 09:18:41', 18, 18, NULL, 'Stas', 'Averin', 'averin.developer@gmail.com', NULL, NULL, NULL, NULL),
('2021-10-25 09:24:08', '2021-10-25 09:24:08', 19, 19, NULL, 'Stas', 'Averin', 'averin.developer@gmail.com', NULL, NULL, NULL, NULL),
('2021-10-25 09:31:35', '2021-10-25 09:31:35', 20, 20, NULL, 'Stas', 'Averin', 'averin.developer@gmail.com', NULL, NULL, NULL, NULL);

INSERT INTO `candidate_education` (`created`, `updated`, `id`, `candidate_description_id`, `school`, `specialization`, `begin_date`, `end_date`) VALUES
('2021-10-25 04:39:09', '2021-10-25 04:39:09', 1, 1, 'Novosibirsk State Technical University', 'Financial controller', '2014-07-06', '2020-04-06'),
('2021-10-25 04:39:11', '2021-10-25 04:39:11', 2, 2, 'Novosibirsk State Technical University', 'Nurse, adult', '2016-09-17', '2018-04-28'),
('2021-10-25 04:39:14', '2021-10-25 04:39:14', 3, 3, 'Lomonosov Moscow State University', 'Surveyor, mining', '2013-12-12', '2018-06-20'),
('2021-10-25 04:39:17', '2021-10-25 04:39:17', 4, 4, 'Massachusetts Institute of Technology', 'Journalist, magazine', '2012-02-22', '2019-12-02'),
('2021-10-25 04:39:18', '2021-10-25 04:39:18', 5, 5, 'Novosibirsk State Technical University', 'Translator', '2012-03-03', '2020-10-18'),
('2021-10-25 04:39:23', '2021-10-25 04:39:23', 6, 6, 'Massachusetts Institute of Technology', 'Television/film/video producer', '2015-08-18', '2019-11-23'),
('2021-10-25 04:39:26', '2021-10-25 04:39:26', 7, 7, 'Lomonosov Moscow State University', 'Librarian, public', '2013-09-03', '2017-11-09'),
('2021-10-25 04:39:28', '2021-10-25 04:39:28', 8, 8, 'Novosibirsk State Technical University', 'Academic librarian', '2011-12-27', '2020-08-10'),
('2021-10-25 04:39:31', '2021-10-25 04:39:31', 9, 9, 'Massachusetts Institute of Technology', 'Marketing executive', '2013-06-07', '2019-10-02'),
('2021-10-25 04:39:34', '2021-10-25 04:39:34', 10, 10, 'Lomonosov Moscow State University', 'Administrator', '2014-10-09', '2018-07-28'),
('2021-10-25 04:39:37', '2021-10-25 04:39:37', 11, 11, 'Harvard University', 'Osteopath', '2012-04-21', '2019-06-01'),
('2021-10-25 04:39:40', '2021-10-25 04:39:40', 12, 12, 'Novosibirsk State Technical University', 'Architect', '2012-11-03', '2018-12-18'),
('2021-10-25 04:39:42', '2021-10-25 04:39:42', 13, 13, 'Harvard University', 'Hydrographic surveyor', '2012-12-31', '2020-03-12'),
('2021-10-25 04:39:45', '2021-10-25 04:39:45', 14, 14, 'Novosibirsk State Technical University', 'Interpreter', '2013-01-25', '2020-01-17'),
('2021-10-25 04:39:47', '2021-10-25 04:39:47', 15, 15, 'Massachusetts Institute of Technology', 'Bonds trader', '2011-11-16', '2018-05-31'),
('2021-10-25 04:39:50', '2021-10-25 04:39:50', 16, 16, 'NSU', 'Ceramics designer', '2012-07-16', '2018-11-03');

INSERT INTO `candidate_status` (`created`, `updated`, `id`, `title`) VALUES
('2021-10-25 04:39:02', '2021-10-25 04:39:02', 1, 'New'),
('2021-10-25 04:39:02', '2021-10-25 04:39:02', 2, 'In progress'),
('2021-10-25 04:39:02', '2021-10-25 04:39:02', 3, 'Invited'),
('2021-10-25 04:39:02', '2021-10-25 04:39:02', 4, 'Done');

INSERT INTO `candidate_user` (`created`, `updated`, `id`, `email`, `password`, `candidate_id`) VALUES
('2021-10-25 04:39:56', '2021-10-25 04:39:56', 1, 'test@candidate.test', '$pbkdf2-sha512$25000$6x0DIKTUWst5b23NOacUgg$B8/ybXNQI10bBQVL7qmZMpS7kcxHK.r6bivHysB1LBoov7WLaNNiStdH48xs4yDTynkpumvtorAhL4GaNkU/LA', 16);

INSERT INTO `candidate_user_info` (`created`, `updated`, `id`, `candidate_user_id`, `first_name`, `last_name`, `rights_and_obligation_id`) VALUES
('2021-10-25 04:39:56', '2021-10-25 04:39:56', 1, 1, 'Kristin', 'Becker', 2);

INSERT INTO `client` (`created`, `updated`, `id`, `country`, `number`, `name`, `license_url`, `industry_id`, `is_new`, `blocked`, `client_description_id`, `referral_user_id`) VALUES
('2021-10-25 04:39:01', '2021-10-25 09:31:35', 1, 'US', '123123', 'Chang-Fisher', 'https://google.com', 1, 1, 0, 1, NULL),
('2021-10-25 04:40:04', '2021-10-25 04:40:04', 2, 'RU', 'GB95LHVW84331845357492', 'Pacheco PLC', 'https://google.com', 1, 1, 0, 4, 1),
('2021-10-25 04:40:34', '2021-10-25 04:40:47', 3, 'US', 'GB17UAZE62281237933236', 'Franklin-Anderson', 'https://google.com', 1, 1, 0, 5, NULL),
('2021-10-25 04:40:52', '2021-10-25 04:41:06', 4, 'US', 'GB81HKOV34524059802507', 'Brown, Allen and Smith', 'https://google.com', 1, 1, 0, 6, NULL),
('2021-10-25 04:41:10', '2021-10-25 04:41:24', 5, 'US', 'GB98ECKH23028216919729', 'Williams, Peterson and Rojas', 'https://google.com', 1, 1, 0, 7, NULL);

INSERT INTO `client_description` (`created`, `updated`, `id`, `name`, `description`) VALUES
('2021-10-25 04:38:59', '2021-10-25 04:39:02', 1, 'Untitled', 'Untitled'),
('2021-10-25 04:39:04', '2021-10-25 04:39:04', 2, 'Chang-Fisher', 'Open-architected zero tolerance framework'),
('2021-10-25 04:39:18', '2021-10-25 04:39:32', 3, 'Chang-Fisher', 'Streamlined modular structure'),
('2021-10-25 04:40:02', '2021-10-25 04:40:02', 4, 'Untitled', 'Untitled'),
('2021-10-25 04:40:33', '2021-10-25 04:40:33', 5, 'Untitled', 'Untitled'),
('2021-10-25 04:40:51', '2021-10-25 04:40:51', 6, 'Untitled', 'Untitled'),
('2021-10-25 04:41:09', '2021-10-25 04:41:09', 7, 'Untitled', 'Untitled');

INSERT INTO `cv_upload` (`created`, `updated`, `id`, `uuid`, `state`) VALUES
('2021-10-18 09:46:42', '2021-10-18 09:48:17', 1, '8cde511526d941afa09930eed6ebaae8', 'FINISHED'),
('2021-10-18 09:52:05', '2021-10-18 09:52:14', 2, 'a7887c2a7df64ba7aba7bf569388f2a0', 'PENDING'),
('2021-10-18 09:55:39', '2021-10-18 09:55:44', 3, '7ec24ebcc74b42b1b29677d8eebc2111', 'PENDING'),
('2021-10-18 10:00:05', '2021-10-18 10:00:15', 4, 'd3436d08cf3746a8885df71909110d5b', 'PENDING'),
('2021-10-18 10:00:58', '2021-10-18 10:12:24', 5, '57a92c37b34146a6915a559f20e5527d', 'FINISHED'),
('2021-10-18 10:24:00', '2021-10-19 06:24:17', 6, 'c8e983e314d04827a48405baa08c321f', 'FINISHED'),
('2021-10-18 10:28:40', '2021-10-19 06:24:21', 7, '055cae585186446cb1e62621e7c54f18', 'FINISHED'),
('2021-10-18 10:33:05', '2021-10-19 06:23:35', 8, '49a45202086745c5ad6f8836d3954310', 'FINISHED'),
('2021-10-19 09:21:40', '2021-10-19 09:22:07', 9, 'e9c7b4a615e944c483fc9d172339db0c', 'FINISHED'),
('2021-10-19 10:19:45', '2021-10-19 10:20:43', 10, 'cc8473c184bd48c7b502388087078353', 'FINISHED'),
('2021-10-19 10:41:23', '2021-10-19 10:41:52', 11, '69e44133fb8741d483b08ff948cc049f', 'FINISHED'),
('2021-10-19 10:41:51', '2021-10-19 10:41:53', 12, '1ca1c6fdd7bc4495b624c01be4165755', 'PENDING'),
('2021-10-19 10:48:28', '2021-10-19 10:48:35', 13, '163ed1c81d7f46a0b7eeb0fef6dfdffa', 'PENDING'),
('2021-10-19 10:51:16', '2021-10-19 10:51:19', 14, '628eb8fb4ec2418a85dfc5f08f794eb4', 'PENDING'),
('2021-10-19 10:54:20', '2021-10-19 10:54:23', 15, 'ee743e4c0e7946ed983bdfa97f55ad26', 'PENDING'),
('2021-10-19 10:55:09', '2021-10-19 10:55:12', 16, '6848b01232f54b2d861c5557d2ff2f2d', 'PENDING'),
('2021-10-19 13:04:24', '2021-10-19 13:04:31', 17, 'c8055b1752ba48d88fb09f90628aceac', 'PENDING'),
('2021-10-19 13:16:33', '2021-10-19 13:16:40', 18, 'a53b344b49374c8aa1c1a85b71dcb0be', 'PENDING'),
('2021-10-19 13:21:03', '2021-10-19 13:21:06', 19, '503d124528b84a67aed478280d7fe7e9', 'PENDING'),
('2021-10-19 13:21:48', '2021-10-19 13:21:52', 20, '11a516e887744279aae00a1b7f830171', 'PENDING'),
('2021-10-19 13:24:10', '2021-10-19 13:24:12', 21, 'e68d83cedbda47f5bb920dce45714ae8', 'PENDING'),
('2021-10-19 13:24:53', '2021-10-19 13:24:55', 22, 'ec817e93274c44b0bbfed4603c7d5b91', 'PENDING'),
('2021-10-19 13:40:13', '2021-10-19 13:40:20', 23, '2b7e88788bfd494babb25ce37887d6aa', 'PENDING'),
('2021-10-19 15:11:04', '2021-10-19 15:11:14', 24, '67d688ccd2c848aebb39626c0d4c8b3e', 'PENDING'),
('2021-10-19 15:12:33', '2021-10-19 15:14:16', 25, '9eeea7ab3bd34a37a1ae8a0d681ea0fd', 'FINISHED'),
('2021-10-19 15:18:16', '2021-10-19 15:19:15', 26, '5cea2d5520bf4237b2adc0212e7785ed', 'PENDING'),
('2021-10-19 15:18:35', '2021-10-19 15:19:42', 27, '920e66308d1c47388e17ba110ace41df', 'PENDING'),
('2021-10-20 08:38:32', '2021-10-20 08:38:40', 28, '1974e18928fe47b0ac0d3349b97e3ee3', 'PENDING'),
('2021-10-20 08:40:38', '2021-10-20 08:40:42', 29, '372d132893d2473cbd3706582de496c6', 'PENDING'),
('2021-10-20 09:05:20', '2021-10-20 09:05:28', 30, 'ba25da4b4f044744b27f63307495d081', 'PENDING'),
('2021-10-20 09:05:43', '2021-10-20 09:05:46', 31, 'e21b0a7cecaa4698b870e6fbe980b69f', 'PENDING'),
('2021-10-20 09:47:36', '2021-10-20 09:47:45', 32, 'f0d8b807987944478bedf7bf70496072', 'PENDING'),
('2021-10-20 09:52:46', '2021-10-20 09:53:46', 33, 'fec07622c17e48a38d4fa4d51f4d9117', 'PENDING'),
('2021-10-20 10:05:09', '2021-10-20 10:05:17', 34, '8a90fc71b33344b2a9c9cea0de78ff82', 'PENDING'),
('2021-10-20 10:05:37', '2021-10-20 10:05:42', 35, 'ac2e51ab18614a41a4b2d0e60e2427a6', 'PENDING'),
('2021-10-20 10:07:59', '2021-10-20 10:08:03', 36, '1e7cb606a2614068b80ce61557514fec', 'PENDING'),
('2021-10-20 10:58:55', '2021-10-20 10:58:55', 37, '66fcded88257405f903aaab024efd195', 'STARTED'),
('2021-10-20 10:59:06', '2021-10-20 10:59:06', 38, '47b310f0468745ccad49ad826ae43835', 'STARTED'),
('2021-10-20 10:59:46', '2021-10-20 10:59:55', 39, '2d4fac21b9a747d28b02ae96befc6a7b', 'PENDING'),
('2021-10-20 11:12:58', '2021-10-20 11:13:07', 40, '1ae44e7950cf46528d40df9fec161d74', 'PENDING'),
('2021-10-20 11:16:37', '2021-10-20 11:17:46', 41, '037d8a5a4a5948bdbad1d5c772b9eef0', 'PENDING');

INSERT INTO `cv_upload_file` (`created`, `updated`, `id`, `uuid`, `s3_url`, `s3_key`, `state`, `error_message`, `candidate_id`, `client_id`) VALUES
('2021-10-25 06:54:36', '2021-10-25 06:57:06', 1, '767355721fcb40288b3b3d06004d2ee0', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/507385c1-4978-47ea-950e-957507b6c8f9.pdf', 'resume/507385c1-4978-47ea-950e-957507b6c8f9.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 07:16:43', '2021-10-25 07:17:24', 2, 'd1fc8798fe27475b99cc16087001b500', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/b306a9f7-c557-405a-89d4-926521540d39.pdf', 'resume/b306a9f7-c557-405a-89d4-926521540d39.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 07:29:22', '2021-10-25 07:30:22', 3, '14b3f072daa54f648cc791da1de4a100', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/1de2e603-c364-42b9-aa6f-6dba0c097242.pdf', 'resume/1de2e603-c364-42b9-aa6f-6dba0c097242.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 07:33:27', '2021-10-25 07:33:34', 4, '9fdd9c0a19184fb2b8dd091386f33e5d', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/62ec4ce2-f89c-4689-82c4-ab583f8320ea.pdf', 'resume/62ec4ce2-f89c-4689-82c4-ab583f8320ea.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 07:33:27', '2021-10-25 07:33:34', 5, '44386701244341e7ae37eb0af903e036', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/0e97e221-b9b2-48f5-af54-5221981e2370.docx', 'resume/0e97e221-b9b2-48f5-af54-5221981e2370.docx', 'PENDING', NULL, NULL, 1),
('2021-10-25 07:33:27', '2021-10-25 07:33:29', 6, '083caa1e16c342e1aa9e5d25c3b408bc', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/5774139d-5b74-4bb8-a17d-0cb0fb96d333.pdf', 'resume/5774139d-5b74-4bb8-a17d-0cb0fb96d333.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 08:23:55', '2021-10-25 08:24:03', 7, '2769cb9f30b74390a0f64763e9735a43', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/bb0e51d0-ed83-4922-a705-c324ad59a7ab.pdf', 'resume/bb0e51d0-ed83-4922-a705-c324ad59a7ab.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 08:23:56', '2021-10-25 08:24:03', 8, '2263c7cb4e2b4dbeb6418ee6fe43b01a', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/fc41cc46-28ed-4e12-96a8-f18c07aa6425.pdf', 'resume/fc41cc46-28ed-4e12-96a8-f18c07aa6425.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 08:23:56', '2021-10-25 08:24:03', 9, '2a8ad9e9b61443c6be56c3f6eaedb9c6', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/7e8e1dea-98a6-4d98-a6ee-381eb36caa8e.pdf', 'resume/7e8e1dea-98a6-4d98-a6ee-381eb36caa8e.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 08:23:56', '2021-10-25 08:26:12', 10, '2e0517bfdc0d400d96f2546c8e6c10fd', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/d650c7c1-b369-4738-97c8-3326659c1d43.docx', 'resume/d650c7c1-b369-4738-97c8-3326659c1d43.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 08:23:56', '2021-10-25 08:24:03', 11, '2e4fc1c8015d416090542234338733df', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/9c34e0e1-b30c-4266-8511-dfcbe0367361.pdf', 'resume/9c34e0e1-b30c-4266-8511-dfcbe0367361.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 08:23:56', '2021-10-25 08:26:20', 12, '2e28fad9f0e84f2a8e5e18128ae489f0', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/99b749e5-77a6-426f-a44f-733d83060795.pdf', 'resume/99b749e5-77a6-426f-a44f-733d83060795.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 08:23:56', '2021-10-25 08:26:57', 13, 'bbec0ca4394649c5bfc06c98546f3f86', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/504ca5ce-efd0-4cf0-9218-4849b99e39b0.docx', 'resume/504ca5ce-efd0-4cf0-9218-4849b99e39b0.docx', 'FINISHED', NULL, 17, 1),
('2021-10-25 08:43:55', '2021-10-25 08:44:21', 14, 'bf509f55d82a46d09b999f574a81ccaa', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/2c38a5d3-ea6d-402a-bf97-5f8bc27d5578.docx', 'resume/2c38a5d3-ea6d-402a-bf97-5f8bc27d5578.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 08:43:55', '2021-10-25 08:44:47', 15, 'd68b7d0ce6844f4eb5158aa573ed3a85', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/f2aed62c-d3e3-4bad-a41e-c7a40851a38f.docx', 'resume/f2aed62c-d3e3-4bad-a41e-c7a40851a38f.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 08:43:55', '2021-10-25 08:44:02', 16, '16ba176f9d8644acb1353e9e7c148cb8', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/142d722e-8c8e-414c-99b8-d532b01d941e.pdf', 'resume/142d722e-8c8e-414c-99b8-d532b01d941e.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 08:43:55', '2021-10-25 08:44:49', 17, '3dc5ca4d7020462b96fe1b082cf929eb', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/da682813-6e14-4751-9eb5-bba10965f6f2.pdf', 'resume/da682813-6e14-4751-9eb5-bba10965f6f2.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:03:30', '2021-10-25 09:03:57', 18, 'baa34e0f57464ca8b61e4d936baf4e34', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/abec974c-13e6-4635-a288-0ca5d212df8b.docx', 'resume/abec974c-13e6-4635-a288-0ca5d212df8b.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:03:30', '2021-10-25 09:03:38', 19, '743da8e1e5e74dda8d998db31294dbe2', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/12221de4-683d-4cdf-a690-0d66dda42b9c.pdf', 'resume/12221de4-683d-4cdf-a690-0d66dda42b9c.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:03:30', '2021-10-25 09:04:23', 20, '1153a97a2a7c4d05a767af79fbe63c7c', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/436e0499-0e3b-42ef-875d-3539933ad6dc.docx', 'resume/436e0499-0e3b-42ef-875d-3539933ad6dc.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:03:30', '2021-10-25 09:04:24', 21, 'ff4683067e074ddcb35108d499c1dd19', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/ef0e4c91-fe68-4526-9998-e8c846562dbf.pdf', 'resume/ef0e4c91-fe68-4526-9998-e8c846562dbf.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:07:31', '2021-10-25 09:17:00', 22, 'fa064832cde44ae0989a3ce5de4af841', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/e5e531d8-0c41-4f9e-b5d7-6d0eca92f583.docx', 'resume/e5e531d8-0c41-4f9e-b5d7-6d0eca92f583.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:07:31', '2021-10-25 09:07:35', 23, '695985de46cb4e40a0c6f6c631c03fa4', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/a4e58f10-7d82-4bfe-94be-cf9e353e9039.pdf', 'resume/a4e58f10-7d82-4bfe-94be-cf9e353e9039.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:07:31', '2021-10-25 09:07:34', 24, '5f124b7a7c894d5385a9d94bd4dc9f46', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/45ae330e-958a-4419-8872-960176f0ca81.pdf', 'resume/45ae330e-958a-4419-8872-960176f0ca81.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:07:31', '2021-10-25 09:17:18', 25, 'ba6c786de7224866b5eca7e119c8443c', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/869eeb3b-b1fe-43aa-9f6e-cd860a5312cc.pdf', 'resume/869eeb3b-b1fe-43aa-9f6e-cd860a5312cc.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:09:27', '2021-10-25 09:09:34', 26, '1adb0899bb4d4174847db33e78a88ef7', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/3c09379c-0272-4934-b085-038664fb9d3e.pdf', 'resume/3c09379c-0272-4934-b085-038664fb9d3e.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:09:28', '2021-10-25 09:17:26', 27, 'ab1b0914c2094735b1f7b0f21bad42a4', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/9183a110-7c7a-4e81-8a5f-fe05a44b59c8.docx', 'resume/9183a110-7c7a-4e81-8a5f-fe05a44b59c8.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:09:28', '2021-10-25 09:09:32', 28, '24748c91085c4a22a8879302812751ff', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/208356a3-d48f-44a8-bb69-8df7e21388b2.pdf', 'resume/208356a3-d48f-44a8-bb69-8df7e21388b2.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:09:28', '2021-10-25 09:09:30', 29, '16866db7c4f349a3888e8495ca405fd9', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/39fb6079-ddc5-491d-97f8-db058b2fda02.pdf', 'resume/39fb6079-ddc5-491d-97f8-db058b2fda02.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:09:28', '2021-10-25 09:17:38', 30, '4891649cfaef4e86b14bed37da9084a0', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/a2c35feb-4269-479f-88f5-b71849499e0c.pdf', 'resume/a2c35feb-4269-479f-88f5-b71849499e0c.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:09:28', '2021-10-25 09:09:34', 31, 'c85980afabc84bb1878811e9851ba2e4', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/45a0fba0-4066-40e5-aa7e-e56e4dd9f243.docx', 'resume/45a0fba0-4066-40e5-aa7e-e56e4dd9f243.docx', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:09:28', '2021-10-25 09:09:30', 32, '4ed99098e97f4c40afc8d08882c88081', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/faa7e061-9c37-4065-8c19-363e476fc75a.pdf', 'resume/faa7e061-9c37-4065-8c19-363e476fc75a.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:14:41', '2021-10-25 09:14:44', 33, '030bfb632f034112b8ddd369f21fd963', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/1622f0c4-51ea-4295-b444-64717a5c14cc.pdf', 'resume/1622f0c4-51ea-4295-b444-64717a5c14cc.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:14:41', '2021-10-25 09:14:44', 34, '2a522b1ce0b64a7f9c339434a8d24c34', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/f6868519-695a-4b32-8703-0c552fcfd3e6.pdf', 'resume/f6868519-695a-4b32-8703-0c552fcfd3e6.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:14:41', '2021-10-25 09:18:42', 35, '7b6cf6f80e5a40428a57643e6934b72e', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/e42cf7f7-ff6d-49df-8319-25dbb535eb5c.docx', 'resume/e42cf7f7-ff6d-49df-8319-25dbb535eb5c.docx', 'FINISHED', NULL, 18, 1),
('2021-10-25 09:14:41', '2021-10-25 09:14:44', 36, '4f147f6784bf491d99e52cee9e9c98a1', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/890bc607-1a43-493a-9c32-f230d2d3e6b5.pdf', 'resume/890bc607-1a43-493a-9c32-f230d2d3e6b5.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:17:26', '2021-10-25 09:17:29', 37, 'e94be3758b7644deb2435c89ba54e732', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/6a5d6f78-1a62-4713-83a8-da837b690d29.pdf', 'resume/6a5d6f78-1a62-4713-83a8-da837b690d29.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:17:26', '2021-10-25 09:19:46', 38, '46f51e7c13e0455eb6f96d5dedfda1f5', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/8bf116f5-3ea8-4236-af7c-e93ae1e8e49e.docx', 'resume/8bf116f5-3ea8-4236-af7c-e93ae1e8e49e.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:17:26', '2021-10-25 09:17:30', 39, '832057db5d9c4aa9ba99095bff4d1977', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/df9e1a9b-0beb-4d0d-b101-bd0635a844ea.pdf', 'resume/df9e1a9b-0beb-4d0d-b101-bd0635a844ea.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:17:26', '2021-10-25 09:19:09', 40, '67f3b04aaef04856a4c0f68984006d48', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/a14296b0-af23-4c45-a57e-2561b3584997.pdf', 'resume/a14296b0-af23-4c45-a57e-2561b3584997.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:17:26', '2021-10-25 09:24:09', 41, '34d06bc664fb424c9fbaeb9f32e987fb', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/4a6f5b7d-648c-40c0-9823-4163bf992ecc.docx', 'resume/4a6f5b7d-648c-40c0-9823-4163bf992ecc.docx', 'FINISHED', NULL, 19, 1),
('2021-10-25 09:18:59', '2021-10-25 09:19:02', 42, '26ee431af6f3414e91152228ece3c55a', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/d4f1db94-244e-4147-b856-72efaa6fe2c2.pdf', 'resume/d4f1db94-244e-4147-b856-72efaa6fe2c2.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:18:59', '2021-10-25 09:53:38', 43, 'e572d29a6367458b81a955a2d1f869a8', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/b7be43f0-be26-4baf-92aa-012f512966b3.docx', 'resume/b7be43f0-be26-4baf-92aa-012f512966b3.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:18:59', '2021-10-25 09:19:02', 44, '62d2a16d18d346c19039de31506878ca', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/26a69a8e-2503-4fc5-87cb-2640126b0698.pdf', 'resume/26a69a8e-2503-4fc5-87cb-2640126b0698.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:18:59', '2021-10-25 09:26:31', 45, '74182b86201147d2914c8bd7018bcbf6', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/5706b635-b6bc-4365-afd4-b7a12b7c9350.pdf', 'resume/5706b635-b6bc-4365-afd4-b7a12b7c9350.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:18:59', '2021-10-25 09:19:06', 46, '8c565c7cde014162843d8deeb4e401a5', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/562ae1b3-eddd-4392-86ef-ad90a354c61b.docx', 'resume/562ae1b3-eddd-4392-86ef-ad90a354c61b.docx', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:18:59', '2021-10-25 09:19:02', 47, 'd37104d0c89a4746b5954cfa623ecf91', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/1892120f-e17e-477a-906f-4dea94f0e0df.pdf', 'resume/1892120f-e17e-477a-906f-4dea94f0e0df.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:20:40', '2021-10-25 09:20:42', 48, '225a05b790ff4ae6997d6e69baeb7db4', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/f478bbb6-f7d6-4da9-9a87-356863830795.pdf', 'resume/f478bbb6-f7d6-4da9-9a87-356863830795.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:20:40', '2021-10-25 09:20:42', 49, 'eedad1d47a1e4e5d9d18d3f5d90ca8dd', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/c225a674-0836-44aa-b3cf-330d3a92d207.pdf', 'resume/c225a674-0836-44aa-b3cf-330d3a92d207.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:22:07', '2021-10-25 09:31:11', 50, '934a85df2db0406ba20ca9492afc28eb', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/4c72cfb6-5317-4b5d-84c1-108791879c02.docx', 'resume/4c72cfb6-5317-4b5d-84c1-108791879c02.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:22:08', '2021-10-25 09:22:11', 51, 'fdac1bdc81334a278d535b5010e61b2d', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/8cdfbc1d-ade9-4c6b-aba8-6f521fe0f0b5.pdf', 'resume/8cdfbc1d-ade9-4c6b-aba8-6f521fe0f0b5.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:22:08', '2021-10-25 09:31:17', 52, '0353d7fdf0514593b9f443acaead4634', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/6d811053-441b-4956-8d42-799025133e59.pdf', 'resume/6d811053-441b-4956-8d42-799025133e59.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:25:44', '2021-10-25 09:25:48', 53, 'b1fafdbc09db424da590a333e80763cf', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/d51072f3-8fac-487c-9404-9a5234b3d9b3.pdf', 'resume/d51072f3-8fac-487c-9404-9a5234b3d9b3.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:25:44', '2021-10-25 09:25:47', 54, '864b04ca0977404abffdf439b2c4ef32', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/0909c64b-c57c-4a14-8a2c-1075cca62671.pdf', 'resume/0909c64b-c57c-4a14-8a2c-1075cca62671.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:25:44', '2021-10-25 09:31:35', 55, '5bb63f08d96d437bad7085139a82ac7a', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/90656d0c-6a8e-4895-886a-def115455bf3.docx', 'resume/90656d0c-6a8e-4895-886a-def115455bf3.docx', 'FINISHED', NULL, 20, 1),
('2021-10-25 09:25:44', '2021-10-25 09:31:26', 56, '1e62b39ed39d4e80bad6400b9950bf08', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/791b496d-f567-4b23-8b29-6bddc4a57c58.pdf', 'resume/791b496d-f567-4b23-8b29-6bddc4a57c58.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:25:44', '2021-10-25 09:25:46', 57, 'f13f80cbc96244f48defab734549a04f', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/a16b5646-359f-4831-bae5-ad4e6e4939ed.pdf', 'resume/a16b5646-359f-4831-bae5-ad4e6e4939ed.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:27:54', '2021-10-25 09:27:57', 58, 'd73b8c3366074c36ac9e724476d58132', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/1a2e3e48-20dd-41de-8849-72971cbe32b3.pdf', 'resume/1a2e3e48-20dd-41de-8849-72971cbe32b3.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:27:54', '2021-10-25 09:27:57', 59, 'f2dd8003e1744651967c3ef7e58aa1ba', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/9ccf0462-44cf-4d13-94ab-c094c91dadb6.pdf', 'resume/9ccf0462-44cf-4d13-94ab-c094c91dadb6.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:27:55', '2021-10-25 09:27:57', 60, '68645d0f7a11443eb743cf467f3a47e5', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/3dbb5201-9d22-41f8-b048-97cedb65c9d8.docx', 'resume/3dbb5201-9d22-41f8-b048-97cedb65c9d8.docx', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:27:55', '2021-10-25 09:31:55', 61, '840ab20ca3644b3294d9143cb40256a9', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/a1faf8c7-d8c4-43f9-a541-1cc325f73957.pdf', 'resume/a1faf8c7-d8c4-43f9-a541-1cc325f73957.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:27:55', '2021-10-25 09:27:57', 62, '7e056cd5546a466caf04e41b1a43450d', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/b871a277-0613-4983-8f53-4df9ecd0ebb5.pdf', 'resume/b871a277-0613-4983-8f53-4df9ecd0ebb5.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:32:04', '2021-10-25 09:32:07', 63, '4a14ef2655ee4ce58ba98e8940bd7411', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/5ef50faa-112d-4553-ae33-e0eb22294de0.pdf', 'resume/5ef50faa-112d-4553-ae33-e0eb22294de0.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:33:32', '2021-10-25 09:53:40', 64, 'f791ce1037b74799b132090c78445219', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/7120650c-a7a2-4495-b6a0-db3a4e9032ba.pdf', 'resume/7120650c-a7a2-4495-b6a0-db3a4e9032ba.pdf', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:33:32', '2021-10-25 09:33:37', 65, '0bcf09a7b8ea4d5abcd5a6a0274b80d9', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/70587d63-f869-412e-bcbf-2685016b214f.pdf', 'resume/70587d63-f869-412e-bcbf-2685016b214f.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:35:28', '2021-10-25 09:35:32', 66, '730558e294984e79a392b7e7c999cb18', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/cf9ea9f0-aa54-42af-aa72-dabca356161d.pdf', 'resume/cf9ea9f0-aa54-42af-aa72-dabca356161d.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:35:28', '2021-10-25 09:35:31', 67, '7506a899bfc14fd0a4ddb01b10362ed5', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/04e8cb9e-f4fe-4aa6-bc71-12e8f737fb0e.pdf', 'resume/04e8cb9e-f4fe-4aa6-bc71-12e8f737fb0e.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:35:28', '2021-10-25 10:01:05', 68, '309eff520df148cebda5e4abec1b491c', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/ac52aceb-1e1d-43b7-a0c1-0b22e914f813.docx', 'resume/ac52aceb-1e1d-43b7-a0c1-0b22e914f813.docx', 'ERRORED', 'Empty email on CV', NULL, 1),
('2021-10-25 09:41:02', '2021-10-25 09:41:08', 69, '6874d8a570964b498edf86fa3f5dcad4', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/5b2a455d-fcd4-446c-861f-6c09cba402dd.pdf', 'resume/5b2a455d-fcd4-446c-861f-6c09cba402dd.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:41:02', '2021-10-25 09:41:08', 70, '1fd99163fd404bfe86e81f3b10d0ea73', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/716d124e-fb49-4dbf-9f3d-e35aa75b92a7.pdf', 'resume/716d124e-fb49-4dbf-9f3d-e35aa75b92a7.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:42:36', '2021-10-25 09:42:39', 71, '7f3ea3ba98dc467daa3240c3c7681aa3', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/86acfdf2-3cbc-4367-b1e4-9a07f38b821b.pdf', 'resume/86acfdf2-3cbc-4367-b1e4-9a07f38b821b.pdf', 'PENDING', NULL, NULL, 1),
('2021-10-25 09:42:36', '2021-10-25 09:53:42', 72, 'a337361a3bf04e358d648263954d5fab', 'https://d16yv1e7kbtbyx.cloudfront.net/resume/81cb9ab1-9504-44ec-b854-385e72c9b531.docx', 'resume/81cb9ab1-9504-44ec-b854-385e72c9b531.docx', 'ERRORED', 'Empty email on CV', NULL, 1);

INSERT INTO `industry` (`created`, `updated`, `id`, `title`) VALUES
('2021-10-25 04:38:59', '2021-10-25 04:41:09', 1, 'IT'),
('2021-10-25 04:39:00', '2021-10-25 04:39:00', 2, 'Oil production'),
('2021-10-25 04:39:00', '2021-10-25 04:39:00', 3, 'Education');

INSERT INTO `referral_bank_info` (`created`, `updated`, `id`, `iban`, `bic`) VALUES
('2021-10-25 04:40:02', '2021-10-25 04:40:02', 1, 'GB81DRJT83478978443019', 'GB14ZWDF63340886016419');

INSERT INTO `referral_company` (`created`, `updated`, `id`, `vat`, `name`, `number_company`, `industry_id`) VALUES
('2021-10-25 04:40:03', '2021-10-25 04:40:03', 1, '047916869', 'Haley and Sons', '083245565', 1);

INSERT INTO `referral_document` (`created`, `updated`, `id`, `uuid`, `referral_user_id`, `type`, `document`, `document_s3_key`) VALUES
('2021-10-25 04:40:04', '2021-10-25 04:40:04', 1, '86fe2c63d4f34f589a81f46ac807d15c', 1, 'LICENSE', NULL, NULL),
('2021-10-25 04:40:04', '2021-10-25 04:40:04', 2, 'e6cbce9efffc4370b1a815d18841c0ad', 1, 'PASSPORT', NULL, NULL),
('2021-10-25 04:40:05', '2021-10-25 04:40:05', 3, 'b7db602d2b3c473cab8f1844fbd2915b', 1, 'ID_CARD', NULL, NULL);

INSERT INTO `referral_info` (`created`, `updated`, `id`, `first_name`, `last_name`, `birthday`, `country`) VALUES
('2021-10-25 04:40:02', '2021-10-25 04:40:02', 1, 'Corey', 'Cannon', '1988-11-09', 'US');

INSERT INTO `referral_user` (`created`, `updated`, `id`, `phone`, `email`, `password`, `key`, `right_and_obligation_id`, `referral_company_id`, `referral_bank_info_id`, `referral_info_id`) VALUES
('2021-10-25 04:40:03', '2021-10-25 04:40:03', 1, '+171731949191', 'test@referral.test', '$pbkdf2-sha512$25000$7P1f6z3n/F.L8f5/T.k95w$iDkROB8T5bO/sRtEVH0Ha7TJaLuaWNOczEAQbNoSSAeANHMrD/kYGRqg7fYgjwD2MLJlLvN8cpBWmOc/kjEpMg', '725a61fa269e4d42bfb31457c62e747f', 3, 1, 1, 1);

INSERT INTO `rights_and_obligations` (`created`, `updated`, `id`, `type`, `text`) VALUES
('2021-10-25 04:39:00', '2021-10-25 04:41:24', 1, 'USER', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
('2021-10-25 04:39:00', '2021-10-25 04:39:00', 2, 'CANDIDATE', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
('2021-10-25 04:39:00', '2021-10-25 04:39:00', 3, 'REFERRAL', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.');

INSERT INTO `seller_document` (`created`, `updated`, `id`, `seller_user_id`, `uuid`, `document_url`, `document_s3_key`) VALUES
('2021-10-25 04:40:34', '2021-10-25 04:40:34', 1, 1, NULL, NULL, NULL);

INSERT INTO `seller_info` (`created`, `updated`, `id`, `seller_user_id`, `phone`, `first_name`, `last_name`, `salary`, `num_id_card`) VALUES
('2021-10-25 04:40:34', '2021-10-25 04:40:34', 1, 1, NULL, 'William', 'Richardson', NULL, NULL);

INSERT INTO `seller_invited` (`created`, `updated`, `id`, `seller_user_id`, `user_id`) VALUES
('2021-10-25 04:40:35', '2021-10-25 04:40:35', 1, 1, 2),
('2021-10-25 04:40:38', '2021-10-25 04:40:38', 2, 1, 3),
('2021-10-25 04:40:42', '2021-10-25 04:40:42', 3, 1, 4),
('2021-10-25 04:40:45', '2021-10-25 04:40:45', 4, 1, 5),
('2021-10-25 04:40:49', '2021-10-25 04:40:49', 5, 1, 6),
('2021-10-25 04:40:53', '2021-10-25 04:40:53', 6, 1, 7),
('2021-10-25 04:40:56', '2021-10-25 04:40:56', 7, 1, 8),
('2021-10-25 04:41:00', '2021-10-25 04:41:00', 8, 1, 9),
('2021-10-25 04:41:03', '2021-10-25 04:41:03', 9, 1, 10),
('2021-10-25 04:41:07', '2021-10-25 04:41:07', 10, 1, 11),
('2021-10-25 04:41:11', '2021-10-25 04:41:11', 11, 1, 12),
('2021-10-25 04:41:15', '2021-10-25 04:41:15', 12, 1, 13),
('2021-10-25 04:41:18', '2021-10-25 04:41:18', 13, 1, 14),
('2021-10-25 04:41:22', '2021-10-25 04:41:22', 14, 1, 15),
('2021-10-25 04:41:25', '2021-10-25 04:41:25', 15, 1, 16);

INSERT INTO `seller_plan` (`created`, `updated`, `id`, `seller_user_id`, `plan`, `calendar_segment`) VALUES
('2021-10-25 04:40:34', '2021-10-25 04:40:34', 1, 1, 112, 'MONTH');

INSERT INTO `seller_user` (`created`, `updated`, `id`, `email`, `password`, `deleted`) VALUES
('2021-10-25 04:40:33', '2021-10-25 04:41:25', 1, 'test@seller.test', '$pbkdf2-sha512$25000$UMpZi7GWspaS8t6b816r9Q$taLuomck0854P2xVfrnGsl9mz7upsQyhV3WjN1jCSdL2ZrwEztgFwkXrBIJherFJQ0/O0zBCg/ws9WjGlkEHjw', 0);

INSERT INTO `test` (`created`, `updated`, `id`, `type`, `client_id`, `time`, `title`, `deleted`) VALUES
('2021-10-25 04:39:50', '2021-10-25 04:39:50', 1, 'BASIC', 1, 120, 'Which Teenage Mutant Ninja Turtles Character Are You?', 0),
('2021-10-25 04:40:05', '2021-10-25 04:40:05', 2, 'BASIC', 1, 60, 'Which Famous Dog Should You Adopt?', 0),
('2021-10-25 04:40:12', '2021-10-25 04:40:12', 3, 'BASIC', 1, 60, 'Try To Crack These Impossible Equations', 0),
('2021-10-25 04:40:21', '2021-10-25 04:40:21', 4, 'PSYCHOLOGICAL', 1, 60, 'Try To Crack These Impossible Equations', 0);

INSERT INTO `test_answer` (`created`, `updated`, `id`, `question_id`, `score`, `text`) VALUES
('2021-10-25 04:39:51', '2021-10-25 04:39:51', 1, 1, 10, 'Emotional Awareness'),
('2021-10-25 04:39:51', '2021-10-25 04:39:51', 2, 1, 20, 'Inner Wisdom'),
('2021-10-25 04:39:52', '2021-10-25 04:39:52', 3, 1, 30, 'Technology Savvy'),
('2021-10-25 04:39:52', '2021-10-25 04:39:52', 4, 1, 40, 'Street Smarts'),
('2021-10-25 04:39:52', '2021-10-25 04:39:52', 5, 2, 10, 'Purple'),
('2021-10-25 04:39:52', '2021-10-25 04:39:52', 6, 2, 20, 'Black'),
('2021-10-25 04:39:52', '2021-10-25 04:39:52', 7, 2, 30, 'Brown'),
('2021-10-25 04:39:52', '2021-10-25 04:39:52', 8, 2, 40, 'Blue'),
('2021-10-25 04:39:53', '2021-10-25 04:39:53', 9, 2, 40, 'Red'),
('2021-10-25 04:39:53', '2021-10-25 04:39:53', 10, 2, 40, 'Yellow'),
('2021-10-25 04:39:53', '2021-10-25 04:39:53', 11, 3, 10, 'Tiger'),
('2021-10-25 04:39:53', '2021-10-25 04:39:53', 12, 3, 20, 'Eagle'),
('2021-10-25 04:39:53', '2021-10-25 04:39:53', 13, 3, 30, 'Monkey'),
('2021-10-25 04:39:54', '2021-10-25 04:39:54', 14, 3, 40, 'Shark'),
('2021-10-25 04:39:54', '2021-10-25 04:39:54', 15, 4, 10, 'Take a deep breath and calmly excuse yourself'),
('2021-10-25 04:39:54', '2021-10-25 04:39:54', 16, 4, 20, 'Bluntly ask them why they choose to be so friggin\'s annoying!'),
('2021-10-25 04:39:54', '2021-10-25 04:39:54', 17, 4, 30, 'Politely inform them of their annoyance'),
('2021-10-25 04:40:06', '2021-10-25 04:40:08', 18, 5, 10, 'Green'),
('2021-10-25 04:40:06', '2021-10-25 04:40:06', 19, 5, 20, 'Yellow'),
('2021-10-25 04:40:06', '2021-10-25 04:40:06', 20, 5, 30, 'White'),
('2021-10-25 04:40:06', '2021-10-25 04:40:06', 21, 5, 40, 'Blue'),
('2021-10-25 04:40:06', '2021-10-25 04:40:06', 22, 6, 10, 'How loyal he is'),
('2021-10-25 04:40:07', '2021-10-25 04:40:07', 23, 6, 20, 'How unique he is'),
('2021-10-25 04:40:07', '2021-10-25 04:40:08', 24, 6, 30, 'How smart he is'),
('2021-10-25 04:40:13', '2021-10-25 04:40:13', 25, 7, 10, '42'),
('2021-10-25 04:40:14', '2021-10-25 04:40:14', 26, 7, 20, '24'),
('2021-10-25 04:40:14', '2021-10-25 04:40:17', 27, 8, 10, '1'),
('2021-10-25 04:40:14', '2021-10-25 04:40:14', 28, 8, 20, '9'),
('2021-10-25 04:40:14', '2021-10-25 04:40:14', 29, 9, 10, '2'),
('2021-10-25 04:40:14', '2021-10-25 04:40:17', 30, 9, 20, '11'),
('2021-10-25 04:40:23', '2021-10-25 04:40:23', 31, 10, 10, '42'),
('2021-10-25 04:40:23', '2021-10-25 04:40:23', 32, 10, 20, '24'),
('2021-10-25 04:40:23', '2021-10-25 04:40:23', 33, 11, 10, '1'),
('2021-10-25 04:40:23', '2021-10-25 04:40:23', 34, 11, 20, '9'),
('2021-10-25 04:40:24', '2021-10-25 04:40:24', 35, 12, 10, '2'),
('2021-10-25 04:40:24', '2021-10-25 04:40:29', 36, 12, 20, '11'),
('2021-10-25 04:40:24', '2021-10-25 04:40:29', 37, 13, 0, '650'),
('2021-10-25 04:40:24', '2021-10-25 04:40:24', 38, 13, 20, '625'),
('2021-10-25 04:40:24', '2021-10-25 04:40:24', 39, 13, 0, '225'),
('2021-10-25 04:40:24', '2021-10-25 04:40:24', 40, 13, 0, '250'),
('2021-10-25 04:40:25', '2021-10-25 04:40:25', 41, 14, 0, '32'),
('2021-10-25 04:40:25', '2021-10-25 04:40:25', 42, 14, 20, '20'),
('2021-10-25 04:40:25', '2021-10-25 04:40:25', 43, 14, 0, '45'),
('2021-10-25 04:40:25', '2021-10-25 04:40:25', 44, 15, 0, '10000'),
('2021-10-25 04:40:25', '2021-10-25 04:40:25', 45, 15, 0, '10100'),
('2021-10-25 04:40:26', '2021-10-25 04:40:26', 46, 15, 0, '10110'),
('2021-10-25 04:40:26', '2021-10-25 04:40:26', 47, 15, 10, '10010');

INSERT INTO `test_question` (`created`, `updated`, `id`, `number`, `test_section_id`, `text`, `outdated`, `max_score`) VALUES
('2021-10-25 04:39:50', '2021-10-25 04:39:50', 1, 1, 1, 'What type of \"smarts\" do you have in spades?', 0, 40),
('2021-10-25 04:39:51', '2021-10-25 04:39:51', 2, 2, 1, 'Choose a color that represents your psyche', 0, 40),
('2021-10-25 04:39:51', '2021-10-25 04:39:51', 3, 3, 1, 'Which of these spirit animals guides you into battle?', 0, 40),
('2021-10-25 04:39:51', '2021-10-25 04:39:51', 4, 4, 1, 'Someone is getting on your nerves. How do you deal with it?', 0, 30),
('2021-10-25 04:40:05', '2021-10-25 04:40:05', 5, 1, 2, 'What\'s your favorite color?', 0, 40),
('2021-10-25 04:40:05', '2021-10-25 04:40:05', 6, 2, 2, 'What do you appreciate the most in another person?', 0, 30),
('2021-10-25 04:40:13', '2021-10-25 04:40:13', 7, 1, 3, '9 ÷ 3 + 4 (11 − 5) = ?', 0, 20),
('2021-10-25 04:40:13', '2021-10-25 04:40:13', 8, 2, 3, '6 ÷ 2 (2 + 1) = ?', 0, 20),
('2021-10-25 04:40:13', '2021-10-25 04:40:13', 9, 3, 3, '10 x 1 + 10 ÷ 10 = ?', 0, 20),
('2021-10-25 04:40:22', '2021-10-25 04:40:22', 10, NULL, 4, '9 ÷ 3 + 4 (11 − 5) = ?', 0, 20),
('2021-10-25 04:40:22', '2021-10-25 04:40:22', 11, NULL, 4, '6 ÷ 2 (2 + 1) = ?', 0, 20),
('2021-10-25 04:40:22', '2021-10-25 04:40:22', 12, NULL, 4, '10 x 1 + 10 ÷ 10 = ?', 0, 20),
('2021-10-25 04:40:22', '2021-10-25 04:40:22', 13, NULL, 5, '25 x 25 = ?', 0, 20),
('2021-10-25 04:40:22', '2021-10-25 04:40:22', 14, NULL, 5, '4 + (8 – 4) 4 = ?', 0, 20),
('2021-10-25 04:40:22', '2021-10-25 04:40:22', 15, NULL, 5, 'When you add the square root of 100 to 100 squared, what do you get?', 0, 10);

INSERT INTO `test_result` (`created`, `updated`, `id`, `application_id`, `test_id`, `end_time`) VALUES
('2021-10-25 04:40:09', '2021-10-25 04:40:09', 1, 16, 2, '2021-10-25 04:40:09'),
('2021-10-25 04:40:17', '2021-10-25 04:40:17', 2, 16, 3, '2021-10-25 04:40:17'),
('2021-10-25 04:40:29', '2021-10-25 04:40:29', 3, 16, 4, '2021-10-25 04:40:30');

INSERT INTO `test_result_answer` (`created`, `updated`, `id`, `test_result_id`, `test_answer_id`, `score`) VALUES
('2021-10-25 04:40:09', '2021-10-25 04:40:09', 1, 1, 18, 10),
('2021-10-25 04:40:09', '2021-10-25 04:40:09', 2, 1, 24, 30),
('2021-10-25 04:40:17', '2021-10-25 04:40:17', 3, 2, 27, 10),
('2021-10-25 04:40:17', '2021-10-25 04:40:17', 4, 2, 30, 20),
('2021-10-25 04:40:29', '2021-10-25 04:40:29', 5, 3, 36, 20),
('2021-10-25 04:40:30', '2021-10-25 04:40:30', 6, 3, 37, 0);

INSERT INTO `test_section` (`created`, `updated`, `id`, `test_id`, `title`, `description`, `max_score`, `outdated`) VALUES
('2021-10-25 04:39:50', '2021-10-25 04:39:50', 1, 1, 'default', NULL, NULL, 0),
('2021-10-25 04:40:05', '2021-10-25 04:40:05', 2, 2, 'default', NULL, 70, 0),
('2021-10-25 04:40:12', '2021-10-25 04:40:12', 3, 3, 'default', NULL, 60, 0),
('2021-10-25 04:40:21', '2021-10-25 04:40:21', 4, 4, 'Math skills easy', NULL, 60, 0),
('2021-10-25 04:40:21', '2021-10-25 04:40:21', 5, 4, 'Math skills long numbers', NULL, 50, 0);

INSERT INTO `test_total_score_result` (`id`, `test_result_id`, `test_section_id`, `total_score`) VALUES
(1, 1, 2, 40),
(2, 2, 3, 30),
(3, 3, 4, 20),
(4, 3, 5, 0);

INSERT INTO `test_vacancy` (`test_id`, `vacancy_id`) VALUES
(1, 2),
(2, 1),
(3, 1),
(4, 1);

INSERT INTO `token_logged_in` (`id`, `sub`, `role`, `created`) VALUES
(1, 1, 'USER', '2021-10-25 07:09:16'),
(2, 1, 'USER', '2021-10-25 07:17:00'),
(3, 1, 'USER', '2021-10-25 07:36:26');

INSERT INTO `user` (`created`, `updated`, `id`, `email`, `password`, `first_name`, `last_name`, `phone`, `img_url`, `is_new`, `blocked`, `rights_id`, `client_id`) VALUES
('2021-10-25 04:39:03', '2021-10-25 04:39:03', 1, 'test@test.test', '$pbkdf2-sha512$25000$cQ7B2DsHgFCK8f4fg1BqbQ$eVBnzBgD.Fd.3tj8dJNtgim.i7rABgqOxAqjbhKyju82iF51DOypMwECB7wFsuSV.AdwCSbNyK/muTi1P2PocQ', 'Jonathan', 'Dixon', '+171164932706', NULL, 1, 0, 1, 1),
('2021-10-25 04:40:35', '2021-10-25 04:40:35', 2, 'glester@hotmail.com', '$pbkdf2-sha512$25000$jFEqBcCY834PwXiP0ZpT6g$x5G/Qu7owBrnT3kUqftyOSV/kclsP8f3KZaiQ66yZsrn3Zs5VB1TNYrPCApXZC9MohYFAo11kPo5AzhCQOPVpg', 'Mary', 'Fox', '+171502101552', NULL, 1, 0, 1, 3),
('2021-10-25 04:40:38', '2021-10-25 04:40:38', 3, 'tracy40@gmail.com', '$pbkdf2-sha512$25000$FYJwLqV0LqX0HqP0fm8txQ$uQJImPEMuU0lkEXMx6akWPjXi0G8uyHARhRg734hI4fjVyFMoky.5ADGifsFZkjFoM8G3IEf5sJIl9YxTAq5Eg', 'Angela', 'Martin', '+171574116096', NULL, 1, 0, 1, 3),
('2021-10-25 04:40:42', '2021-10-25 04:40:42', 4, 'vlamb@yahoo.com', '$pbkdf2-sha512$25000$m9O6tzYmpJSyttYaI6T0/g$fT3WfbYlN4xUAnYODYDmCtHPe1pGh4GLVjJz6Zkutu6B437LDt4EOGX9wqRCe2Xn8musHXnrBMZglS5ePz0bkA', 'Amy', 'Padilla', '+171944164794', NULL, 1, 0, 1, 3),
('2021-10-25 04:40:45', '2021-10-25 04:40:45', 5, 'greencassandra@hotmail.com', '$pbkdf2-sha512$25000$fE.JUco5p1SKEUKI8R6j1A$6RBww8l1N0R.5cSwFCC7KuijoaSUF0HsvqJVO.SqN5s.xbOvNZeFtvABPwZ3KqT7XG0Upj3lwJoC4D3nB1dXBg', 'James', 'Stewart', '+171924674963', NULL, 1, 0, 1, 3),
('2021-10-25 04:40:49', '2021-10-25 04:40:49', 6, 'patrick03@gmail.com', '$pbkdf2-sha512$25000$cI6xVsqZU2rtXUtprRUCYA$GleKWGUUOkhYpCfyTTFyRc6f7SuJ2lNPuies8omdsuNGbwCynoH7pLW2AEpbM2jllY.zHop/cjhmHW5nHiJxoQ', 'Leslie', 'Burgess', '+171138841218', NULL, 1, 0, 1, 3),
('2021-10-25 04:40:53', '2021-10-25 04:40:53', 7, 'carl05@hotmail.com', '$pbkdf2-sha512$25000$n9OaE8JY6937v5eSsnYuZQ$duLRZ0TGLv0spKXEpmjzTvsrMPCDQpLXLjfTlM9W./YQIibHbTVnxX91hBisySZc/RFW.tfP3adQfEp9QTi62w', 'Roberto', 'Stafford', '+171557325359', NULL, 1, 0, 1, 4),
('2021-10-25 04:40:56', '2021-10-25 04:40:56', 8, 'shanethomas@yahoo.com', '$pbkdf2-sha512$25000$CEFISUlpbc2Z8/5fi5EyZg$bVy39vvPqVF.y2xOJ9UePlTcqtxCr2ZbfQ7b5ap1YTp/8PnX1SQoh0TUtG2LFy8WYN9d25DKaCC1R2ZlcRkIBA', 'Gregory', 'Murphy', '+171226302971', NULL, 1, 0, 1, 4),
('2021-10-25 04:41:00', '2021-10-25 04:41:00', 9, 'areyes@yahoo.com', '$pbkdf2-sha512$25000$zfn/v3duLQUgROj9f8.Zsw$3BqS89z4viwZSHz7v.KhuSexylZ2UZ9aPDe1584o0EjK9HLBICbOPxcNEWnIEK724PzPzpvwAFhK3qxHK7AzMw', 'Amanda', 'Ballard', '+171026649366', NULL, 1, 0, 1, 4),
('2021-10-25 04:41:03', '2021-10-25 04:41:03', 10, 'kmalone@gmail.com', '$pbkdf2-sha512$25000$0HovBaAUAuBc6/3/f.89Zw$rbuwkqOiBJF/u5DJZM2zAS2pwnPpuQckDN7wUypGeGgDXPnQ0R7c6WjZFxwg404nmloVE7VWJf17bcMSlbzFzg', 'Robert', 'Myers', '+171973426768', NULL, 1, 0, 1, 4),
('2021-10-25 04:41:07', '2021-10-25 04:41:07', 11, 'masonchristy@hotmail.com', '$pbkdf2-sha512$25000$X8v5f4/xfq/V.l9rDcG4lw$lw8lIuzFOHNteDQyv5vtB86vy6pn67ACshe/ERfGFIquRhmYlblu7fXdMTUduxQp6avUALHT6.bF4xF7X3SGPQ', 'Willie', 'Oconnor', '+171294097851', NULL, 1, 0, 1, 4),
('2021-10-25 04:41:11', '2021-10-25 04:41:11', 12, 'cjohnson@yahoo.com', '$pbkdf2-sha512$25000$d06pVYqxFgKA0NpbS0mJ8Q$.6X20ZPvMHDxsUOd5d7r0QwwwWI5ccXM5leW4WH1R5drfYQ.PJN4Dl8ohK0Sb/pbw5MfSMX/FdinwIW3Hj4Idw', 'Christopher', 'Carter', '+171995224339', NULL, 1, 0, 1, 5),
('2021-10-25 04:41:14', '2021-10-25 04:41:14', 13, 'stephenromero@gmail.com', '$pbkdf2-sha512$25000$jfE.xxjDeK.1dk7pHaPUWg$Sj97UITSRyYpvxm9E2LXWyTTQ8VMAhtkFBDnMtD9WTBzefvXcaR.uikVTPZVfxuAULkWclwA7sK/gBpw0VQojQ', 'Jill', 'Sullivan', '+171632355805', NULL, 1, 0, 1, 5),
('2021-10-25 04:41:18', '2021-10-25 04:41:18', 14, 'linda60@yahoo.com', '$pbkdf2-sha512$25000$glBKybl3LkXovfeeM6YUAg$ntwLhHS0k6LUhCN/feb/uMEovT6SpnBFA/DJeJ3sAl3H7O4ymkQzOCFJucPmMjPKVEGI2eQ7N2/iP2wvqMwn8A', 'Alyssa', 'Roberts', '+171966617723', NULL, 1, 0, 1, 5),
('2021-10-25 04:41:21', '2021-10-25 04:41:21', 15, 'xmadden@hotmail.com', '$pbkdf2-sha512$25000$USrl3Nub8x5jrFWq1Trn/A$ER7TyZac0Odnp9I11QKyJLFY.1.U/dxd02.eBNVgUVHB31fYvzzIG3CPCexqUj3gvRauoXQil4SZ2lu4AfY7uQ', 'Ashley', 'Baker', '+171791154719', NULL, 1, 0, 1, 5),
('2021-10-25 04:41:25', '2021-10-25 04:41:25', 16, 'bryantjennifer@yahoo.com', '$pbkdf2-sha512$25000$OwcgpDRmTIkxBuA8Z6z1vg$mAe/O5aJZ5o0ovDIrRQ5k1Snr2TfTv50TsFKiiUUTNhdUNbCUod3DSppomyH/cRib34JucpapVeb65xO/lzYPA', 'Michael', 'Williams', '+171002756459', NULL, 1, 0, 1, 5);

INSERT INTO `vacancy` (`created`, `updated`, `id`, `vacancy_description_last_id`, `vacancy_group_id`, `is_new`, `blocked`, `deleted`) VALUES
('2021-10-25 04:39:06', '2021-10-25 04:40:20', 1, 1, 2, 1, 0, 0),
('2021-10-25 04:39:20', '2021-10-25 04:39:49', 2, 2, 3, 1, 0, 0),
('2021-10-25 04:39:34', '2021-10-25 04:39:34', 3, 3, 3, 1, 0, 0);

INSERT INTO `vacancy_application` (`created`, `updated`, `id`, `candidate_id`, `vacancy_id`, `candidate_status_id`) VALUES
('2021-10-25 04:39:06', '2021-10-25 04:39:06', 1, 1, 1, 1),
('2021-10-25 04:39:08', '2021-10-25 04:39:08', 2, 2, 1, 1),
('2021-10-25 04:39:11', '2021-10-25 04:39:11', 3, 3, 1, 1),
('2021-10-25 04:39:14', '2021-10-25 04:39:14', 4, 4, 1, 1),
('2021-10-25 04:39:16', '2021-10-25 04:39:16', 5, 5, 1, 1),
('2021-10-25 04:39:21', '2021-10-25 04:39:21', 6, 6, 2, 1),
('2021-10-25 04:39:23', '2021-10-25 04:39:23', 7, 7, 2, 1),
('2021-10-25 04:39:26', '2021-10-25 04:39:26', 8, 8, 2, 1),
('2021-10-25 04:39:28', '2021-10-25 04:39:28', 9, 9, 2, 1),
('2021-10-25 04:39:31', '2021-10-25 04:39:31', 10, 10, 2, 1),
('2021-10-25 04:39:34', '2021-10-25 04:39:34', 11, 11, 3, 1),
('2021-10-25 04:39:37', '2021-10-25 04:39:37', 12, 12, 3, 1),
('2021-10-25 04:39:39', '2021-10-25 04:39:39', 13, 13, 3, 1),
('2021-10-25 04:39:42', '2021-10-25 04:39:42', 14, 14, 3, 1),
('2021-10-25 04:39:45', '2021-10-25 04:39:45', 15, 15, 3, 1),
('2021-10-25 04:39:57', '2021-10-25 04:40:00', 16, 16, 1, 1),
('2021-10-25 08:26:57', '2021-10-25 08:26:57', 17, 17, 1, 1),
('2021-10-25 09:18:41', '2021-10-25 09:18:41', 18, 18, 1, 1),
('2021-10-25 09:24:08', '2021-10-25 09:24:08', 19, 19, 1, 1),
('2021-10-25 09:31:35', '2021-10-25 09:31:35', 20, 20, 1, 1);

INSERT INTO `vacancy_chat_message` (`created`, `updated`, `id`, `text`, `application_event_id`, `candidate_user_id`, `user_id`) VALUES
('2021-10-25 04:39:57', '2021-10-25 04:39:57', 1, 'Hi! Can you answer the most important question?', 1, NULL, 1),
('2021-10-25 04:40:00', '2021-10-25 04:40:00', 2, '42', 3, 1, NULL),
('2021-10-25 04:40:01', '2021-10-25 04:40:01', 3, 'You are hired! 🤓', 4, NULL, 1);

INSERT INTO `vacancy_description_history` (`created`, `updated`, `id`, `title`, `salary_from`, `salary_to`, `closing_date`, `description`, `skills`, `img_url`, `vacancy_id`, `client_description_id`) VALUES
('2021-10-25 04:39:06', '2021-10-25 04:39:06', 1, 'Senior Backend Software Engineer', 100000, 180000, '2021-10-30', 'Investors across the globe are looking for new investment opportunities. You will have a chance to work on client-facing functionality as well as internal operational tools ensuring the best in class investor experience. As a Senior Backend Software Engineer working on FarmTogether investment platform, you will:\n- Design, implement, test, and maintain features in the core systems\n- Work on the investment platform that connects investors with institutional-quality farmland investment opportunities managed by FarmTogether\n- Build core infrastructure, third-party integrations and recommend architecture enhancements\n- Enhance monitoring and alerting services to ensure reliability and performance of the products\n- Be part of weekly on-call rotations to quickly resolve any infrastructure issues whenever our application becomes unavailable\n- Make a difference in the lives of people everywhere who use FarmTogether to invest in alternative assets!\n', '\n- 7+ years of professional experience building backend systems with high availability.\n- 5+ years experience programming in Java, Kotlin, or similar high-level programming languages\n- Bachelor’s Degree in Computer Science or related field\n- Excellent knowledge and experience with Java Frameworks (Spring, Spring Boot, Hibernate, JPA, etc.)\n- Excellent knowledge and experience with SQL RDBMS & Data Stores. PostgreSQL, Redis preferred. Experience in any other related DB or stores will be considered.\n- Strong experience designing, building & integrating with 3rd party APIs (HTTP, REST, JSON)\n- Good understanding of TDD, Unit and automated tests paradigms\n- Experience with containerized applications (Docker, Kubernetes, etc.)\n- Possess a DevOps mindset, Infrastructure as Code (IaC). Experience working in AWS for infrastructure needs and terraform for IaC preferred.\n- Teamwork and have a strong sense of ownership\n- Open to feedback and ideas from others; able to disagree and commit\n', NULL, 1, 2),
('2021-10-25 04:39:20', '2021-10-25 04:39:20', 2, 'Senior Frontend Engineer', 100000, 180000, '2021-10-30', '\nWhen joining the engineering team at Vie Labs you will be part of one of our small cross-functional product delivery teams. Our teams focus on delivering solutions that are well thought out, documented and tested. We work in a self-managing structure and are motivated by delivering rapid and visible business benefit.\n\nEsports Entertainment Group has many interesting projects to work on, but this particular role would allow you to join and work on our core product that underpins our gambling operations.\n\n\nThe project is in early stages and you are not going to be yet another small cog in a large machine. Instead you will have a voice that will be heard, and you will have the opportunity to influence the project direction on a macro level.\n', '\n- Expert with HTML, CSS, TypeScript, ES6\n- Experience with React and Redux\n- Ability to write test-driven and cross-browser compatible code\n- Strong communication skills in both written and verbal English\n- Experience with Angular\n- Experience with websockets\n- Experience with Next.js\n- Experience with Ant Design UI library\n- Experience React Native and/or Ionic\n        ', NULL, 2, 3),
('2021-10-25 04:39:34', '2021-10-25 04:39:34', 3, 'Senior Software Engineer', 100000, 200000, '2021-10-27', '\nA global High-tech company is looking for a top-notch Java developer who will shape the technology of the world’s top content recommendation network.\n\nOur scale:\n\n1. We require thousands of servers across multiple data centers to serve our traffic.\n2. > 10k Kubernetes pods.\n3. Many dozens of services and data stores are accessed for each served request. We have a Netflix style microservices architecture where all pieces must fit together to deliver on performance and correctness.\n', '\n- Experience in Java (4+ years)\n- Scala/Kotlin experience – advantage\n- Experience in developing large-scale data-intensive systems, preferably Web systems\n- Ability to work in an agile development environment\n- Familiarity with one or more of the following is an advantage: Spring, Hadoop, Hive, Cassandra, Kafka, Spark, ElasticSearch\n', NULL, 3, 3);

INSERT INTO `vacancy_group` (`created`, `updated`, `id`, `title`, `client_id`, `client_description_id`, `deleted`) VALUES
('2021-10-25 04:39:03', '2021-10-25 04:39:03', 1, 'default', 1, 1, 0),
('2021-10-25 04:39:05', '2021-10-25 04:39:05', 2, 'Premium vacancies', 1, 2, 0),
('2021-10-25 04:39:20', '2021-10-25 04:39:33', 3, 'Interesting vacancies', 1, 3, 0);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
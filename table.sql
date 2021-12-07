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

-- ADD RACE TRACK TABLE (MAKE SURE TO DELETE race_tracks FIRST IF YOU ALREADY HAVE IT!!!!)
-- DROP TABLE IF EXISTS race_tracks;
CREATE TABLE `race_tracks` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`checkpoints` TEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`records` TEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`creatorid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`creatorname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`distance` INT(11) NULL DEFAULT NULL,
	`raceid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`access` TEXT NULL DEFAULT '{}' COLLATE 'utf8_general_ci',
	`curated` TINYINT(4) NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `raceid` (`raceid`) USING BTREE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;


-- DROP TABLE IF EXISTS racer_names;
CREATE TABLE `racer_names` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`citizenid` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`racername` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`lasttouched` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	`races` INT(11) NOT NULL DEFAULT '0',
	`wins` INT(11) NOT NULL DEFAULT '0',
	`tracks` INT(11) NOT NULL DEFAULT '0',
	`auth` TEXT DEFAULT 'racer',
	`createdby` TEXT,
	`revoked` TINYINT DEFAULT 0,
	INDEX `id` (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;

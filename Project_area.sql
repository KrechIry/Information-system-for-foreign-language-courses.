create database babylon;
use babylon;

CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` int NOT NULL,
	`person_id` int NOT NULL,
	`qualification` int NOT NULL,
	`hire_date` int NOT NULL,
	`status` varchar(255) NOT NULL,
	`role` int NOT NULL,
	PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `role` (
	`role_id` int NOT NULL,
	`role_name` int NOT NULL,
	`description` text,
	PRIMARY KEY (`role_id`)
);

CREATE TABLE IF NOT EXISTS `qualification` (
	`qualification_id` int NOT NULL,
	`qualification_name` int NOT NULL,
	`graduation_year` int NOT NULL,
	`status` varchar(255) NOT NULL,
	PRIMARY KEY (`qualification_id`)
);

CREATE TABLE IF NOT EXISTS `student` (
	`student_id` int NOT NULL,
	`person_id` int NOT NULL,
	`enrollment_date` int NOT NULL,
	`status` varchar(255) NOT NULL,
	PRIMARY KEY (`student_id`)
);

CREATE TABLE IF NOT EXISTS `enrollment` (
	`enrollment_id` int NOT NULL,
	`student_id` int NOT NULL,
	`enrollment_date` int NOT NULL,
	`status` varchar(255) NOT NULL,
	`graduation_date` date NOT NULL,
	`is_active` boolean,
	`is_certified` boolean,
	PRIMARY KEY (`enrollment_id`)
);

CREATE TABLE IF NOT EXISTS `attendance` (
	`attendance_id` int NOT NULL,
	`student_id` int NOT NULL,
	`attendance_date` int NOT NULL,
	`attendance_status` varchar(255) NOT NULL,
	`comment` text,
	`grade` varchar(255),
	PRIMARY KEY (`attendance_id`)
);

CREATE TABLE IF NOT EXISTS `feedback` (
	`feedback_id` int NOT NULL,
	`student_id` int NOT NULL,
	`course_id` int NOT NULL,
	`feedback_text` int NOT NULL,
	`rating` decimal(10,0) NOT NULL,
	PRIMARY KEY (`feedback_id`)
);

CREATE TABLE IF NOT EXISTS `payment` (
	`payment_id` int NOT NULL,
	`student_id` int NOT NULL,
	`amount` int NOT NULL,
	`payment_date` date NOT NULL,
	`payment_method` varchar(255) NOT NULL,
	`status` varchar(255) NOT NULL,
	`payment_reference` varchar(255),
	`currency` varchar(255) NOT NULL,
	PRIMARY KEY (`payment_id`)
);

CREATE TABLE IF NOT EXISTS `person` (
	`person_id` int NOT NULL,
	`first_name` varchar(255) NOT NULL,
	`last_name` varchar(255) NOT NULL,
	`birth_date` int NOT NULL,
	`email` varchar(255) NOT NULL UNIQUE,
	`phone` varchar(255) NOT NULL UNIQUE,
	`address` varchar(255) NOT NULL,
	`profile_picture` varchar(255),
	`bio` varchar(255) NOT NULL,
	`social` varchar(255),
	PRIMARY KEY (`person_id`)
);
CREATE TABLE IF NOT EXISTS `course` (
	`course_id` int NOT NULL,
	`course_name` int NOT NULL,
	`level` varchar(255) NOT NULL,
	`course_description` int NOT NULL,
	`cost` int NOT NULL,
	`duration` int NOT NULL,
	`status` varchar(255) NOT NULL,
	`person_id` int NOT NULL,
	PRIMARY KEY (`course_id`)
);

CREATE TABLE IF NOT EXISTS `language` (
	`language_id` int NOT NULL,
	`language_name` varchar(255) NOT NULL,
	`language_code` varchar(255) NOT NULL,
	PRIMARY KEY (`language_id`)
);

CREATE TABLE IF NOT EXISTS `level` (
	`level_id` int NOT NULL,
	`language_id` int NOT NULL,
	`new_field` int NOT NULL,
	`description` text,
	PRIMARY KEY (`level_id`)
);

CREATE TABLE IF NOT EXISTS `group` (
	`group_id` int NOT NULL,
	`course_id` int NOT NULL,
	`group_name` int NOT NULL,
	`max_students` int NOT NULL,
	`status` int NOT NULL,
	`start_date` int NOT NULL,
	`end_date` date NOT NULL,
	PRIMARY KEY (`group_id`)
);

CREATE TABLE IF NOT EXISTS `schedule` (
	`schedule_id` int NOT NULL,
	`group_id` int NOT NULL,
	`schedule_date` int NOT NULL,
	`start_time` int NOT NULL,
	`end_time` int NOT NULL,
	`location` int NOT NULL,
	`status` varchar(255) NOT NULL,
	PRIMARY KEY (`schedule_id`)
);

CREATE TABLE IF NOT EXISTS `task` (
	`task_id` int NOT NULL,
	`description` int NOT NULL,
	`due_date` int NOT NULL,
	`assigned_by` int NOT NULL,
	`status` varchar(255) NOT NULL,
	`schedule` int NOT NULL,
	PRIMARY KEY (`task_id`)
);

CREATE TABLE IF NOT EXISTS `material` (
	`material_id` int NOT NULL,
	`course_id` int NOT NULL,
	`material_type` int NOT NULL,
	`title` int NOT NULL,
	`description` int NOT NULL,
	`url` varchar(255) NOT NULL,
	`upload_date` int NOT NULL,
	`status` varchar(255) NOT NULL,
	PRIMARY KEY (`material_id`)
);

CREATE TABLE IF NOT EXISTS `certificate` (
	`certificate_id` int NOT NULL,
	`student_id` int NOT NULL,
	`course_id` int NOT NULL,
	`issue_date` int NOT NULL,
	`certificate_code` varchar(255) NOT NULL,
	`status` varchar(255) NOT NULL
);


ALTER TABLE `course` ADD CONSTRAINT `course_fk2` FOREIGN KEY (`level`) REFERENCES `level`(`level_id`);

ALTER TABLE `course` ADD CONSTRAINT `course_fk7` FOREIGN KEY (`person`) REFERENCES `person`(`person_id`);

ALTER TABLE `level` ADD CONSTRAINT `level_fk1` FOREIGN KEY (`language_id`) REFERENCES `language`(`language_id`);
ALTER TABLE `group` ADD CONSTRAINT `group_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`);
ALTER TABLE `schedule` ADD CONSTRAINT `schedule_fk1` FOREIGN KEY (`group_id`) REFERENCES `group`(`group_id`);
-- ALTER TABLE `task` ADD CONSTRAINT `task_fk3` FOREIGN KEY (`assigned_by`) REFERENCES `employee`(`employee_id,`);
ALTER TABLE `task` ADD CONSTRAINT `task_fk5` FOREIGN KEY (`schedule`) REFERENCES `schedule`(`schedule_id`);
ALTER TABLE `material` ADD CONSTRAINT `material_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`);
ALTER TABLE `certificate` ADD CONSTRAINT `certificate_fk1` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id,`);

ALTER TABLE `certificate` ADD CONSTRAINT `certificate_fk2` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`);
--

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk1` FOREIGN KEY (`person_id`) REFERENCES `person`(`person_id`);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk2` FOREIGN KEY (`qualification`) REFERENCES `qualification`(`qualification_id`);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk5` FOREIGN KEY (`role`) REFERENCES `role`(`role_id`);


ALTER TABLE `student` ADD CONSTRAINT `student_fk1` FOREIGN KEY (`person_id`) REFERENCES `person`(`person_id`);
ALTER TABLE `enrollment` ADD CONSTRAINT `enrollment_fk1` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`);
ALTER TABLE `attendance` ADD CONSTRAINT `attendance_fk1` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`);
ALTER TABLE `feedback` ADD CONSTRAINT `feedback_fk1` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`);

ALTER TABLE `feedback` ADD CONSTRAINT `feedback_fk2` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id,`);
ALTER TABLE `payment` ADD CONSTRAINT `payment_fk1` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`);
ALTER TABLE `course` ADD CONSTRAINT `course_fk15` FOREIGN KEY (`person_id`) REFERENCES `person`(`person_id`);

rename table `Course` to `course`;
rename table `Language` to `language`;
rename table `Level` to `level`;
rename table `Group` to `group`;
rename table `Schedule` to `schedule`;
rename table `Task` to `task`;
rename table `Material` to `material`;
rename table `Certificate` to `certificate`;


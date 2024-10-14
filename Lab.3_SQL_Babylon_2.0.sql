CREATE TABLE IF NOT EXISTS `Course` (
	`course_id` int NOT NULL,
	`language_id` int NOT NULL,
	`course_name` varchar(255) NOT NULL,
	`level` varchar(255) NOT NULL,
	`course_description` text NOT NULL,
	`cost` decimal(10,0) NOT NULL,
	`duration` int NOT NULL,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	`status` varchar(255),
	`max_students` int NOT NULL,
	`min_students` int NOT NULL,
	PRIMARY KEY (`course_id`)
);

CREATE TABLE IF NOT EXISTS `Languages` (
	`language_id` int NOT NULL,
	`language_name` varchar(255) NOT NULL UNIQUE,
	`language_code` varchar(255) NOT NULL,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	PRIMARY KEY (`language_id`)
);

CREATE TABLE IF NOT EXISTS `Instructor` (
	`instructor_id` int NOT NULL,
	`specialization` varchar(255) NOT NULL,
	`lenguage_id` int NOT NULL,
	`experience` int NOT NULL,
	`rating` decimal(10,0) NOT NULL,
	`instructor_first_name` varchar(255) NOT NULL,
	`instructor_last_name` varchar(255) NOT NULL,
	`instructor_email` varchar(255) NOT NULL UNIQUE,
	`instructor_city` varchar(255) NOT NULL,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	`status` varchar(255),
	`profile_picture` varchar(255),
	`bio` text,
	`website` varchar(255),
	PRIMARY KEY (`instructor_id`)
);

CREATE TABLE IF NOT EXISTS `Student` (
	`student_id` int NOT NULL,
	`language_id` int NOT NULL,
	`student_first_name` varchar(255) NOT NULL,
	`student_last_name` varchar(255) NOT NULL,
	`student_phone` varchar(255),
	`student_birth_date` date NOT NULL,
	`student_email` varchar(255) NOT NULL UNIQUE,
	`student_level` varchar(255) NOT NULL,
	`status` varchar(255),
	`gender` varchar(255),
	`enrollment_date` date,
	`graduation_date` date,
	`profile_picture` varchar(255),
	`student_city` varchar(255) NOT NULL,
	PRIMARY KEY (`student_id`)
);

CREATE TABLE IF NOT EXISTS `Group` (
	`class_id` int NOT NULL,
	`course_id` int NOT NULL,
	`instructor_id` int NOT NULL,
	`class_name` varchar(255) NOT NULL,
	`group_composition` text,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	`status` varchar(255),
	`max_students` int NOT NULL,
	`min_students` int NOT NULL,
	PRIMARY KEY (`class_id`)
);

CREATE TABLE IF NOT EXISTS `Schedule` (
	`schedule_id` int NOT NULL,
	`class_id` int NOT NULL,
	`instructor_id` int NOT NULL,
	`schedule_date` date NOT NULL,
	`start_time` time NOT NULL,
	`end_time` time NOT NULL,
	`location` varchar(255) NOT NULL,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	`status` varchar(255),
	PRIMARY KEY (`schedule_id`)
);

CREATE TABLE IF NOT EXISTS `Payment` (
	`transaction_id` int NOT NULL,
	`student_id` int NOT NULL,
	`course_id` int NOT NULL,
	`amount` decimal(10,0) NOT NULL,
	`transaction_date` date NOT NULL,
	`payment_method` varchar(255) NOT NULL,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	`status` varchar(255),
	`payment_reference` varchar(255),
	`currency` varchar(255) NOT NULL,
	PRIMARY KEY (`transaction_id`)
);

CREATE TABLE IF NOT EXISTS `Attendance` (
	`attendance_id` int NOT NULL,
	`student_id` int NOT NULL,
	`class_id` int NOT NULL,
	`attendance_date` date NOT NULL,
	`attendance_status` varchar(255) NOT NULL,
	`comment` text,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	`status` varchar(255),
	PRIMARY KEY (`attendance_id`)
);

CREATE TABLE IF NOT EXISTS `Feedback` (
	`feedback_id` int NOT NULL,
	`student_id` int NOT NULL,
	`course_id` int NOT NULL,
	`feedback_text` text NOT NULL,
	`rating` decimal(10,0) NOT NULL,
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	PRIMARY KEY (`feedback_id`)
);

CREATE TABLE IF NOT EXISTS `Task_Assignment` (
	`task_id` int NOT NULL,
	`course_id` int NOT NULL,
	`student_id` int NOT NULL,
	`instructor_id` int NOT NULL,
	`task_description` text NOT NULL,
	`due_date` date NOT NULL,
	`submission_date` date,
	`grade` varchar(255),
	`created_at` timestamp NOT NULL,
	`updated_at` timestamp NOT NULL,
	PRIMARY KEY (`task_id`)
);

ALTER TABLE `Course` ADD CONSTRAINT `Course_fk1` FOREIGN KEY (`language_id`) REFERENCES `Languages`(`language_id`);

ALTER TABLE `Instructor` ADD CONSTRAINT `Instructor_fk2` FOREIGN KEY (`lenguage_id`) REFERENCES `Languages`(`language_id`);
ALTER TABLE `Student` ADD CONSTRAINT `Student_fk1` FOREIGN KEY (`language_id`) REFERENCES `Languages`(`language_id`);
ALTER TABLE `Group` ADD CONSTRAINT `Group_fk1` FOREIGN KEY (`course_id`) REFERENCES `Course`(`course_id`);

ALTER TABLE `Group` ADD CONSTRAINT `Group_fk2` FOREIGN KEY (`instructor_id`) REFERENCES `Instructor`(`instructor_id`);
ALTER TABLE `Schedule` ADD CONSTRAINT `Schedule_fk1` FOREIGN KEY (`class_id`) REFERENCES `Group`(`class_id`);

ALTER TABLE `Schedule` ADD CONSTRAINT `Schedule_fk2` FOREIGN KEY (`instructor_id`) REFERENCES `Instructor`(`instructor_id`);
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_fk1` FOREIGN KEY (`student_id`) REFERENCES `Student`(`student_id`);

ALTER TABLE `Payment` ADD CONSTRAINT `Payment_fk2` FOREIGN KEY (`course_id`) REFERENCES `Course`(`course_id`);
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_fk1` FOREIGN KEY (`student_id`) REFERENCES `Student`(`student_id`);

ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_fk2` FOREIGN KEY (`class_id`) REFERENCES `Group`(`class_id`);
ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_fk1` FOREIGN KEY (`student_id`) REFERENCES `Student`(`student_id`);

ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_fk2` FOREIGN KEY (`course_id`) REFERENCES `Course`(`course_id`);
ALTER TABLE `Task_Assignment` ADD CONSTRAINT `Task_Assignment_fk1` FOREIGN KEY (`course_id`) REFERENCES `Course`(`course_id`);

ALTER TABLE `Task_Assignment` ADD CONSTRAINT `Task_Assignment_fk2` FOREIGN KEY (`student_id`) REFERENCES `Student`(`student_id`);

ALTER TABLE `Task_Assignment` ADD CONSTRAINT `Task_Assignment_fk3` FOREIGN KEY (`instructor_id`) REFERENCES `Instructor`(`instructor_id`);
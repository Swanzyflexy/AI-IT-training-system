-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2024 at 02:31 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `it_training_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admindetails`
--

CREATE TABLE `admindetails` (
  `id` bigint(20) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admindetails`
--

INSERT INTO `admindetails` (`id`, `username`, `password`) VALUES
(1, 'Admin', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `id` bigint(20) NOT NULL,
  `teacher_file` varchar(100) NOT NULL,
  `course_id_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`id`, `teacher_file`, `course_id_id`) VALUES
(1, 'assignment_files/ARUNAMAHALE2YREXPSOFTWARETESTER.pdf', 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add admin details', 7, 'add_admindetails'),
(26, 'Can change admin details', 7, 'change_admindetails'),
(27, 'Can delete admin details', 7, 'delete_admindetails'),
(28, 'Can view admin details', 7, 'view_admindetails'),
(29, 'Can add course', 8, 'add_course'),
(30, 'Can change course', 8, 'change_course'),
(31, 'Can delete course', 8, 'delete_course'),
(32, 'Can view course', 8, 'view_course'),
(33, 'Can add student', 9, 'add_student'),
(34, 'Can change student', 9, 'change_student'),
(35, 'Can delete student', 9, 'delete_student'),
(36, 'Can view student', 9, 'view_student'),
(37, 'Can add student_ assignments', 10, 'add_student_assignments'),
(38, 'Can change student_ assignments', 10, 'change_student_assignments'),
(39, 'Can delete student_ assignments', 10, 'delete_student_assignments'),
(40, 'Can view student_ assignments', 10, 'view_student_assignments'),
(41, 'Can add teacher', 11, 'add_teacher'),
(42, 'Can change teacher', 11, 'change_teacher'),
(43, 'Can delete teacher', 11, 'delete_teacher'),
(44, 'Can view teacher', 11, 'view_teacher'),
(45, 'Can add lectures', 12, 'add_lectures'),
(46, 'Can change lectures', 12, 'change_lectures'),
(47, 'Can delete lectures', 12, 'delete_lectures'),
(48, 'Can view lectures', 12, 'view_lectures'),
(49, 'Can add enrollment', 13, 'add_enrollment'),
(50, 'Can change enrollment', 13, 'change_enrollment'),
(51, 'Can delete enrollment', 13, 'delete_enrollment'),
(52, 'Can view enrollment', 13, 'view_enrollment'),
(53, 'Can add assignments', 14, 'add_assignments'),
(54, 'Can change assignments', 14, 'change_assignments'),
(55, 'Can delete assignments', 14, 'delete_assignments'),
(56, 'Can view assignments', 14, 'view_assignments'),
(57, 'Can add title', 15, 'add_title'),
(58, 'Can change title', 15, 'change_title'),
(59, 'Can delete title', 15, 'delete_title'),
(60, 'Can view title', 15, 'view_title'),
(61, 'Can add questions', 16, 'add_questions'),
(62, 'Can change questions', 16, 'change_questions'),
(63, 'Can delete questions', 16, 'delete_questions'),
(64, 'Can view questions', 16, 'view_questions'),
(65, 'Can add group', 17, 'add_group'),
(66, 'Can change group', 17, 'change_group'),
(67, 'Can delete group', 17, 'delete_group'),
(68, 'Can view group', 17, 'view_group'),
(69, 'Can add group_ member', 18, 'add_group_member'),
(70, 'Can change group_ member', 18, 'change_group_member'),
(71, 'Can delete group_ member', 18, 'delete_group_member'),
(72, 'Can view group_ member', 18, 'view_group_member'),
(73, 'Can add submitted_ quiz', 19, 'add_submitted_quiz'),
(74, 'Can change submitted_ quiz', 19, 'change_submitted_quiz'),
(75, 'Can delete submitted_ quiz', 19, 'delete_submitted_quiz'),
(76, 'Can view submitted_ quiz', 19, 'view_submitted_quiz'),
(77, 'Can add chat', 20, 'add_chat'),
(78, 'Can change chat', 20, 'change_chat'),
(79, 'Can delete chat', 20, 'delete_chat'),
(80, 'Can view chat', 20, 'view_chat'),
(81, 'Can add feedback', 21, 'add_feedback'),
(82, 'Can change feedback', 21, 'change_feedback'),
(83, 'Can delete feedback', 21, 'delete_feedback'),
(84, 'Can view feedback', 21, 'view_feedback'),
(85, 'Can add category', 22, 'add_category'),
(86, 'Can change category', 22, 'change_category'),
(87, 'Can delete category', 22, 'delete_category'),
(88, 'Can view category', 22, 'view_category'),
(89, 'Can add sub category', 23, 'add_subcategory'),
(90, 'Can change sub category', 23, 'change_subcategory'),
(91, 'Can delete sub category', 23, 'delete_subcategory'),
(92, 'Can view sub category', 23, 'view_subcategory'),
(93, 'Can add feedback_ data', 21, 'add_feedback_data'),
(94, 'Can change feedback_ data', 21, 'change_feedback_data'),
(95, 'Can delete feedback_ data', 21, 'delete_feedback_data'),
(96, 'Can view feedback_ data', 21, 'view_feedback_data'),
(97, 'Can add interest', 24, 'add_interest'),
(98, 'Can change interest', 24, 'change_interest'),
(99, 'Can delete interest', 24, 'delete_interest'),
(100, 'Can view interest', 24, 'view_interest');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` bigint(20) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `category_description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `category_name`, `category_description`) VALUES
(1, 'Programming', 'Programming, or coding, is the process of writing instructions for computers to follow in order to perform tasks. It involves designing and implementing algorithms, which are step-by-step specifications of procedures, using one or more programming languages. \r\n'),
(3, 'Cybersecurity', 'Cybersecurity'),
(4, 'Artificial Intelligence', ' Artificial intelligence is the simulation of human intelligence processes by machines, especially computer systems. Specific applications of AI include expert systems, natural language processing, speech recognition and machine vision.'),
(5, 'Software Development', 'Software Development refers to the creating, building, and maintaining of websites. It includes aspects such as web design, web publishing, web programming, and database management. It is the creation of an application that works over the internet i.e. websites.'),
(6, 'Database Management', 'A database management system (or DBMS) is essentially nothing more than a computerized data-keeping system. Users of the system are given facilities to perform several kinds of operations on such a system for either manipulation of the data in the database or the management of the database structure itself.');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` bigint(20) NOT NULL,
  `user` varchar(200) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `level` varchar(20) NOT NULL,
  `enrollment_count` int(11) NOT NULL,
  `teacher_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) NOT NULL,
  `subcategory_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `title`, `description`, `level`, `enrollment_count`, `teacher_id`, `category_id`, `subcategory_id`) VALUES
(1, 'Introduction to Python Programming', 'Python is a versatile and powerful high-level programming language that is widely used for web development, data analysis, artificial intelligence, scientific computing, and automation. Known for its readability and simplicity, Python has become the language of choice for both beginners and experienced developers.\r\n\r\nThis course, \"Introduction to Python Programming,\" is designed to provide you with a comprehensive foundation in Python. Whether you are new to programming or looking to add Python to your skill set, this course will guide you through the essential concepts and techniques.', 'Beginner', 1, 1, 1, 4),
(2, 'Data Structures and Algorithms', 'This Data Structures and Algorithms in Python course provides a comprehensive explanation of data structures like linked lists, stacks and queues, binary search trees, heap, searching and hashing. Various sorting algorithms with implementation and analysis are included in this tutorial.', 'Intermediate', 0, 1, 1, 4),
(3, 'JavaScript Essentials for Beginners', 'Learn the basics of JavaScript programming. This course is designed for absolute beginners and covers the foundational concepts of JavaScript. You\'ll start by understanding how to declare and use variables, the different data types available in JavaScript, and how to create and call basic functions. By the end of this course, you\'ll have a solid understanding of the core elements that make up JavaScript and be ready to tackle more complex topics.', 'Beginner', 0, 2, 1, 6),
(4, 'Introduction to JavaScript: The Basics', 'Grasp the fundamentals of JavaScript through a series of engaging lessons and hands-on coding exercises. This course will help you familiarize yourself with the syntax and structure of JavaScript, enabling you to write simple scripts and programs. You\'ll practice writing code, debugging common errors, and understanding how JavaScript can be used to solve real-world problems. Perfect for those who have completed the essentials course or have some basic programming knowledge.', 'Beginner', 0, 2, 1, 6),
(5, 'JavaScript: Intermediate Concepts', 'Dive deeper into the world of JavaScript with a focus on more advanced functions, objects, and arrays. This course will help you understand how to work with complex data structures and utilize JavaScript\'s powerful features to write more efficient and effective code. Additionally, you\'ll explore asynchronous programming and promises, learning how to handle asynchronous operations smoothly. This course is ideal for those who have a solid understanding of basic JavaScript and are looking to expand their knowledge.', 'Intermediate', 0, 2, 1, 6),
(6, 'Building Interactive Websites with JavaScript', 'Learn how to enhance the interactivity and user experience of websites using JavaScript. In this course, you\'ll explore the Document Object Model (DOM) and learn how to manipulate HTML and CSS using JavaScript. You\'ll also delve into event handling, enabling your web pages to respond to user actions like clicks and form submissions. By the end of this course, you\'ll be able to create dynamic and interactive web applications that engage users effectively.', 'Intermediate', 0, 2, 1, 6),
(7, 'Mastering JavaScript: Advanced Techniques', 'Explore the advanced concepts and techniques that will take your JavaScript skills to the next level. This course covers closures, prototypes, and module patterns, providing you with a deep understanding of how JavaScript works under the hood. You\'ll learn how to write more maintainable and scalable code, use advanced patterns to solve complex problems, and gain insights into JavaScript\'s unique features. This course is perfect for experienced JavaScript developers looking to master the language and apply best practices in their projects.', 'Advanced', 0, 2, 1, 6),
(8, ' Java for Beginners: A Comprehensive Guide', 'This course is your starting point for learning Java programming. You\'ll be introduced to the core concepts of Java, including basic syntax, variables, and control structures such as loops and conditionals. By the end of this course, you\'ll be able to write simple Java programs, understand the fundamentals of how Java works, and set a strong foundation for more advanced topics.', 'Beginner', 0, 4, 1, 7),
(9, 'Getting Started with Java Programming', 'Learn the foundational elements of Java with a focus on object-oriented programming (OOP) principles. This course will guide you through creating and using classes and objects, understanding inheritance, and implementing basic polymorphism. Ideal for those who have a basic understanding of programming and want to delve deeper into Java\'s OOP features.', 'Beginner', 0, 4, 1, 7),
(10, 'Java Intermediate: Building Applications', 'Take your Java skills to the next level by building real-world applications. This course covers essential intermediate topics such as collections (lists, sets, and maps), exception handling, and file I/O operations. You\'ll learn how to manage and process data efficiently, handle errors gracefully, and work with files and directories. By the end of this course, you\'ll be able to create robust Java applications ready for deployment.', 'Intermediate', 0, 4, 1, 7),
(11, 'Java: From Intermediate to Advanced', 'Deepen your understanding of Java by exploring more complex concepts and techniques. This course covers concurrency (multithreading and synchronization), networking (creating server-client applications), and GUI development using JavaFX or Swing. You\'ll learn how to create responsive and interactive applications that can handle multiple tasks simultaneously and communicate over networks.\r\n\r\n', 'Intermediate', 0, 4, 1, 7),
(12, 'Advanced Java Programming Techniques', 'Master the advanced concepts and techniques in Java programming. This course delves into generics (writing flexible and reusable code), lambda expressions (functional programming in Java), and streams (processing sequences of data). You\'ll learn how to write more concise and efficient code, utilize Java\'s powerful functional programming features, and handle large data sets with ease. Ideal for experienced Java developers looking to refine their skills and stay up-to-date with modern Java practices.\r\n\r\n\r\n\r\n\r\nMaster the advanced concepts and techniques in Java programming. This course delves into generics (writing flexible and reusable code), lambda expressions (functional programming in Java), and streams (processing sequences of data). You\'ll learn how to write more concise and efficient code, utilize Java\'s powerful functional programming features, and handle large data sets with ease. Ideal for experienced Java developers looking to refine their skills and stay up-to-date with modern Java practices.\r\n\r\n\r\n\r\n\r\n\r\n', 'Advanced', 0, 4, 1, 7),
(13, 'C++ Programming for Beginners', 'This course is designed to introduce you to the C++ programming language. You will learn the basic syntax, data types, and how to write simple algorithms. The course covers fundamental programming concepts such as variables, operators, control structures (loops and conditionals), and basic input/output operations. By the end of this course, you\'ll be able to write basic C++ programs and understand how to apply C++ to solve simple problems.', 'Beginner', 0, 3, 1, 8),
(14, 'Getting Started with C++', 'Build a solid foundation in C++ by understanding its core principles and basic constructs. This course covers the essentials of C++ programming, including variable declarations, data types, and control flow statements. You\'ll also work on simple projects that help reinforce your learning and give you hands-on experience. This course is perfect for beginners who want to get a practical introduction to programming with C++.', 'Beginner', 0, 3, 1, 8),
(15, 'Intermediate C++ Programming', 'Enhance your C++ skills by working on more complex projects and diving deeper into object-oriented programming (OOP). This course covers essential OOP concepts such as classes, inheritance, and polymorphism. You\'ll learn how to design and implement complex software systems using C++, create reusable code, and understand the principles of encapsulation and abstraction. By the end of this course, you\'ll be able to tackle more sophisticated programming challenges.\r\n\r\n', 'Intermediate', 0, 3, 1, 8),
(16, 'C++ Intermediate: Data Structures and Algorithms', 'Focus on the implementation and use of data structures and algorithms in C++. This course teaches you how to efficiently manage and manipulate data using lists, stacks, queues, and other data structures. You\'ll also learn important algorithms for sorting, searching, and manipulating data, which are crucial for writing efficient programs. This course is ideal for those looking to deepen their understanding of how data structures and algorithms are implemented and used in C++.', 'Intermediate', 0, 3, 1, 8),
(17, ' Advanced C++ Programming', 'Dive into advanced C++ topics and techniques to master the language. This course covers advanced concepts such as templates (for writing generic and reusable code), advanced features of the Standard Template Library (STL), and memory management techniques. You\'ll learn about smart pointers, memory allocation, and optimization strategies to write efficient and high-performance C++ code. This course is perfect for experienced C++ programmers who want to refine their skills and explore the more intricate aspects of the language.', 'Advanced', 0, 3, 1, 8),
(18, 'Ruby Programming for Beginners', 'Introduction to the Ruby programming language, designed for those new to coding. You will learn the basic syntax of Ruby, including how to use control structures like loops and conditionals, as well as how to create simple methods. This course will give you a solid grounding in the fundamental concepts of Ruby, enabling you to write basic programs and understand the language\'s core features.', 'Beginner', 0, 5, 1, 9),
(19, ' Getting Started with Ruby', 'Understand the basics of Ruby with a focus on hands-on learning. This course covers foundational programming concepts, including variable assignment, data types, and basic input/output operations. You\'ll work through practical examples and exercises that reinforce your understanding and help you apply what you\'ve learned. Perfect for beginners looking to gain practical experience with Ruby programming.', 'Beginner', 0, 5, 1, 9),
(20, ' Intermediate Ruby Programming', 'Develop your Ruby skills by working on more complex projects. This course covers object-oriented programming (OOP) concepts in Ruby, including how to define and use classes and objects, inheritance, and modules. You\'ll learn to create more structured and reusable code, understanding the principles of encapsulation and polymorphism, which are key to advanced Ruby programming.', 'Beginner', 0, 5, 1, 9),
(21, 'Building Applications with Ruby', 'Learn how to build and deploy Ruby applications in this hands-on course. You\'ll explore essential topics such as file handling, interacting with databases, and using popular web frameworks like Ruby on Rails. By the end of this course, you\'ll be able to create functional Ruby applications, manage data storage, and deploy your applications to production environments.', 'Beginner', 0, 5, 1, 9),
(22, 'Mastering Ruby: Advanced Techniques', 'Explore advanced Ruby programming concepts to master the language. This course covers metaprogramming, which allows you to write code that writes code, as well as Domain-Specific Languages (DSLs) for creating specialized mini-languages within Ruby. You\'ll also learn performance optimization techniques to ensure your Ruby code runs efficiently. This course is ideal for experienced Ruby developers looking to deepen their knowledge and enhance their coding capabilities.', 'Advanced', 0, 5, 1, 9);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'Training_App', 'admindetails'),
(14, 'Training_App', 'assignments'),
(22, 'Training_App', 'category'),
(20, 'Training_App', 'chat'),
(8, 'Training_App', 'course'),
(13, 'Training_App', 'enrollment'),
(21, 'Training_App', 'feedback_data'),
(17, 'Training_App', 'group'),
(18, 'Training_App', 'group_member'),
(24, 'Training_App', 'interest'),
(12, 'Training_App', 'lectures'),
(16, 'Training_App', 'questions'),
(9, 'Training_App', 'student'),
(10, 'Training_App', 'student_assignments'),
(23, 'Training_App', 'subcategory'),
(19, 'Training_App', 'submitted_quiz'),
(11, 'Training_App', 'teacher'),
(15, 'Training_App', 'title');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'Training_App', '0001_initial', '2024-06-04 10:25:25.978256'),
(2, 'Training_App', '0002_title', '2024-06-04 10:25:26.023731'),
(3, 'Training_App', '0003_questions', '2024-06-04 10:25:26.140779'),
(4, 'Training_App', '0004_rename_question1_questions_option2_and_more', '2024-06-04 10:25:26.194602'),
(5, 'Training_App', '0005_questions_option1_alter_questions_answer_and_more', '2024-06-04 10:25:26.458952'),
(6, 'Training_App', '0006_alter_questions_title_id', '2024-06-04 10:25:26.572540'),
(7, 'Training_App', '0007_alter_questions_title_id', '2024-06-04 10:25:26.583510'),
(8, 'Training_App', '0008_group', '2024-06-04 10:25:26.677880'),
(9, 'Training_App', '0009_group_member', '2024-06-04 10:25:26.811542'),
(10, 'Training_App', '0010_enrollment_month', '2024-06-04 10:25:26.839044'),
(11, 'Training_App', '0011_submitted_quiz', '2024-06-04 10:25:26.936693'),
(12, 'Training_App', '0012_alter_submitted_quiz_title_id', '2024-06-04 10:25:27.062774'),
(13, 'Training_App', '0013_alter_student_assignments_assignment_id', '2024-06-04 10:25:27.215550'),
(14, 'Training_App', '0014_chat', '2024-06-04 10:25:27.336649'),
(15, 'Training_App', '0015_feedback', '2024-06-04 10:25:27.387932'),
(16, 'Training_App', '0016_alter_teacher_address', '2024-06-04 10:25:27.406226'),
(17, 'Training_App', '0017_category', '2024-06-04 10:25:27.442841'),
(18, 'contenttypes', '0001_initial', '2024-06-04 10:25:27.539183'),
(19, 'auth', '0001_initial', '2024-06-04 10:25:28.493445'),
(20, 'admin', '0001_initial', '2024-06-04 10:25:28.715511'),
(21, 'admin', '0002_logentry_remove_auto_add', '2024-06-04 10:25:28.743836'),
(22, 'admin', '0003_logentry_add_action_flag_choices', '2024-06-04 10:25:28.764781'),
(23, 'contenttypes', '0002_remove_content_type_name', '2024-06-04 10:25:28.858245'),
(24, 'auth', '0002_alter_permission_name_max_length', '2024-06-04 10:25:28.926504'),
(25, 'auth', '0003_alter_user_email_max_length', '2024-06-04 10:25:28.957082'),
(26, 'auth', '0004_alter_user_username_opts', '2024-06-04 10:25:28.980017'),
(27, 'auth', '0005_alter_user_last_login_null', '2024-06-04 10:25:29.044674'),
(28, 'auth', '0006_require_contenttypes_0002', '2024-06-04 10:25:29.057652'),
(29, 'auth', '0007_alter_validators_add_error_messages', '2024-06-04 10:25:29.078055'),
(30, 'auth', '0008_alter_user_username_max_length', '2024-06-04 10:25:29.106817'),
(31, 'auth', '0009_alter_user_last_name_max_length', '2024-06-04 10:25:29.135247'),
(32, 'auth', '0010_alter_group_name_max_length', '2024-06-04 10:25:29.164056'),
(33, 'auth', '0011_update_proxy_permissions', '2024-06-04 10:25:29.199932'),
(34, 'auth', '0012_alter_user_first_name_max_length', '2024-06-04 10:25:29.228352'),
(35, 'sessions', '0001_initial', '2024-06-04 10:25:29.387064'),
(36, 'Training_App', '0018_auto_20240608_1652', '2024-06-08 11:22:49.388099'),
(37, 'Training_App', '0019_alter_category_category_description', '2024-06-08 11:54:23.155215'),
(38, 'Training_App', '0020_alter_subcategory_subcategory_description', '2024-06-10 09:40:55.342832'),
(39, 'Training_App', '0021_auto_20240610_1814', '2024-06-10 12:44:25.086820'),
(40, 'Training_App', '0022_auto_20240610_1854', '2024-06-10 13:25:02.236358'),
(41, 'Training_App', '0023_auto_20240612_1833', '2024-06-12 13:03:35.410708');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('dby8cksadwm9xoiws2n792cog1g1bpue', '.eJyrViqpLEiNz0xRslJyTMnNzFPSUQotTi0KAYoiCeXkpwNpK6XI1GKlWgDIGBDi:1sHNtD:yjvsfz6YvJ_FVA90aXWtkQfcZugORAmwOLdVSgrdl2o', '2024-06-26 13:19:47.681529');

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `month` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollment`
--

INSERT INTO `enrollment` (`id`, `course_id`, `student_id`, `month`) VALUES
(1, 1, 1, 'June');

-- --------------------------------------------------------

--
-- Table structure for table `feedback_data`
--

CREATE TABLE `feedback_data` (
  `id` bigint(20) NOT NULL,
  `student` varchar(100) DEFAULT NULL,
  `feedback` varchar(100) DEFAULT NULL,
  `sentiment` varchar(100) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback_data`
--

INSERT INTO `feedback_data` (`id`, `student`, `feedback`, `sentiment`, `remarks`) VALUES
(1, '1', 'mmmmm', 'Neutral', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE `group` (
  `id` bigint(20) NOT NULL,
  `group_name` varchar(100) NOT NULL,
  `course_id_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id`, `group_name`, `course_id_id`) VALUES
(1, 'Clear Your doubts', 1);

-- --------------------------------------------------------

--
-- Table structure for table `group_member`
--

CREATE TABLE `group_member` (
  `id` bigint(20) NOT NULL,
  `Group_id_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lectures`
--

CREATE TABLE `lectures` (
  `id` bigint(20) NOT NULL,
  `lecture_no` int(11) DEFAULT NULL,
  `lecture_description` longtext NOT NULL,
  `video_file` varchar(100) NOT NULL,
  `duration` varchar(100) NOT NULL,
  `course_id_id` bigint(20) NOT NULL,
  `teacher_id_id` bigint(20) DEFAULT NULL,
  `add_date` datetime(6) DEFAULT NULL,
  `last_update` datetime(6) DEFAULT NULL,
  `lecture_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lectures`
--

INSERT INTO `lectures` (`id`, `lecture_no`, `lecture_description`, `video_file`, `duration`, `course_id_id`, `teacher_id_id`, `add_date`, `last_update`, `lecture_name`) VALUES
(2, 1, 'Overview of Python\'s history and its development.\r\nKey features of Python, such as simplicity, readability, and versatility.', 'lecture_videos/production_id_3999399_1080p.mp4', '27.71', 1, 1, NULL, NULL, 'Introduction to Python'),
(3, 2, 'Conditional Statements\r\n\r\nUsing if, elif, and else statements to control program flow based on conditions.\r\nLoops\r\n\r\nImplementing for loops for iterating over sequences (lists, tuples, ranges).\r\nUsing while loops for repeated execution based on a condition.', 'lecture_videos/pexels-jessica-politi-992601-1920x1080-25fps_1.mp4', '25.45', 1, 1, NULL, NULL, 'Control Structures and Functions in Python'),
(4, 1, 'Definition and importance of data structures in programming.\r\nOverview of different types of data structures: linear and non-linear.', 'lecture_videos/production_id_5206966_2160p.mp4', '23.64', 2, 1, NULL, NULL, 'Introduction to Data Structures');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint(20) NOT NULL,
  `option2` varchar(100) DEFAULT NULL,
  `option3` varchar(100) DEFAULT NULL,
  `option4` varchar(100) DEFAULT NULL,
  `question` varchar(100) DEFAULT NULL,
  `answer` varchar(100) DEFAULT NULL,
  `title_id_id` bigint(20) DEFAULT NULL,
  `option1` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `option2`, `option3`, `option4`, `question`, `answer`, `title_id_id`, `option1`) VALUES
(1, 'b) print(\"Hello, World\")', 'c) printf(\"Hello, World\")', 'd) cout << \"Hello, World\"', 'What is the correct syntax to output \"Hello, World\" in Python?', '2', 1, 'a) echo \"Hello, World\"'),
(2, 'x = 5', 'x := 5', 'x == 5', 'How do you create a variable with the numeric value 5 in Python?', '2', 1, 'x = int(5)'),
(3, ' myList = [1, 2, 3]', 'myList = (1, 2, 3)', ' myList = <1, 2, 3>', 'Which of the following is a valid list in Python?', '2', 1, 'myList = {1, 2, 3}');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `full_name`, `email`, `Address`, `phone`, `birth_date`, `gender`, `username`, `password`) VALUES
(1, 'Siddesh Gite', 'siddesh@gmail.com', 'Shewri', '8547120369', '1979-08-08', 'Male', 'sidd', 'S123');

-- --------------------------------------------------------

--
-- Table structure for table `student_assignments`
--

CREATE TABLE `student_assignments` (
  `id` bigint(20) NOT NULL,
  `Assignment_id_id` bigint(20) DEFAULT NULL,
  `student_file` varchar(100) NOT NULL,
  `student_id` varchar(100) NOT NULL,
  `remarks` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subcategory`
--

CREATE TABLE `subcategory` (
  `id` bigint(20) NOT NULL,
  `subcategory_name` varchar(100) DEFAULT NULL,
  `subcategory_description` longtext DEFAULT NULL,
  `category_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategory`
--

INSERT INTO `subcategory` (`id`, `subcategory_name`, `subcategory_description`, `category_id`) VALUES
(4, 'Python', 'Python is a high-level, interpreted, and general-purpose programming language. It was created by Guido van Rossum and first released in 1991. Python emphasizes code readability and simplicity, making it an excellent language for beginners and experienced developers. Getting Started with Python is easy due to its straightforward syntax and extensive documentation, which provides ample resources for learning and development.', 1),
(5, 'Ethical Hacking', 'Ethical Hacking', 3),
(6, 'JavaScript', 'JavaScript is a scripting language used to develop web pages. Developed in Netscape, JS allows developers to create a dynamic and interactive web page to interact with visitors and execute complex actions. It also enables users to load content into a document without reloading the entire page', 1),
(7, 'Java', 'Java is a widely-used programming language for coding web applications. It has been a popular choice among developers for over two decades, with millions of Java applications in use today. Java is a multi-platform, object-oriented, and network-centric language that can be used as a platform in itself.', 1),
(8, 'C++', 'Java is a widely-used programming language for coding web applications. It has been a popular choice among developers for over two decades, with millions of Java applications in use today. Java is a multi-platform, object-oriented, and network-centric language that can be used as a platform in itself.', 1),
(9, 'Ruby', 'Ruby is mainly used to build web applications and is useful for other programming projects. It is widely used for building servers and data processing, web scraping, and crawling. The leading framework used to run Ruby is Ruby on Rails, although that\'s not the only one.', 1),
(10, 'Machine Learning', 'Machine learning (ML) is defined as a discipline of artificial intelligence (AI) that provides machines the ability to automatically learn from data and past experiences to identify patterns and make predictions with minimal human intervention.', 4),
(11, 'Natural Language Processing (NLP)', 'Natural language processing (NLP) is a machine learning technology that gives computers the ability to interpret, manipulate, and comprehend human language.', 4),
(12, 'Robotics', 'Robotics in AI involves integrating AI technologies into robotic systems to enhance their capabilities and enable them to perform more complex tasks. AI in robotics allows robots to learn from experience, adapt to new situations, and make decisions based on data from sensors.', 4),
(13, 'Computer Vision', 'Computer vision is a field of computer science that focuses on enabling computers to identify and understand objects and people in images and videos. Like other types of AI, computer vision seeks to perform and automate tasks that replicate human capabilities.', 4),
(14, 'AI Ethics', 'AI ethics are the set of guiding principles that stakeholders (from engineers to government officials) use to ensure artificial intelligence technology is developed and used responsibly. This means taking a safe, secure, humane, and environmentally friendly approach to AI.', 4),
(15, 'Web Development', 'Web Development', 5),
(16, 'Mobile App Development', 'Mobile App Development', 5),
(17, 'Game Development', 'Game Development', 5),
(18, 'Desktop Applications', 'Desktop Applications', 5),
(19, 'Software Engineering', 'Software Engineering', 5),
(20, 'Information Security', 'Information Security', 3),
(21, 'Incident Response', 'Incident Response', 3),
(22, 'Application Security', 'Application Security', 3),
(23, 'Network Security', 'Network Security', 3),
(24, 'Database Management Systems (DBMS)', 'Database Management Systems (DBMS)', 6),
(25, 'Database Design', 'Database Design', 6),
(26, 'Data Manipulation and Query Languages', 'Data Manipulation and Query Languages', 6),
(27, 'Data Storage and Retrieval', 'Data Storage and Retrieval', 6),
(28, 'Database Security', 'Database Security', 6);

-- --------------------------------------------------------

--
-- Table structure for table `submitted_quiz`
--

CREATE TABLE `submitted_quiz` (
  `id` bigint(20) NOT NULL,
  `score` varchar(100) DEFAULT NULL,
  `title_id_id` bigint(20) DEFAULT NULL,
  `student_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submitted_quiz`
--

INSERT INTO `submitted_quiz` (`id`, `score`, `title_id_id`, `student_id`) VALUES
(1, '0', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `full_name`, `email`, `Address`, `phone`, `birth_date`, `gender`, `username`, `password`) VALUES
(1, 'Priya Sanjay Thukarul', 'priya@gmail.com', 'Jogeshwari', '8745210369', '2001-02-17', 'Female', 'priya', 'P123'),
(2, 'Aruna Mahale', 'aruna@gmail.com', 'Kandivli West', '8745210369', '1980-10-13', 'Female', 'aruna', 'A123'),
(3, 'Aditi Dhole', 'aditi@gmail.com', 'Kandivli East', '8745210369', '1981-01-09', 'Female', 'aditi', 'A123'),
(4, 'Rovel Pinto', 'rovel@gmail.com', 'Santacruz', '9874563210', '1975-05-29', 'Male', 'rovel', 'R123'),
(5, 'Stephen Danteras', 'stephen@gmail.com', 'Virar East', '8974563210', '1987-01-05', 'Male', 'stephen', 'S123');

-- --------------------------------------------------------

--
-- Table structure for table `title`
--

CREATE TABLE `title` (
  `id` bigint(20) NOT NULL,
  `course_id` varchar(200) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `title`
--

INSERT INTO `title` (`id`, `course_id`, `title`) VALUES
(1, '1', 'Python');

-- --------------------------------------------------------

--
-- Table structure for table `training_app_interest`
--

CREATE TABLE `training_app_interest` (
  `id` bigint(20) NOT NULL,
  `subcategory_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admindetails`
--
ALTER TABLE `admindetails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Assignments_course_id_id_3611a11d_fk_Course_id` (`course_id_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Chat_group_id_237666b3_fk_Group_id` (`group_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Course_teacher_id_9c008ed6_fk_Teacher_id` (`teacher_id`),
  ADD KEY `Course_category_id_78c665cd_fk_Category_id` (`category_id`),
  ADD KEY `Course_subcategory_id_62a0eb67_fk_SubCategory_id` (`subcategory_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Enrollment_course_id_ab587c2d_fk_Course_id` (`course_id`),
  ADD KEY `Enrollment_student_id_0cbad9ac_fk_Student_id` (`student_id`);

--
-- Indexes for table `feedback_data`
--
ALTER TABLE `feedback_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Group_course_id_id_80b81d01_fk_Course_id` (`course_id_id`);

--
-- Indexes for table `group_member`
--
ALTER TABLE `group_member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Group_Member_Group_id_id_feb4f041_fk_Group_id` (`Group_id_id`),
  ADD KEY `Group_Member_student_id_2a68f02d_fk_Student_id` (`student_id`);

--
-- Indexes for table `lectures`
--
ALTER TABLE `lectures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Lectures_course_id_id_bac96ada_fk_Course_id` (`course_id_id`),
  ADD KEY `Lectures_teacher_id_id_80de83c6_fk_Teacher_id` (`teacher_id_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Questions_title_id_id_d0cb3b8f_fk_Title_id` (`title_id_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_assignments`
--
ALTER TABLE `student_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Student_Assignments_Assignment_id_id_4626b2e4` (`Assignment_id_id`);

--
-- Indexes for table `subcategory`
--
ALTER TABLE `subcategory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SubCategory_category_id_5bc4a841_fk_Category_id` (`category_id`);

--
-- Indexes for table `submitted_quiz`
--
ALTER TABLE `submitted_quiz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Submitted_Quiz_student_id_820421e0_fk_Student_id` (`student_id`),
  ADD KEY `Submitted_Quiz_title_id_id_e071e8fd` (`title_id_id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `title`
--
ALTER TABLE `title`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_app_interest`
--
ALTER TABLE `training_app_interest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Training_App_interest_subcategory_id_13f233e6_fk_SubCategory_id` (`subcategory_id`),
  ADD KEY `Training_App_interest_user_id_e4cf0d18_fk_Student_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admindetails`
--
ALTER TABLE `admindetails`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `enrollment`
--
ALTER TABLE `enrollment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `feedback_data`
--
ALTER TABLE `feedback_data`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `group`
--
ALTER TABLE `group`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `group_member`
--
ALTER TABLE `group_member`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lectures`
--
ALTER TABLE `lectures`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_assignments`
--
ALTER TABLE `student_assignments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subcategory`
--
ALTER TABLE `subcategory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `submitted_quiz`
--
ALTER TABLE `submitted_quiz`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `title`
--
ALTER TABLE `title`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `training_app_interest`
--
ALTER TABLE `training_app_interest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `Assignments_course_id_id_3611a11d_fk_Course_id` FOREIGN KEY (`course_id_id`) REFERENCES `course` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `Chat_group_id_237666b3_fk_Group_id` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `Course_category_id_78c665cd_fk_Category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `Course_subcategory_id_62a0eb67_fk_SubCategory_id` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`id`),
  ADD CONSTRAINT `Course_teacher_id_9c008ed6_fk_Teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `Enrollment_course_id_ab587c2d_fk_Course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  ADD CONSTRAINT `Enrollment_student_id_0cbad9ac_fk_Student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`);

--
-- Constraints for table `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `Group_course_id_id_80b81d01_fk_Course_id` FOREIGN KEY (`course_id_id`) REFERENCES `course` (`id`);

--
-- Constraints for table `group_member`
--
ALTER TABLE `group_member`
  ADD CONSTRAINT `Group_Member_Group_id_id_feb4f041_fk_Group_id` FOREIGN KEY (`Group_id_id`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `Group_Member_student_id_2a68f02d_fk_Student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`);

--
-- Constraints for table `lectures`
--
ALTER TABLE `lectures`
  ADD CONSTRAINT `Lectures_course_id_id_bac96ada_fk_Course_id` FOREIGN KEY (`course_id_id`) REFERENCES `course` (`id`),
  ADD CONSTRAINT `Lectures_teacher_id_id_80de83c6_fk_Teacher_id` FOREIGN KEY (`teacher_id_id`) REFERENCES `teacher` (`id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `Questions_title_id_id_d0cb3b8f_fk_Title_id` FOREIGN KEY (`title_id_id`) REFERENCES `title` (`id`);

--
-- Constraints for table `student_assignments`
--
ALTER TABLE `student_assignments`
  ADD CONSTRAINT `Student_Assignments_Assignment_id_id_4626b2e4_fk_Assignments_id` FOREIGN KEY (`Assignment_id_id`) REFERENCES `assignments` (`id`);

--
-- Constraints for table `subcategory`
--
ALTER TABLE `subcategory`
  ADD CONSTRAINT `SubCategory_category_id_5bc4a841_fk_Category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

--
-- Constraints for table `submitted_quiz`
--
ALTER TABLE `submitted_quiz`
  ADD CONSTRAINT `Submitted_Quiz_student_id_820421e0_fk_Student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `Submitted_Quiz_title_id_id_e071e8fd_fk_Title_id` FOREIGN KEY (`title_id_id`) REFERENCES `title` (`id`);

--
-- Constraints for table `training_app_interest`
--
ALTER TABLE `training_app_interest`
  ADD CONSTRAINT `Training_App_interest_subcategory_id_13f233e6_fk_SubCategory_id` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`id`),
  ADD CONSTRAINT `Training_App_interest_user_id_e4cf0d18_fk_Student_id` FOREIGN KEY (`user_id`) REFERENCES `student` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

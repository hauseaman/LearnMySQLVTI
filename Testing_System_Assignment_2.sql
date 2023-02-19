DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

CREATE TABLE Department(
	DepartmentID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName		VARCHAR(50) UNIQUE KEY NOT NULL
);

CREATE TABLE `Position`(
	PositionID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	PositionName		ENUM('Dev', 'Test', 'Scrum Master', 'PM')  UNIQUE KEY
);

CREATE TABLE `Account`(
	AccountID			SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email				VARCHAR(50) UNIQUE KEY,
    Username			VARCHAR(50) UNIQUE KEY NOT NULL,
    FullName			VARCHAR(50) NOT NULL,
    DepartmentID		TINYINT UNSIGNED,
    PositionID			TINYINT UNSIGNED,
    CreateDate			DATE DEFAULT(now()), -- '2023-02-18'
    Constraint fk_department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    Constraint fk_position FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
    
);

CREATE TABLE `Group`(
	GroupID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName			VARCHAR(100) UNIQUE KEY NOT NULL,
    CreatorID			SMALLINT UNSIGNED,
    CreateDate			DATE DEFAULT(now()),
    Constraint fk_group_account FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
	
);

CREATE TABLE `GroupAccount`(
	ID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	GroupID				TINYINT UNSIGNED,    -- 1 1 1 2
	AccountID			SMALLINT UNSIGNED,	 -- 1 2 4 1
    JoinDate			DATE DEFAULT(now()),
	UNIQUE KEY (GroupID, AccountID),
    Constraint fk_group FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    Constraint fk_account FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

CREATE TABLE TypeQuestion(
	TypeID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	TypeName			ENUM('Essay', 'Multiple-Choice') UNIQUE KEY
);

CREATE TABLE CategoryQuestion(
	CategoryID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	CategoryName			VARCHAR(50) UNIQUE KEY NOT NULL
);

CREATE TABLE Question(
	QuestionID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content					VARCHAR(1000) NOT NULL,
	CategoryID				TINYINT UNSIGNED,
	TypeID					TINYINT UNSIGNED,
	CreatorID				SMALLINT UNSIGNED,
    CreateDate				DATE DEFAULT(now()),
    Constraint fk_categoryquestion FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    Constraint fk_typequestion FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID)
);

CREATE TABLE Answer(
	AnswerID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content					VARCHAR(1000) NOT NULL,
	QuestionID				TINYINT UNSIGNED,
	isCorrect				BOOLEAN NOT NULL,
    constraint fk_question FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

CREATE TABLE Exam(
	ExamID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`Code`					VARCHAR(20) UNIQUE KEY NOT NULL,
	Title					VARCHAR(50) NOT NULL,
	CategoryID				TINYINT UNSIGNED,
	Duration				SMALLINT UNSIGNED NOT NULL,
	CreatorID				SMALLINT UNSIGNED,
	CreateDate				DATE DEFAULT(now()),
    Constraint fk_exam_categoryquestion FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    Constraint fk_exam_account FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE ExamQuestion(
	ID						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	ExamID					TINYINT UNSIGNED,
    QuestionID				TINYINT UNSIGNED,
	UNIQUE KEY (ExamID, QuestionID),
    Constraint fk_examquestion_exam FOREIGN KEY (ExamID) REFERENCES `Exam`(ExamID),
    Constraint fk_examquestion_question FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

INSERT INTO Department	(DepartmentName)
VALUES					("Assistant"),
						("HR"),
						("Training"),
						("security"),
						("canteen");









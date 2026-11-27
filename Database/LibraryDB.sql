-- ============================================================
--  База данных LibraryDB
--  Практическая работа № 4 (таблицы Authors, Books, Readers, Issues)
--  Практическая работа № 5 (таблицы Roles, Users)
-- ============================================================

USE master;
GO

IF DB_ID(N'LibraryDB') IS NULL
    CREATE DATABASE LibraryDB;
GO

USE LibraryDB;
GO

-- ============================================================
--  Таблицы практической работы № 4
-- ============================================================

CREATE TABLE Authors (
    AuthorID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Authors PRIMARY KEY,
    FullName NVARCHAR(100)     NOT NULL,
    Country  NVARCHAR(50)      NULL
);
GO

CREATE TABLE Books (
    BookID          INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Books PRIMARY KEY,
    Title           NVARCHAR(200)     NOT NULL,
    AuthorID        INT               NOT NULL,
    PublicationYear INT               NULL,
    Price           DECIMAL(10,2)     NULL,
    CONSTRAINT FK_Books_Authors FOREIGN KEY (AuthorID) REFERENCES Authors (AuthorID)
);
GO

CREATE TABLE Readers (
    ReaderID         INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Readers PRIMARY KEY,
    FullName         NVARCHAR(100)     NOT NULL,
    RegistrationDate DATE              NULL CONSTRAINT DF_Readers_RegistrationDate DEFAULT GETDATE()
);
GO

CREATE TABLE Issues (
    IssueID    INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Issues PRIMARY KEY,
    BookID     INT               NOT NULL,
    ReaderID   INT               NOT NULL,
    IssueDate  DATE              NOT NULL,
    ReturnDate DATE              NULL,
    CONSTRAINT FK_Issues_Books FOREIGN KEY (BookID) REFERENCES Books (BookID),
    CONSTRAINT FK_Issues_Readers FOREIGN KEY (ReaderID) REFERENCES Readers (ReaderID)
);
GO

-- ============================================================
--  Таблицы практической работы № 5
-- ============================================================

CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Roles PRIMARY KEY,
    Name   NVARCHAR(50)      NOT NULL CONSTRAINT UQ_Roles_Name UNIQUE
);
GO

CREATE TABLE Users (
    UserID       INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Users PRIMARY KEY,
    Login        NVARCHAR(50)      NOT NULL CONSTRAINT UQ_Users_Login UNIQUE,
    PasswordHash NVARCHAR(64)      NOT NULL,
    RoleID       INT               NOT NULL,
    ReaderID     INT               NULL CONSTRAINT UQ_Users_ReaderID UNIQUE,
    CreatedAt    DATETIME2         NOT NULL,
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleID) REFERENCES Roles (RoleID),
    CONSTRAINT FK_Users_Readers FOREIGN KEY (ReaderID) REFERENCES Readers (ReaderID)
);
GO

-- ============================================================
--  Начальные данные
-- ============================================================

INSERT INTO Authors (FullName, Country) VALUES
    (N'Лев Толстой',      N'Россия'),
    (N'Джоан Роулинг',    N'Великобритания'),
    (N'Эрнест Хемингуэй', N'США'),
    (N'Фёдор Достоевский', N'Россия'),
    (N'Антон Чехов',       N'Россия'),
    (N'Михаил Булгаков',   N'Россия'),
    (N'Габриэль Гарсиа Маркес', N'Колумбия'),
    (N'Франц Кафка',       N'Австрия'),
    (N'Джордж Оруэлл',     N'Великобритания'),
    (N'Айзек Азимов',      N'США');

INSERT INTO Books (Title, AuthorID, PublicationYear, Price) VALUES
    (N'Война и мир',                       1, 1969, 1200.00),
    (N'Гарри Поттер и философский камень', 2, 1997,  800.50),
    (N'Старик и море',                     3, 1952,  450.75),
    (N'Преступление и наказание',          4, 1966, 1100.00),
    (N'Братья Карамазовы',                 4, 1980, 1350.00),
    (N'Вишнёвый сад',                      5, 1904,  620.00),
    (N'Мастер и Маргарита',                6, 1967, 1500.00),
    (N'Сто лет одиночества',               7, 1967, 1050.00),
    (N'1984',                              9, 2021,  870.00),
    (N'Основание',                        10, 2022,  930.00);

INSERT INTO Readers (FullName) VALUES
    (N'Иван Иванов'),
    (N'Мария Петрова'),
    (N'Алексей Сидоров'),
    (N'Екатерина Смирнова'),
    (N'Дмитрий Козлов'),
    (N'Ольга Новикова'),
    (N'Сергей Морозов'),
    (N'Анна Волкова'),
    (N'Павел Лебедев'),
    (N'Наталья Соколова');

INSERT INTO Issues (BookID, ReaderID, IssueDate, ReturnDate) VALUES
    (1, 1, '2024-03-01', '2024-03-20'),
    (2, 2, '2024-03-15', NULL),
    (3, 3, '2024-03-20', NULL),
    (4, 4, '2024-04-01', '2024-04-20'),
    (5, 5, '2024-04-05', NULL),
    (6, 6, '2024-04-10', '2024-04-25'),
    (7, 7, '2024-04-15', NULL),
    (8, 8, '2024-04-20', NULL),
    (9, 9, '2024-05-01', '2024-06-15'),
    (10, 10, '2024-05-10', NULL);

INSERT INTO Roles (Name) VALUES
    (N'Читатель'),
    (N'Библиотекарь'),
    (N'Администратор');
GO

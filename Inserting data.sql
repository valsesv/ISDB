-- Inserting data into LibraryDepartments
INSERT INTO LibraryDepartments (name) VALUES
  ('Отдел русской литературы'),
  ('Отдел научной литературы'),
  ('Отдел искусств');

-- Inserting data into Genres
INSERT INTO Genres (name) VALUES
  ('Роман'),
  ('Научно-популярное'),
  ('Искусство');

-- Inserting data into Publishers
INSERT INTO Publishers (name) VALUES
  ('Издательство "Русская книга"'),
  ('Издательство "Наука"'),
  ('Издательство "Искусство"');

-- Inserting data into Authors
INSERT INTO Authors (name) VALUES
  ('Александр Пушкин'),
  ('Фёдор Достоевский'),
  ('Лев Толстой');

-- Inserting data into LibraryStaff
INSERT INTO LibraryStaff (name) VALUES
  ('Екатерина Иванова'),
  ('Алексей Смирнов'),
  ('Ольга Петрова');

-- Inserting data into Readers
INSERT INTO Readers (name, contact_data, reader_number) VALUES
  ('Иван Иванов', 'ivan@example.com', 'R001'),
  ('Мария Смирнова', 'maria@example.com', 'R002'),
  ('Петр Петров', 'petr@example.com', 'R003');

-- Inserting data into Books
INSERT INTO Books (name, ISBN, author_id, publisher_id, genre_id, department_id, copies) VALUES
  ('Евгений Онегин', '978-5-9573-0422-5', 1, 1, 1, 1, 5),
  ('Преступление и наказание', '978-5-389-05550-2', 2, 2, 1, 1, 8),
  ('Война и мир', '978-5-389-06725-3', 3, 3, 1, 1, 10);

-- Inserting data into BookLoans
INSERT INTO BookLoans (book_id, reader_id, staff_id, issue_date, return_period) VALUES
  (1, 1, 1, '2023-01-01', '2023-01-15'),
  (2, 2, 2, '2023-02-01', '2023-02-15'),
  (3, 3, 3, '2023-03-01', '2023-03-15');

-- Inserting data into Penalties
INSERT INTO Penalties (reader_id, book_id, issue_date, debt_amount) VALUES
  (1, 1, '2023-01-20', 5.00),
  (2, 2, '2023-02-20', 7.50),
  (3, 3, '2023-03-20', 10.00);

-- Inserting data into BookReservations
INSERT INTO BookReservations (name, book_id, reader_id, staff_id, reservation_date) VALUES
  ('Резерв: Евгений Онегин', 1, 1, 1, '2023-01-05'),
  ('Резерв: Преступление и наказание', 2, 2, 2, '2023-02-05'),
  ('Резерв: Война и мир', 3, 3, 3, '2023-03-05');

-- Inserting data into Ratings
INSERT INTO Ratings (book_id, reader_id, rate_date, rate_amount, rate_text) VALUES
  (1, 1, '2023-01-10', 4, 'Отличная книга!'),
  (2, 2, '2023-02-10', 5, 'Великолепное произведение'),
  (3, 3, '2023-03-10', 4, 'Интересно, но сложно');
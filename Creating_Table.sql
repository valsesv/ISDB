create table if not exists LibraryDepartments
(
    department_id   serial primary key,
    name            varchar(50) not null
);

create table if not exists Genres
(
    genre_id        serial primary key,
    name            varchar(50) not null
);

create table if not exists Publishers
(
    publisher_id    serial primary key,
    name            varchar(50) not null
);

create table if not exists Authors
(
    author_id   serial primary key,
    name        varchar(50) not null
);

create table if not exists LibraryStaff
(
    staff_id        serial primary key,
    name            varchar(50) not null
);

create table if not exists Readers
(
    reader_id      serial primary key,
    name           varchar(50) not null,
    contact_data   varchar(50) not null,
    reader_number  varchar(50) not null
);

create table if not exists Books
(
    book_id     serial primary key,
    name        varchar(50) not null,
    ISBN        varchar(50) not null,
    author_id         int not null
        references Authors (author_id),
    publisher_id        int not null
        references Publishers (publisher_id),
    genre_id            int not null
        references Genres (genre_id),
    department_id       int not null
        references LibraryDepartments (department_id),
    copies      integer
);

create table if not exists BookLoans
(
    loan_id         serial primary key,
    book_id         int not null
        references Books (book_id),
    reader_id       int not null
        references Readers (reader_id),
    staff_id           int not null
        references LibraryStaff (staff_id),
    issue_date      DATE,
    return_period   DATE
);

create table if not exists Penalties
(
    penalty_id      serial primary key,
    reader_id       int not null
        references Readers (reader_id),
    book_id         int not null
        references Books (book_id),
    issue_date      DATE,
    debt_amount     DECIMAl
);

create table if not exists BookReservations
(
    reservation_id      serial primary key,
    name                varchar(50) not null,
    book_id             int not null
        references Books (book_id),
    reader_id           int not null
        references Readers (reader_id),
    staff_id           int not null
        references LibraryStaff (staff_id),
    reservation_date    DATE
);

create table if not exists Ratings
(
    rate_id      serial primary key,
    book_id             int not null
        references Books (book_id),
    reader_id           int not null
        references Readers (reader_id),
    rate_date           DATE,
    rate_amount         int not null,
    rate_text           text
);

-- Creating sequences for serial columns
CREATE SEQUENCE IF NOT EXISTS loan_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS penalty_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS reservation_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS rate_id_seq START 1;

-- Creating triggers for serial columns
CREATE OR REPLACE FUNCTION set_loan_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.loan_id := nextval('loan_id_seq');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_loan_id_trigger
BEFORE INSERT ON BookLoans
FOR EACH ROW
EXECUTE FUNCTION set_loan_id();

CREATE OR REPLACE PROCEDURE reserve_book(
    in_book_id INT,
    in_reader_id INT,
    in_staff_id INT,
    in_reservation_date DATE,
    OUT out_reservation_id INT
)
AS $$
BEGIN
INSERT INTO BookReservations (name, book_id, reader_id, staff_id, reservation_date)
VALUES (
               'Резерв: ' || (SELECT name FROM Books WHERE book_id = in_book_id),
               in_book_id,
               in_reader_id,
               in_staff_id,
               in_reservation_date
       )
RETURNING reservation_id INTO out_reservation_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE add_book_review(
    in_book_id INT,
    in_reader_id INT,
    in_rate_amount INT,
    in_rate_text TEXT,
    in_rate_date DATE
)
AS $$
BEGIN
INSERT INTO Ratings (book_id, reader_id, rate_amount, rate_text, rate_date)
VALUES (in_book_id, in_reader_id, in_rate_amount, in_rate_text, in_rate_date);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE add_penalty(
    in_reader_id INT,
    in_book_id INT,
    in_issue_date DATE,
    in_debt_amount DECIMAL
)
AS $$
BEGIN
INSERT INTO Penalties (reader_id, book_id, issue_date, debt_amount)
VALUES (in_reader_id, in_book_id, in_issue_date, in_debt_amount);
END;
$$ LANGUAGE plpgsql;


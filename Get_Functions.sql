CREATE FUNCTION get_book_loan_info(in_book_id INT)
RETURNS TABLE (
    book_id INT,
    reader_name VARCHAR,
    issue_date DATE,
    return_period DATE
) AS $$
BEGIN
    RETURN QUERY
SELECT
    bl.book_id,
    r.name AS reader_name,
    bl.issue_date,
    bl.return_period
FROM
    BookLoans bl
        JOIN
    Readers r ON bl.reader_id = r.reader_id
WHERE
        bl.book_id = in_book_id;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_reader_reservations(in_reader_id INT)
RETURNS TABLE (
    reservation_id INT,
    book_name VARCHAR,
    reservation_date DATE
) AS $$
BEGIN
    RETURN QUERY
SELECT
    br.reservation_id,
    b.name AS book_name,
    br.reservation_date
FROM
    BookReservations br
        JOIN Books b ON br.book_id = b.book_id
WHERE
        br.reader_id = in_reader_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_books_by_department(department_name varchar)
    RETURNS TABLE (
                      book_id INT,
                      name VARCHAR,
                      author VARCHAR,
                      genre VARCHAR,
                      copies INT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            b.book_id,
            b.name,
            a.name AS author,
            g.name AS genre,
            b.copies
        FROM
            Books b
                JOIN Authors a ON b.author_id = a.author_id
                JOIN Genres g ON b.genre_id = g.genre_id
                JOIN LibraryDepartments d ON b.department_id = d.department_id
        WHERE
                d.name ILIKE '%' || department_name || '%';
END;
$$ LANGUAGE plpgsql;
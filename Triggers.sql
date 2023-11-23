-- Update the copies column in the Books table when a book is loaned.

CREATE OR REPLACE FUNCTION update_book_copies()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
UPDATE Books
SET copies = copies - 1
WHERE book_id = NEW.book_id;
ELSIF TG_OP = 'DELETE' THEN
UPDATE Books
SET copies = copies + 1
WHERE book_id = OLD.book_id;
END IF;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_book_copies_trigger
    AFTER INSERT OR DELETE ON BookLoans
FOR EACH ROW
EXECUTE FUNCTION update_book_copies();

-- Update the average rating of a book when a new rating is added.
CREATE OR REPLACE FUNCTION update_average_rating()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
UPDATE Books
SET average_rating = calculate_average_rating(NEW.book_id);
END IF;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_average_rating_trigger
    AFTER INSERT ON Ratings
    FOR EACH ROW
    EXECUTE FUNCTION update_average_rating();


-- Trigger to ensure that a reader cannot have more than a specified number of overdue books at any given time
CREATE OR REPLACE FUNCTION check_overdue_books_limit()
RETURNS TRIGGER AS $$
DECLARE
max_overdue_limit INT := 3;
    overdue_count INT;
BEGIN
    IF TG_OP = 'INSERT' THEN
SELECT COUNT(*)
INTO overdue_count
FROM BookLoans
WHERE reader_id = NEW.reader_id
  AND return_period < current_date;

IF overdue_count >= max_overdue_limit THEN
            RAISE EXCEPTION 'Reader has exceeded the maximum limit of overdue books.';
END IF;
END IF;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_overdue_books_limit_trigger
    AFTER INSERT ON Penalties
    FOR EACH ROW
    EXECUTE FUNCTION check_overdue_books_limit();
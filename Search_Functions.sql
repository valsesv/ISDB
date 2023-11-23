CREATE INDEX idx_books_name ON Books(name);
CREATE INDEX idx_authors_name ON Authors(name);
CREATE INDEX idx_genres_name ON Genres(name);
CREATE INDEX idx_books_isbn ON Books(ISBN);
CREATE INDEX idx_ratings_book_id ON Ratings(book_id);


CREATE OR REPLACE FUNCTION search_books_by_title(title_pattern varchar)
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
WHERE
    b.name ILIKE '%' || title_pattern || '%';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_books_by_author(author_name varchar)
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
WHERE
    a.name ILIKE '%' || author_name || '%';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_books_by_genre(genre_name varchar)
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
WHERE
    g.name ILIKE '%' || genre_name || '%';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_books_by_isbn(isbn_pattern varchar)
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
WHERE
    b.ISBN ILIKE '%' || isbn_pattern || '%';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_books_by_rating(min_rating INT)
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
                JOIN Ratings r ON b.book_id = r.book_id
        GROUP BY
            b.book_id, a.name, g.name
        HAVING
                AVG(r.rate_amount) >= min_rating;
END;
$$ LANGUAGE plpgsql;




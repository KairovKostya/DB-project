-- 1) GROUP BY + HAVING

SELECT title.russian_title_nm, avg(review.rating) as avg
FROM anime_database.title
         INNER JOIN anime_database.review
                    ON title.title_id = review.title_id
GROUP BY title.russian_title_nm
HAVING avg(review.rating) >= 8.5;

-- В результате данного запроса
-- 1)будут найдены все тайтлы, на которые дал отзыв хотя бы один пользователь
-- 2)Будут посчитаны их средние оценки по мнению пользователей и
-- показаны только те тайтлы, у которых эти оценки выше 8.5

-- 2) ORDER  BY

SELECT title.american_title_nm, title.rating, producer.producer_birth_dt
FROM anime_database.title
         INNER JOIN anime_database.producer
                    ON title.producer_id = producer.producer_id
ORDER BY producer_birth_dt;

-- В результате данного запроса
-- 1)будет выведен список тайтлов, отсортированных по дате рождения их режиссёра
-- 2)будут вывgenедены: название тайтла на английском, его рейтинг и дата рождения режиссёра

-- 3) func() OVER(): PARTITION BY

SELECT DISTINCT g.genre_nm, avg(rating) OVER (PARTITION BY g.genre_nm) AS "avg_price"
FROM anime_database.title
         INNER JOIN anime_database.genre_x_title gxt on title.title_id = gxt.title_id
         INNER JOIN anime_database.genre g on g.genre_id = gxt.genre_id
ORDER BY avg_price;

-- В результате данного запроса будет найдена средняя оценка по каждому названию жанра

-- 4) func() OVER(): ORDER BY

SELECT anime_database.producer.producer_birth_dt,
       anime_database.title.rating,
       sum(anime_database.title.rating) OVER (ORDER BY anime_database.producer.producer_birth_dt) AS "points_amount"
FROM anime_database.title
         INNER JOIN anime_database.producer on title.producer_id = anime_database.producer.producer_id

-- В результате данного запроса будут выведены:
    -- дата рождения режиссёра, количество очков рейтинга,
    -- которые он привлёк в общую сумму очков, нарастающий итог суммарного количества очков рейтинга.

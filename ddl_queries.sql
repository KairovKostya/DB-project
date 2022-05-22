CREATE SCHEMA anime_database;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE anime_database.producer
(
    producer_id       SERIAL PRIMARY KEY,
    producer_nm       VARCHAR(255) NOT NULL,
    producer_birth_dt DATE         NOT NULL,
    country           VARCHAR(255) NOT NULL
);

CREATE TABLE anime_database.title
(
    title_id          SERIAL PRIMARY KEY,
    russian_title_nm  VARCHAR(255) NOT NULL,
    american_title_nm VARCHAR(255) NOT NULL,
    producer_id       SERIAL       NOT NULL,
    rating            FLOAT CHECK (10 >= rating),
    FOREIGN KEY (producer_id)
        REFERENCES anime_database.producer (producer_id)
);

CREATE TABLE anime_database.user
(
    user_id SERIAL PRIMARY KEY,
    user_nm VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL
);

CREATE TABLE anime_database.review
(
    review_id SERIAL PRIMARY KEY,
    title_id  SERIAL NOT NULL,
    user_id   SERIAL NOT NULL,
    rating    FLOAT CHECK (10 >= rating),
    FOREIGN KEY (title_id)
        REFERENCES anime_database.title (title_id),
    FOREIGN KEY (user_id)
        REFERENCES anime_database.user (user_id)
);

CREATE TABLE anime_database.genre
(
    genre_id SERIAL PRIMARY KEY,
    genre_nm VARCHAR(255) NOT NULL
);

CREATE TABLE anime_database.genre_x_title
(
    title_id SERIAL NOT NULL,
    genre_id SERIAL NOT NULL,
    PRIMARY KEY (title_id, genre_id),
    FOREIGN KEY (title_id)
        REFERENCES anime_database.title (title_id),
    FOREIGN KEY (genre_id)
        REFERENCES anime_database.genre (genre_id)
);

------------------------------------------------------------------------------------------------------------------------

INSERT INTO anime_database.producer(producer_nm, producer_birth_dt, country)
VALUES ('Хаяо Миядзаки', '1941-01-05', 'Japan'),
       ('Ацуси Нисигори', '1978-09-14', 'Japan'),
       ('Соити Масуи', '1966-03-29', 'Japan'),
       ('Сюхэй Морита', '1978-06-22', 'Japan'),
       ('Тэцуро Араки', '1976-11-05', 'Japan'),
       ('Хаято Датэ', '1962-05-22', 'Japan'),
       ('Синъитиро Ватанабэ', '1965-05-24', 'Japan'),
       ('Сюн Кэ', '1983-01-06', 'China'),
       ('Сато Масако', '1999-05-07', 'Japan');

INSERT INTO anime_database.title(russian_title_nm, american_title_nm, producer_id, rating)
VALUES ('Ходячий замок', 'Walking Castle',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Хаяо Миядзаки'), '8.3'),
       ('Унесённые призраками', 'Spirited Away',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Хаяо Миядзаки'), '9.5'),
       ('Мой сосед Тоторо', 'My neighbor Totoro',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Хаяо Миядзаки'), '8.2'),
       ('Милый во Франксе', 'Darling in the Franxx',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Ацуси Нисигори'), '7.3'),
       ('Этот глупый свин не понимает мечту девочки зайки', 'Rascal Does Not Dream of Bunny Girl Senpai',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Соити Масуи'), '7.8'),
       ('Токийский гуль', 'Tokyo Ghoul',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Сюхэй Морита'), '7.2'),
       ('Тетрадь смерти', 'Death Note',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Тэцуро Араки'), '8.6'),
       ('Атака титанов', 'Attack on Titan',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Тэцуро Араки'), '8.6'),
       ('Наруто', 'Naruto',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Хаято Датэ'), '8.2'),
       ('Эхо террора', 'Zankyou no Terror',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Синъитиро Ватанабэ'), '8.0'),
       ('Аватар короля', 'The King’s Avatar',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Сюн Кэ'), '8.0'),
       ('Волейбол', 'Haikyuu!!',
        (SELECT producer_id FROM anime_database.producer WHERE producer_nm = 'Сато Масако'), '8.3');

INSERT INTO anime_database.genre(genre_nm)
VALUES ('Драма'),
       ('Комедия'),
       ('Триллер'),
       ('Фэнтези'),
       ('Мелодрама'),
       ('Приключения'),
       ('Романтика'),
       ('Ужасы'),
       ('Детектив'),
       ('Киберспорт'),
       ('Мистика');

INSERT INTO anime_database.genre_x_title(title_id, genre_id)
VALUES ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Ходячий замок'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Драма')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Ходячий замок'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Романтика')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Ходячий замок'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Приключения')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Унесённые призраками'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Приключения')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Унесённые призраками'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Детектив')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Унесённые призраками'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Фэнтези')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Мой сосед Тоторо'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Фэнтези')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Мой сосед Тоторо'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Приключения')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Милый во Франксе'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Романтика')),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Этот глупый свин не понимает мечту девочки зайки'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Романтика')),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Этот глупый свин не понимает мечту девочки зайки'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Комедия')),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Этот глупый свин не понимает мечту девочки зайки'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Мистика')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Токийский гуль'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Ужасы')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Токийский гуль'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Триллер')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Тетрадь смерти'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Триллер')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Тетрадь смерти'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Ужасы')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Тетрадь смерти'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Детектив')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Атака титанов'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Драма')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Атака титанов'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Мистика')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Наруто'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Приключения')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Наруто'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Комедия')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Наруто'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Триллер')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Наруто'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Драма')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Эхо террора'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Драма')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Эхо террора'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Триллер')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Аватар короля'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Киберспорт')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Аватар короля'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Приключения')),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Волейбол'),
        (SELECT genre_id FROM anime_database.genre WHERE genre_nm = 'Комедия'));

INSERT INTO anime_database.user(user_nm, country)
VALUES ('Костя', 'Россия'),
       ('Артём', '906 kpop room'),
       ('Гера', '422 anime room'),
       ('Антон', 'Казахстан');

INSERT INTO anime_database.review(title_id, user_id, rating)
VALUES ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Милый во Франксе'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Костя'), 8),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Токийский гуль'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Костя'), 9),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Тетрадь смерти'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Костя'), 9),
       ((SELECT title_id FROM anime_database.title WHERE russian_title_nm = 'Тетрадь смерти'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Артём'), 9),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Этот глупый свин не понимает мечту девочки зайки'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Костя'), 10),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Этот глупый свин не понимает мечту девочки зайки'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Артём'), 10),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Этот глупый свин не понимает мечту девочки зайки'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Антон'), 10),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Наруто'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Антон'), 7),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Наруто'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Гера'), 10),
       ((SELECT title_id
         FROM anime_database.title
         WHERE russian_title_nm = 'Токийский гуль'),
        (SELECT user_id FROM anime_database.user WHERE user_nm = 'Гера'), 8);

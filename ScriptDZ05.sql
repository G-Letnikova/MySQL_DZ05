USE vk;

-- 1. Создайте представление с произвольным SELECT-запросом из прошлых уроков

CREATE OR REPLACE VIEW comm AS
SELECT uc.community_id, c.name, count(*) 
FROM users_communities AS uc
JOIN communities c 
ON uc.community_id = c.id 
GROUP BY community_id  
ORDER BY community_id;

-- 2. Выведите данные, используя написанное представление 
SELECT * FROM comm;
SELECT name FROM comm;

-- 3. Удалите представление
DROP VIEW comm;

/* 4. Сколько новостей (записей в таблице media) у каждого пользователя? 
Вывести поля: news_count (количество новостей), user_id (номер пользователя), user_email (email пользователя). 
Попробовать решить с помощью CTE или с помощью обычного JOIN
*/

-- с помощью обычного JOIN
SELECT  count(*) `news_count`, u.id `user_id`, u.email `user_email`
FROM users AS u
JOIN media AS m 
ON u.id = m.user_id
GROUP BY u.id
ORDER BY news_count DESC;

-- с помощью CTE
WITH media_count AS (
SELECT  count(*) `news_count`, u.id `user_id`, u.email `user_email`
FROM users AS u
JOIN media AS m 
ON u.id = m.user_id
GROUP BY u.id
ORDER BY news_count DESC
)

-- Используем media_count;
SELECT * FROM media_count
WHERE news_count > 1;
USE lab-mysql-first-queries
SELECT *
FROM applestore2;

-- 1. Which are the different genres?
SELECT DISTINCT prime_genre
FROM applestore2;

-- 2. Which is the genre with more apps rated?
SELECT prime_genre, SUM(rating_count_tot) AS total_ratings
FROM applestore2
GROUP BY prime_genre
ORDER BY total_ratings DESC
LIMIT 1;

-- 3. Which is the genre with more apps?
SELECT prime_genre, COUNT(*) AS app_count
FROM applestore2
GROUP BY prime_genre
ORDER BY app_count DESC
LIMIT 1;

-- 4. Which is the one with less?
SELECT prime_genre, COUNT(*) AS app_count
FROM applestore2
GROUP BY prime_genre
ORDER BY app_count ASC
LIMIT 1;

-- 5. Take the 10 apps most rated.
SELECT *
FROM applestore2
ORDER BY rating_count_tot DESC
LIMIT 10;

-- 6. Take the 10 apps best rated by users.
SELECT *
FROM applestore2
ORDER BY user_rating DESC
LIMIT 10;

-- 7. Take a look on the data you retrieved in the question 5. Give some insights.
-- The 10 most rated app are all free. 
-- Games are the most common genre among the top-rated apps, 
-- indicating high user satisfaction in this category. 
-- There are 4 games in the top 10, which highlights the popularity  of gaming apps

-- 8. Take a look on the data you retrieved in the question 6. Give some insights.
-- Games are highly represented, with 5 out of the top 10 apps belonging to this genre. 
-- This suggests that high-quality game apps tend to receive high ratings from users.
-- Most of the apps are not free, indicating that users are willing to pay for apps they find valuable.

-- 9. Now compare the data from questions 5 and 6. What do you see?
-- The best-rated apps generally have fewer ratings compared to the most-rated apps. 
-- This suggests that while an app may have a high average rating, it doesn't necessarily need a very large number of ratings to be considered highly rated.
-- Conversely, the most-rated apps may have slightly lower average ratings, indicating that as the number of ratings increases, 
-- the average rating may become more moderate.
-- Games are prominent in both lists, which indicates that gaming apps tend to attract both a high number of ratings and high average ratings. 
-- This genre is consistently popular and well-received.

-- 10. How could you take the top 3 regarding the user ratings but also the number of votes?
SELECT 
    track_name,
    prime_genre,
    user_rating,
    rating_count_tot,
    price,
    -- Normalize ratings and rating count, and calculate combined score
    (user_rating / (SELECT MAX(user_rating) FROM applestore2) + rating_count_tot / (SELECT MAX(rating_count_tot) FROM applestore2)) AS combined_score
FROM applestore2
ORDER BY combined_score DESC
LIMIT 3;

-- 11. Does people care about the price? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
SELECT price, COUNT(*) AS app_count
FROM applestore2
GROUP BY price
ORDER BY price;
-- The majority of apps are free, with the number of apps decreasing as the price increases. 
-- This suggests that it is more interesting to release free apps to attract a larger user base.

SELECT 
    CASE 
        WHEN price = 0 THEN 'Free'
        ELSE 'Paid'
    END AS price_category,
    AVG(rating_count_tot) AS avg_rating_count
FROM applestore2
GROUP BY price_category
ORDER BY avg_rating_count DESC;
-- Free apps tend to have more ratings on average compared to paid apps. This could be because free apps have a lower barrier to entry, 
-- attracting more users who are then more likely to leave ratings.

SELECT 
    CASE 
        WHEN price = 0 THEN 'Free'
        ELSE 'Paid'
    END AS price_category,
    AVG(user_rating) AS avg_rating
FROM applestore2
GROUP BY price_category
ORDER BY avg_rating DESC;
-- Paid apps have a slightly higher user rating compared to free apps. This may indicate that users perceive paid apps as higher quality 
-- or that paid apps provide better value for money.

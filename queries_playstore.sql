-- Comments in SQL Start with dash-dash --

-- 1. Find the app with an ID of 1880

SELECT * FROM analytics
WHERE id=1880;
-- id  |        app_name         |   category   | rating | reviews |        size        | min_installs | price | content_rating |     genres     | last_updated | current_version |  android_version   
-- ------+-------------------------+--------------+--------+---------+--------------------+--------------+-------+----------------+----------------+--------------+-----------------+--------------------
--  1880 | Web Browser for Android | PRODUCTIVITY |    4.3 |  144879 | Varies with device |     10000000 |     0 | Everyone       | {Productivity} | 2016-01-24   | 3.5.0           | Varies with device
-- (1 row)

-- 2. Find the ID and app name for all apps that were last updated on August 01, 2018.

SELECT * FROM analytics
WHERE last_updated='2018-07-01';
--   id  |                       app_name                       |      category      | rating | reviews | size | min_installs | price  | content_rating |        genres        | last_updated | current_version | android_version 
-- ------+------------------------------------------------------+--------------------
--   753 | Wifi Analyzer                                        | TOOLS              |    4.6 |  894435 | 3.1M |     50000000 |      0 | Teen           | {Tools}              | 2018-07-01   | 2.2.8           | 4.0 and up
--  1102 | Pocket Mortys                                        | GAME               |    4.4 |  452589 | 99M  |     10000000 |      0 | Mature 17+     | {Action}             | 2018-07-01   | 2.2             | 4.0 and up
--  1854 | Memorado - Brain Games                               | SHOPPING           |    4.3 |  151095 | 12M  |      5000000 |      0 | Mature 17+     | {Shopping}           | 2018-07-01   | 4.0.13          | 4.1 and up

-- 3. Count the number of apps in each category, e.g. “Family | 1972”.


SELECT category,COUNT(*) AS total_apps FROM analytics
GROUP BY category;
--       category       | total_apps 
-- ---------------------+------------
--  BOOKS_AND_REFERENCE |        191
--  COMMUNICATION       |        342
--  BEAUTY              |         46
--  EVENTS              |         52
--  PARENTING           |         59
--  PHOTOGRAPHY         |        313
--  GAME                |       1110
--  BUSINESS            |        313
--  SOCIAL              |        269
--  MEDICAL             |        350
--  TOOLS               |        753
--  TRAVEL_AND_LOCAL    |        234
--  ART_AND_DESIGN      |         63
--  LIFESTYLE           |        319
--  WEATHER             |         79
--  COMICS              |         59
--  PRODUCTIVITY        |        360
--  PERSONALIZATION     |        329
--  FINANCE             |        331
--  SPORTS              |        338
--  ENTERTAINMENT       |        149
--  NEWS_AND_MAGAZINES  |        249
--  HOUSE_AND_HOME      |         82
--  SHOPPING            |        241
--  DATING              |        204
--  HEALTH_AND_FITNESS  |        298
--  EDUCATION           |        156
--  MAPS_AND_NAVIGATION |        129
--  LIBRARIES_AND_DEMO  |         80
--  FOOD_AND_DRINK      |        110
--  FAMILY              |       1789
--  VIDEO_PLAYERS       |        165
--  AUTO_AND_VEHICLES   |         75
-- (33 rows)

-- 4. Find the top 5 most-reviewed apps and the number of reviews for each.

SELECT app_name,reviews
FROM analytics
ORDER BY reviews DESC
Limit 5;
--                  app_name                 | reviews  
-- ------------------------------------------+----------
--  Facebook                                 | 78158306
--  WhatsApp Messenger                       | 78128208
--  Instagram                                | 69119316
--  Messenger – Text and Video Chat for Free | 69119316
--  Clash of Clans                           | 69109672
-- (5 rows)


-- 5. Find the app that has the most reviews with a rating greater than equal to 4.8.

SELECT app_name,rating,reviews
FROM analytics
WHERE rating>=4.8
ORDER BY reviews DESC;
--                                             app_name                                             | rating | reviews 
-- -------------------------------------------------------------------------------------------------+--------+---------
--  Chess Free                                                                                      |    4.8 | 4559407
--  Basketball Stars                                                                                |    4.8 | 2588730
--  Kill Shot Bravo: Sniper FPS                                                                     |    4.8 | 1506783
--  Mobile Security: Antivirus, Web Scan & App Lock                                                 |    4.8 | 1499466

-- 6. Find the average rating for each category ordered by the highest rated to lowest rated.

SELECT category, AVG(rating) AS average_rating
FROM analytics
GROUP BY category
ORDER BY average_rating DESC;

--       category       |   average_rating   
-- ---------------------+--------------------
--  EVENTS              |  4.395238104320708
--  EDUCATION           |   4.38903223006956
--  ART_AND_DESIGN      |  4.347540949211746
--  BOOKS_AND_REFERENCE | 4.3423728633061645

-- 7. Find the name, price, and rating of the most expensive app with a rating that’s less than 3.

SELECT  app_name,price, rating 
FROM analytics
WHERE rating < 3
ORDER BY price DESC
LIMIT 1;

--       app_name      | price  | rating 
-- --------------------+--------+--------
--  Naruto & Boruto FR | 379.99 |    2.9
-- (1 row)

-- 8. Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first.


SELECT *
FROM analytics
WHERE min_installs < 50
  AND rating IS NOT NULL
ORDER BY rating DESC;
--   id  |                    app_name                    |      category       | rating | reviews | size | min_installs | price | content_rating |        genres         | last_updated | current_version | android_version 
-- ------+------------------------------------------------+---------------------+--------+---------+------+--------------+-------+----------------+-----------------------+--------------+-----------------+-----------------
--  8553 | Radio FG Paris Underground                     | SOCIAL              |      5 |      20 | 4.2M |           10 |     0 | Teen           | {Social}              | 2018-07-23   | 1               | 4.0 and up
--  8926 | My CW                                          | GAME                |      5 |      11 | 6.1M |           10 |     0 | Everyone       | {Arcade}              | 2017-03-11   | 0.1             | 2.3 and up
--  9115 | Q Actions - Digital Assistant    


-- 9. Find the names of all apps that are rated less than 3 with at least 10000 reviews.

SELECT app_name
FROM analytics
WHERE rating < 3
  AND reviews>=10000;

--                     app_name                     
-- -------------------------------------------------
--  The Wall Street Journal: Business & Market News
--  Vikings: an Archer’s Journey
--  Shoot Em Down Free
-- (3 rows)

-- 10. Find the top 10 most-reviewed apps that cost between 10 cents and a dollar.

SELECT app_name
FROM analytics
WHERE price BETWEEN 0.10 AND 1.00
ORDER BY reviews DESC

-- playstore-# ;
--                       app_name                      
-- ----------------------------------------------------
--  Free Slideshow Maker & Video Editor
--  Couple - Relationship App
--  Anime X Wallpaper
--  Dance On Mobile
--  Marvel Unlimited
--  FastMeet: Chat, Dating, Love
--  IHG®: Hotel Deals & Rewards
--  Live Weather & Daily Local Weather Forecast
--  DreamMapper
--  Můj T-Mobile Business
--  Secret Codes For Android
--  My Earthquake Alerts - US & Worldwide Earthquakes
--  Silence Premium Do Not Disturb
--  Masha and the Bear: Climb Racing and Car Games
--  Ultimate DC Challenge
--  energyly (TNEB,BESCOM,MH,DL..)
--  Ring


-- 11. Find the most out of date app. Hint: You don’t need to do it this way, but it’s possible to do with a subquery: http://www.postgresqltutorial.com/postgresql-max-function/

SELECT app_name,last_updated
FROM analytics WHERE last_updated=(SELECT MIN(last_updated) FROM analytics);
--   app_name  | last_updated 
-- ------------+--------------
--  CP Clicker | 2010-05-21
-- (1 row)

-- 12. Find the most expensive app (the query is very similar to #11).
SELECT app_name,price
FROM analytics
WHERE price=(SELECT MAX(price) FROM analytics);

--       app_name      | price 
-- --------------------+-------
--  Cardi B Piano Game |   400
-- (1 row)

-- 13. Count all the reviews in the Google Play Store.

SELECT SUM(reviews) AS total_reviews
FROM analytics;

--  total_reviews 
-- ---------------
--     4814575866
-- (1 row)


-- 14. Find all the categories that have more than 300 apps in them.

SELECT category, COUNT(*) AS total_apps
FROM analytics
GROUP BY category
HAVING COUNT(*) > 300;
--     category     | total_apps 
-- -----------------+------------
--  COMMUNICATION   |        342
--  PHOTOGRAPHY     |        313
--  GAME            |       1110
--  BUSINESS        |        313
--  MEDICAL         |        350
--  TOOLS           |        753
--  LIFESTYLE       |        319
--  PRODUCTIVITY    |        360
--  PERSONALIZATION |        329
--  FINANCE         |        331
--  SPORTS          |        338
--  FAMILY          |       1789
-- (12 rows)

-- 15. Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion.


SELECT 
  app_name,
  reviews,
  min_installs,
  (min_installs::float / reviews) AS proportion
FROM analytics
WHERE min_installs >= 100000
  AND reviews > 0
ORDER BY proportion DESC
LIMIT 1;
--      app_name     | reviews | min_installs |     proportion     
-- ------------------+---------+--------------+--------------------
--  Kim Bu Youtuber? |      66 |     10000000 | 151515.15151515152
-- (1 row)



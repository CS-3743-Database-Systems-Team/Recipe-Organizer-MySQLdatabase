-- List restaurants ordered by their rating (highest to lowest)
SELECT 
    restaurant_id,
    name,
    city,
    state,
    rating
FROM
    Restaurants
ORDER BY
    rating DESC;
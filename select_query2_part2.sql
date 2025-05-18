-- Query 2: List all restaurants offering a specific recipe and its price
-- This query helps us view which restaurants serve a specific recipe

SELECT
    r.name AS restaurant_name,
    rm.price,
    re.title AS recipe_name
FROM
    RestaurantsMenus rm
JOIN
    Restaurants r ON rm.restaurant_id = r.restaurant_id
JOIN
    Recipes re ON rm.recipe_id = re.recipe_id
WHERE
    re.title = 'Spaghetti Bolognese';


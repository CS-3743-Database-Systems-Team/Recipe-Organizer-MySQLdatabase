-- Show recipes with their average rating, ordered by rating, ordered from highest to lowest
SELECT 
    r.recipe_id, r.recipe_name, 
    ROUND(AVG(ur.rating), 2) AS average_rating
FROM 
    Recipes r
JOIN
    User_ratings ur ON r.recipe_id = ur.recipe_id
GROUP BY
    r.recipe_id, r.title
ORDER BY
    average_rating DESC;
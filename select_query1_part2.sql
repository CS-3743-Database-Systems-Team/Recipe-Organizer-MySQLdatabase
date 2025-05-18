-- Query 1: list all recipes with their cooking time and difficulty
-- This query helps us view the cooking time and difficulty of all recipes in the database

SELECT
    title,
    cooking_time,
    difficulty
FROM
    Recipes;
CREATE TABLE IF NOT EXISTS RestaurantMenus (
 `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `restaurant_id` int NOT NULL,
 `recipe_id` int NOT NULL,
 `price` decimal(5,2) NOT NULL
) COMMENT 'Links restaurants to recipes they offer as menu items, along with pricing.';

CREATE TABLE IF NOT EXISTS Users (
 `user_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `username` varchar(500) NOT NULL,
 `email` varchar(500) NOT NULL UNIQUE,
 `password_hash` varchar(500) NOT NULL,
 `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) COMMENT 'This table stores user account details.';

CREATE TABLE IF NOT EXISTS UserRatings (
 `rating_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `recipe_id` int NOT NULL,
 `user_id` int NOT NULL,
 `rating` tinyint NOT NULL,
 `review_text` text DEFAULT NULL,
 `rating_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) COMMENT 'Holds user ratings and optional reviews for recipes.';

CREATE TABLE IF NOT EXISTS Instructions (
 `instruction_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `recipe_id` int NOT NULL,
 `step_number` int NOT NULL,
 `instruction_text` text DEFAULT NULL
) COMMENT 'Stores the step-by-step instructions for each recipe.';

CREATE TABLE IF NOT EXISTS RecipeIngredients (
 `recipe_id` int NOT NULL,
 `ingredient_id` int NOT NULL,
 `quantity` decimal(5,2) NOT NULL,
 PRIMARY KEY (`recipe_id`, `ingredient_id`)
) COMMENT 'A join table that links recipes to their ingredients, along with the required quantity.';

CREATE TABLE IF NOT EXISTS Restaurants (
 `restaurant_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name` varchar(500) NOT NULL,
 `address` varchar(500) NOT NULL,
 `city` varchar(500) NOT NULL,
 `state` varchar(500) NOT NULL,
 `zip_code` varchar(500) NOT NULL,
 `phone` varchar(500) NOT NULL,
 `rating` decimal(3,2) NOT NULL
) COMMENT 'Contains data about restaurants that may offer recipes or menu items.';

CREATE TABLE IF NOT EXISTS Recipes (
 `recipe_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `title` varchar(500) NOT NULL,
 `discription` text DEFAULT NULL,
 `category` varchar(500) NOT NULL,
 `cuisine` varchar(500) NOT NULL,
 `cooking_time` int NOT NULL,
 `difficulty` enum('easy', 'medium', 'hard') DEFAULT NULL,
 `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Stores basic recipe information.';

CREATE INDEX index_1 ON Recipes (`title`);

ALTER TABLE Instructions ADD CONSTRAINT fk_instructions_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE RecipeIngredients ADD CONSTRAINT fk_recipeingredients_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE RecipeIngredients ADD CONSTRAINT fk_recipeingredients_ingredients FOREIGN KEY (`ingredient_id`) REFERENCES Ingredients (`ingredient_id`) ON DELETE CASCADE;
ALTER TABLE RestaurantMenus ADD CONSTRAINT fk_restaurantmenus_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE RestaurantMenus ADD CONSTRAINT fk_restaurantmenus_restaurants FOREIGN KEY (`restaurant_id`) REFERENCES Restaurants (`restaurant_id`) ON DELETE CASCADE;
ALTER TABLE UserRatings ADD CONSTRAINT fk_userratings_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE UserRatings ADD CONSTRAINT fk_userratings_users FOREIGN KEY (`user_id`) REFERENCES Users (`user_id`) ON DELETE CASCADE;

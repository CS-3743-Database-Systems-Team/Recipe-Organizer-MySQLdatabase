-- ================================================
-- Database Definition File for Recipe Management DB
-- ================================================

-- Drop existing tables to ensure a clean slate
DROP TABLE IF EXISTS UserRatings;
DROP TABLE IF EXISTS RestaurantMenus;
DROP TABLE IF EXISTS RecipeIngredients;
DROP TABLE IF EXISTS Instructions;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Ingredients;

-- ================================================
-- Table: Ingredients
-- ================================================
CREATE TABLE IF NOT EXISTS Ingredients (
    ingredient_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
) COMMENT 'Stores individual ingredients available for recipes.';

-- ================================================
-- Table: Recipes
-- ================================================
CREATE TABLE IF NOT EXISTS Recipes (
    recipe_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    discription TEXT DEFAULT NULL,
    category VARCHAR(500) NOT NULL,
    cuisine VARCHAR(500) NOT NULL,
    cooking_time INT NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Stores basic recipe information.';

CREATE INDEX index_1 ON Recipes (`title`);

-- ================================================
-- Table: Restaurants
-- ================================================
CREATE TABLE IF NOT EXISTS Restaurants (
    restaurant_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(500) NOT NULL,
    address VARCHAR(500) NOT NULL,
    city VARCHAR(500) NOT NULL,
    state VARCHAR(500) NOT NULL,
    zip_code VARCHAR(500) NOT NULL,
    phone VARCHAR(500) NOT NULL,
    rating DECIMAL(3,2) NOT NULL
) COMMENT 'Contains data about restaurants that may offer recipes or menu items.';

-- ================================================
-- Table: Users
-- ================================================
CREATE TABLE IF NOT EXISTS Users (
    user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(500) NOT NULL,
    email VARCHAR(500) NOT NULL UNIQUE,
    password_hash VARCHAR(500) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) COMMENT 'This table stores user account details.';

-- ================================================
-- Table: Instructions
-- ================================================
CREATE TABLE IF NOT EXISTS Instructions (
    instruction_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    step_number INT NOT NULL,
    instruction_text TEXT DEFAULT NULL
) COMMENT 'Stores the step-by-step instructions for each recipe.';

-- ================================================
-- Table: RecipeIngredients
-- ================================================
CREATE TABLE IF NOT EXISTS RecipeIngredients (
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id)
) COMMENT 'A join table that links recipes to their ingredients, along with the required quantity.';

-- ================================================
-- Table: RestaurantMenus
-- ================================================
CREATE TABLE IF NOT EXISTS RestaurantMenus (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    recipe_id INT NOT NULL,
    price DECIMAL(5,2) NOT NULL
) COMMENT 'Links restaurants to recipes they offer as menu items, along with pricing.';

-- ================================================
-- Table: UserRatings
-- ================================================
CREATE TABLE IF NOT EXISTS UserRatings (
    rating_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    user_id INT NOT NULL,
    rating TINYINT NOT NULL,
    review_text TEXT DEFAULT NULL,
    rating_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) COMMENT 'Holds user ratings and optional reviews for recipes.';


-- ================================================
-- Table: Foreign Key Constraints
-- ================================================
ALTER TABLE Instructions ADD CONSTRAINT fk_instructions_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE RecipeIngredients ADD CONSTRAINT fk_recipeingredients_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE RecipeIngredients ADD CONSTRAINT fk_recipeingredients_ingredients FOREIGN KEY (`ingredient_id`) REFERENCES Ingredients (`ingredient_id`) ON DELETE CASCADE;
ALTER TABLE RestaurantMenus ADD CONSTRAINT fk_restaurantmenus_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE RestaurantMenus ADD CONSTRAINT fk_restaurantmenus_restaurants FOREIGN KEY (`restaurant_id`) REFERENCES Restaurants (`restaurant_id`) ON DELETE CASCADE;
ALTER TABLE UserRatings ADD CONSTRAINT fk_userratings_recipes FOREIGN KEY (`recipe_id`) REFERENCES Recipes (`recipe_id`) ON DELETE CASCADE;
ALTER TABLE UserRatings ADD CONSTRAINT fk_userratings_users FOREIGN KEY (`user_id`) REFERENCES Users (`user_id`) ON DELETE CASCADE;

-- ================================================
-- Data Insertion
-- ================================================

-- RestaruantMenus
INSERT INTO RestaurantMenus (restaurant_id, recipe_id, price) VALUES
(1, 1, 12.99),
(2, 2, 15.50),
(3, 3, 10.00),
(4, 4, 20.00),
(5, 5, 8.50);

-- Users
INSERT INTO Users (username, email, password_hash) VALUES
('john_doe', 'jondoe@example.com', 'hashed_password_1'),
('jane_smith', 'janesmith@example.com', 'hashed_password_2'),
('alice_jones', 'alicejones@example.com', 'hashed_password_3'),
('bob_brown', 'bobbrown@example.com', 'hashed_password_4'),
('charlie_black', 'charlieblack.example.com', 'hashed_password_5');

-- UserRatings
INSERT INTO UserRatings (recipe_id, user_id, rating, review_text) VALUES
(1, 1, 5, 'Absolutely loved this recipe!'),
(2, 2, 4, 'Very good but could use more spices.'),
(3, 3, 3, 'It was okay, nothing special.'),
(4, 4, 2, 'Did not like it at all.'),
(5, 5, 1, 'Terrible recipe! Would not recommend.');

(1, 2, 5, 'Best recipe ever!'),
(2, 3, 4, 'Tasty and easy to make.'),
(3, 4, 3, 'Average recipe.'),
(4, 5, 2, 'Not my favorite.'),
(5, 1, 1, 'Did not enjoy this at all.');

-- Instructions
INSERT INTO Instructions (recipe_id, step_number, instruction_text) VALUES
(1, 1, 'Preheat the oven to 350 degrees F.'),
(1, 2, 'Mix all ingredients in a bowl.'),
(1, 3, 'Pour into a baking dish and bake for 30 minutes.'),
(2, 1, 'Chop vegetables and set aside.'),
(2, 2, 'Heat oil in a pan and sauté vegetables.'),
(2, 3, 'Add spices and cook for another 5 minutes.');    
(3, 1, 'Boil water in a pot.'),
(3, 2, 'Add pasta and cook until al dente.'),
(3, 3, 'Drain and mix with sauce.'),
(4, 1, 'Grill chicken on medium heat.'),
(4, 2, 'Season with salt and pepper.'),
(4, 3, 'Cook for 6-7 minutes on each side.'),
(5, 1, 'Blend all ingredients in a blender.'),
(5, 2, 'Serve chilled with ice.');

-- RecipeIngredients
INSERT INTO RecipeIngredients (recipe_id, ingredient_id, quantity) VALUES
(1, 1, 2.5),
(1, 2, 1.0),
(1, 3, 0.5),
(2, 4, 3.0),
(2, 5, 1.5),
(3, 6, 200.0),
(3, 7, 50.0),
(4, 8, 4.0),
(4, 9, 2.0),
(5, 10, 1.0);

-- restaurants
INSERT INTO Restaurants (name, address, city, state, zip_code, phone, rating) VALUES
('Pasta Palace', '123 Noodle St', 'Pasta City', 'NY', '10001', '555-1234', 4.5),
('Burger Barn', '456 Burger Ave', 'Burger Town', 'CA', '90001', '555-5678', 4.0),
('Sushi Spot', '789 Sushi Rd', 'Sushi City', 'WA', '98001', '555-8765', 4.8),
('Taco Town', '321 Taco Blvd', 'Taco City', 'TX', '73301', '555-4321', 3.9),
('Pizza Place', '654 Pizza Ln', 'Pizza Town', 'FL', '33101', '555-6789', 4.2);

-- recipes
INSERT INTO Recipes (title, discription, category, cuisine, cooking_time, difficulty) VALUES
('Spaghetti Bolognese', 'A classic Italian pasta dish with a rich meat sauce.', 'Pasta', 'Italian', 30, 'medium'),
('Chicken Curry', 'A spicy and flavorful chicken dish.', 'Curry', 'Indian', 45, 'hard'),
('Caesar Salad', 'A fresh salad with romaine lettuce and Caesar dressing.', 'Salad', 'American', 15, 'easy'),
('Beef Tacos', 'Tasty tacos filled with seasoned beef and toppings.', 'Tacos', 'Mexican', 20, 'easy'),
('Chocolate Cake', 'A rich and moist chocolate cake.', 'Dessert', 'American', 60, 'hard');

-- ================================================
-- End of script
-- ================================================

CREATE DATABASE IF NOT EXISTS restaraunt DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE restaraunt;

DROP TABLE IF EXISTS Dishes;
CREATE TABLE IF NOT EXISTS Dishes (
    DishID INT UNSIGNED NOT NULL, DName varchar (50), DCalories float,  Price float, Popularity int, Image varchar (90)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Ingredients;
CREATE TABLE IF NOT EXISTS Ingredients(
    IngredientID INT UNSIGNED NOT NULL, IName varchar(50), Type varchar(50), ICals float, Quantity FLOAT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Merchant;
CREATE TABLE IF NOT EXISTS Merchant(
    MerchID INT UNSIGNED NOT NULL, MName varchar(50)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS MadeOf;
CREATE TABLE IF NOT EXISTS MadeOf(
    DishID INT UNSIGNED NOT NULL,
    IngredientId INT UNSIGNED NOT NULL,
	OuncesNeeded FLOAT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer (
  Name varchar(20) NOT NULL,
  cust_ID INT UNSIGNED NOT NULL,
  Age int(99) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS contains_dishes;
CREATE TABLE IF NOT EXISTS contains_dishes(
    DishID INT UNSIGNED NOT NULL,
    cust_ID INT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS table_num;
CREATE TABLE IF NOT EXISTS table_num(
  table_id INT UNSIGNED NOT NULL,
  cust_ID INT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS table_info;
CREATE TABLE IF NOT EXISTS table_info(
  table_id INT UNSIGNED NOT NULL,
  table_compacity INT UNSIGNED NOT NULL,
  table_Current INT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS reviews;
CREATE TABLE IF NOT EXISTS reviews(
	DishID INT UNSIGNED NOT NULL,
	cust_ID INT UNSIGNED NOT NULL,
	time_day DATETIME NOT NULL,
	rating INT DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Servers;
CREATE TABLE IF NOT EXISTS Servers(
  serverID INT UNSIGNED NOT NULL,
  name varchar(50),
  timeOrdered varchar(50),
  table_id int
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS ordersFrom;
CREATE TABLE IF NOT EXISTS ordersFrom(
  TimeFin DATETIME DEFAULT NULL,
  TimeServed DATETIME DEFAULT NULL,
  table_id INT UNSIGNED NOT NULL,
  serverID INT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Drinks;
CREATE TABLE IF NOT EXISTS Drinks(
  drinkID int NOT NULL,
  price float NOT NULL,
  name varchar(50),
  avail int NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS contains_Drinks;
  CREATE TABLE IF NOT EXISTS contains_Drinks(
  drinkID INT UNSIGNED NOT NULL,
  cust_ID INT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS MadeOfDrink;
CREATE TABLE IF NOT EXISTS MadeOfDrink(
    drinkID INT UNSIGNED NOT NULL,
    IngredientId INT UNSIGNED NOT NULL,
	OuncesNeeded FLOAT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE Dishes 
MODIFY COLUMN DishID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (DishID);

ALTER TABLE Ingredients 
MODIFY COLUMN IngredientID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (IngredientID);

ALTER TABLE Merchant 
MODIFY COLUMN MerchID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (MerchID);

ALTER TABLE MadeOf 
ADD CONSTRAINT FK_MadeOfDishId
FOREIGN KEY(DishID)
REFERENCES Dishes(DishID);

ALTER TABLE MadeOf 
ADD CONSTRAINT FK_MadeOfIngredientId
FOREIGN KEY(IngredientID) 
REFERENCES Ingredients(IngredientID);

ALTER TABLE MadeOf
ADD PRIMARY KEY (DishID, IngredientID);

ALTER TABLE customer
MODIFY COLUMN cust_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (cust_ID);
 
ALTER TABLE contains_dishes 
ADD FOREIGN KEY(DishID)
REFERENCES Dishes(DishID);

ALTER TABLE contains_dishes 
ADD FOREIGN KEY(cust_ID)
REFERENCES customer(cust_ID);

ALTER TABLE contains_dishes
ADD PRIMARY KEY (DishID, cust_ID);

ALTER TABLE table_info
ADD PRIMARY KEY (table_id);

ALTER TABLE table_num 
ADD FOREIGN KEY(cust_ID)
REFERENCES customer(cust_ID);



ALTER TABLE table_num
ADD FOREIGN KEY(table_id)
REFERENCES table_info(table_id);

ALTER TABLE table_num
ADD PRIMARY KEY (table_id, cust_ID);



ALTER TABLE reviews 
ADD FOREIGN KEY(DishID)
REFERENCES Dishes(DishID);

ALTER TABLE reviews
ADD FOREIGN KEY(cust_ID)
REFERENCES customer(cust_ID);

ALTER TABLE reviews
ADD PRIMARY KEY (DishID, cust_ID, rating);

ALTER TABLE Servers
MODIFY COLUMN serverID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(serverID);

ALTER TABLE ordersFrom
ADD FOREIGN KEY(table_id)
REFERENCES table_info(table_id);

ALTER TABLE ordersFrom
ADD PRIMARY KEY(table_id);

ALTER TABLE Drinks
MODIFY COLUMN drinkID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(drinkID);

ALTER TABLE contains_Drinks 
ADD FOREIGN KEY(cust_ID)
REFERENCES customer(cust_ID);

ALTER TABLE contains_Drinks
ADD FOREIGN KEY(drinkID)
REFERENCES Drinks(drinkID);

ALTER TABLE contains_Drinks
ADD PRIMARY KEY(cust_ID,drinkID);

ALTER TABLE MadeOfDrink 
ADD CONSTRAINT FK_MadeOfDrinkId
FOREIGN KEY(drinkID)
REFERENCES Drinks(DrinkID);

ALTER TABLE MadeOfDrink
ADD CONSTRAINT FK_MadeOfDrinkIngredientId
FOREIGN KEY(IngredientID) 
REFERENCES Ingredients(IngredientID);

ALTER TABLE MadeOfDrink
ADD PRIMARY KEY (drinkID, IngredientID);



INSERT INTO Dishes(Dname, DCalories, Price, Popularity, Image)
VALUES ( 'Chicken Provolone', 236, 27.99,5, 'chickenProvolone.PNG'),
('Ricotta Cavatelli', 150, 28.99, 5, 'ricottaCavatelli.PNG'),
('Bellini', 292, 24.99, 4, 'peachesInfusedBellini.PNG'),
('Chicken Parm', 478, 25.99, 5, 'chickParm.PNG'),
('Spaghetti And Meatball', 280, 34.99, 2, 'spaghettiAndMeatball.PNG'),
('Lasagna', 150, 27.99, 4, 'lasagna.PNG'),
('Fettuccini Alfredo', 669, 16.99, 3, 'fettucciniAlfredo.PNG'),
('Parmesan Risotto', 1200, 22.99, 4, 'parmesanRisotto.PNG'),
('Pizza Margherita', 150, 23.99, 5, 'pizzaMarg.PNG'),
('Vegan Garlic Pasta with Roasted Tomatoes', 187, 23.99, 3, 'veganDish.PNG');

INSERT INTO table_info(table_id, table_compacity, table_Current)
VALUES (1, 5, 3),
(2, 5, 0),
(3, 5, 0),
(4, 5, 0),
(5, 5, 0),
(6, 7, 0),
(7, 7, 0),
(8, 7, 0),
(9, 7, 0),
(10, 10, 0),
(11, 10, 0),
(12, 2, 0);

INSERT INTO Ingredients(IName, Type, ICals, Quantity)
VALUES
('Flour', 'Grain', 17, 100),
('Ricotta', 'Dairy', 214, 100),
('Salt', 'Spice', 100, 20),
('Panco Bread Crumbs', 'Grain', 130, 100),
('Garlic Powder', 'Spice', 365, 100),
('Parmesan', 'Dairy', 35, 100),
('Egg', 'Meat', 30, 100),
('Chicken', 'Meat', 35, 80),
('Pepper', 'Spice', 85, 100),
('Vegatable Oil', 'Oil', 100, 200),
('Mozzarella', 'Dairy', 30, 100),
('Olive Oil', 'Oil', 33, 200),
('Onion', 'Veg', 77, 100),
('Garlic', 'Veg', 33, 100),
('Tomatoe', 'Veg', 33, 100),
('Water', 'Liquid', 0, 1000),
('Red Pepper Flake', 'Spice', 33, 100),
('Parsley', 'Spice', 33, 100),
('Spaghetti', 'Gluten', 33, 100),
('Ground Beef', 'Meat', 33, 100),
('Bay Leaf', 'Spice', 33, 100),
('Pasta Sauce', 'Veg', 33, 100),
('Lasagna Noodle', 'Grain', 33, 100),
('Unsalted Butter', 'Dairy', 33, 100),
('Fet Noodles', 'Grain', 33, 100),
('Alfredo Sauce', 'Dairy', 33, 100),
('Sweet Potatoe Mash', 'Veg', 33, 100),
('Millet Flour', 'Grain', 33, 100),
('Almond Flour', 'Grain', 33, 100),
('Tapioca Starch', 'Carbs', 33, 100),
('Herbs', 'Spice', 33, 100),
('Arborio Rice', 'Grain', 33, 100),
('Chicken Stock', 'Sauce', 33, 100),
('White Wine', 'Sauce', 33, 100),
('Peas', 'Veg', 33, 100),
('Pizza Dough', 'Grain', 33, 100),
('Semolina', 'Grain', 33, 100),
('Pizza Sauce', 'Veg', 33, 100),
('Basil', 'Spice', 33, 100),
('Grape Tomatoe', 'Veg', 33, 100),
('Whole Wheat Pasta', 'Grain', 33, 100),
('Medium Shallots', 'Veg', 33, 100),
('Unsweetened Almond Milk', 'Liquid', 33, 80),
('Prosciutto', 'Dairy', 33, 80),
('Provolone', 'Dairy', 33, 80),
('Carbonated Water', 'Liquid', 33, 100),
('Caremel Color', 'Liquid', 33, 100),
('Aspartame', 'Artificial', 33, 100),
('Phosphoric Acid', 'Artificial', 33, 100),
('Potassium Benzoate', 'Artificial', 33, 100),
('Natural Flavors', 'Artificial', 33, 100),
('Citric Acid', 'Artificial', 33, 100),
('Caffeine', 'Stimulant', 33, 100),
('Sodium Benzoate', 'Artificial', 33, 100),
('Fructose Corn Syrup', 'Sauce', 33, 100),
('Sucrose', 'Artificial', 33, 100),
('Sodium Bicarbonate', 'Artificial', 33, 100),
('Sodium Citrate', 'Artificial', 33, 100),
('Potasium Sulfate', 'Artificial', 33, 100),
('Disodium Phosphate', 'Artificial', 33, 100),
('Sugar', 'Veg', 33, 100),
('Prosecco', 'Sauce', 33, 100),
('Peaches', 'Fruit', 33, 100);


INSERT INTO Drinks(drinkID, price, name, avail) VALUES
(10001, 2.99, 'Dr. Pepper', 100),
(10002, 2.99, 'Coke', 100),
(10003, 2.99, 'Diet Coke', 100),
(10004, 3.50, 'Club Soda', 100),
(10005, 0.00, 'Water', 1000),
(10006, 2.99, 'Sprite', 100);

INSERT INTO Servers(serverID, name, timeOrdered) VALUES
(1100, 'Keyth Stone', 1242),
(1101, 'Joe Mamma', 1301);


INSERT INTO MadeOf(DishID, IngredientId, OuncesNeeded) VALUES
(1,8,4),
(1,9,0.1),
(1,24,1),
(1,39,0.25),
(1,44,2),
(1,45,2),
(2,1,16),
(2,2,14),
(2,3,0.1),
(3,62,12),
(3,63,6),
(4,1,4),
(4,3,0.05),
(4,4,12),
(4,5,0.05),
(4,6,2),
(4,7,6),
(4,8,16),
(4,9,0.1),
(4,10,2),
(4,11,6),
(4,12,0.5),
(4,13,4),
(4,14,2),
(4,15,10),
(4,16,2),
(4,17,0.1),
(4,18,0.1),
(5,3,0.1),
(5,4,3),
(5,6,2),
(5,7,2),
(5,12,0.5),
(5,13,4),
(5,14,1),
(5,15,8),
(5,17,0.2),
(5,18,0.2),
(5,19,16),
(5,20,16),
(5,21,0.2),
(6,2,4),
(6,11,6),
(6,16,2),
(6,20,4),
(6,22,8),
(6,23,6),
(7,3,0.2),
(7,6,3),
(7,24,4),
(7,25,8),
(7,26,4),
(8,3,0.2),
(8,6,3),
(8,9,0.2),
(8,24,3),
(8,32,12),
(8,33,12),
(8,34,1),
(8,35,3),
(9,1,1),
(9,11,4),
(9,12,1),
(9,36,12),
(9,37,1),
(9,38,3),
(9,39,1),
(10,1,1),
(10,3,0.1),
(10,9,0.1),
(10,12,1),
(10,14,1),
(10,40,4),
(10,41,8),
(10,42,2),
(10,43,3);





INSERT INTO customer(Name, cust_id, age) VALUES
('Theodore Miller', 1, 20),
('Ethan King', 2, 35);

INSERT INTO table_num(table_id, cust_ID) VALUES
(1, 1),
(2, 2);

INSERT INTO contains_dishes(DishID, cust_ID) VALUES
(1, 1),
(1, 2);

INSERT INTO contains_Drinks(drinkID, cust_ID) VALUES
(10001, 1),
(10002, 2);

INSERT INTO ordersFrom(serverID, table_id, TimeFin) VALUES
(-1, 1, '2021-11-3 11:30:00'),
(-1, 2, '2021-11-3 11:30:00'),
(-1, 3, '2021-11-3 11:30:00'),
(-1, 4, '2021-11-3 11:30:00'),
(-1, 5, '2021-11-3 11:30:00'),
(-1, 6, '2021-11-3 11:30:00'),
(-1, 7, '2021-11-3 11:30:00'),
(-1, 8, '2021-11-3 11:30:00'),
(-1, 9, '2021-11-3 11:30:00'),
(-1, 10, '2021-11-3 11:30:00'),
(-1, 11, '2021-11-3 11:30:00'),
(-1, 12, '2021-11-3 11:30:00');

INSERT INTO reviews(DishID, cust_ID, time_day, rating) VALUES
(1, 1, '2021-11-4 11:30:00', 3),
(1, 2, '2021-10-3 11:35:00', 5);

INSERT INTO MadeOfDrink(drinkID, IngredientId, OuncesNeeded) VALUES 
(10001, 46, 12),
(10001, 55, 1),
(10001, 47, .1),
(10001, 49, .1),
(10001, 51, .1),
(10001, 53, .1),
(10001, 54, .1),
(10002, 46, 12),
(10002, 55, 1),
(10002, 47, .1),
(10002, 49, .1),
(10002, 51, .1),
(10002, 53, .1),
(10003, 46, 12),
(10003, 47, .1),
(10003, 48, .1),
(10003, 49, .1),
(10003, 51, .1),
(10003, 52, .1),
(10003, 53, .1),
(10004, 16, 12),
(10004, 57, .1),
(10004, 58, .1),
(10004, 59, .1),
(10004, 60, .1),
(10005, 16, 12),
(10006, 46, 12),
(10006, 55, 1),
(10006, 52, .1),
(10006, 51, .1),
(10006, 58, .1),
(10006, 54, .1);

INSERT INTO Merchant(MName)
VALUES ('ItalianLand');





SELECT *
FROM Dishes d 
JOIN MadeOf mo on d.DishID = mo.DishID
JOIN Ingredients i on i.IngredientID = mo.IngredientId
WHERE d.DName = 'Burger'
CREATE TYPE  name as Object(
    firstname varchar2(100),
    lastname varchar2(100)
);

CREATE TYPE address as Object(
    street varchar2(100),
    city varchar2(100),
    zip_code varchar2(100)
);

CREATE TYPE phone_list AS
TABLE OF NUMBER

CREATE TYPE items AS
TABLE OF NUMBER

CREATE TABLE users(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name NAME not null,
    email varchar2(100) not null UNIQUE,
    password varchar2(255) not null,
    address ADDRESS,
    phone_numbers PHONE_LIST,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    PRIMARY KEY(id)
)
NESTED TABLE phone_numbers STORE AS phone_nested;

CREATE TABLE products(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name varchar2(100) not null,
    description varchar2(255),
    brand varchar2(255),
    price NUMBER(8,2) not null,
    stock NUMBER(38) not null,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    PRIMARY KEY (id)
);

ALTER TABLE products
ADD CONSTRAINT check_positive_price CHECK(price > 0);

CREATE TABLE options(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name varchar2(100) not null,
    product_id NUMBER not null,
    PRIMARY KEY(id),
    FOREIGN KEY(product_id) REFERENCES products(id)
    ON DELETE CASCADE
);


CREATE TABLE option_values(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    option_id NUMBER not null,
    name varchar2(100) not null,
    PRIMARY KEY(id),
    FOREIGN KEY(option_id) REFERENCES options(id)
    ON DELETE CASCADE
);

CREATE TABLE variants(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    product_id NUMBER,
    description varchar2(255),
    price NUMBER (8,2),
    stock NUMBER,
    stock_threshold NUMBER,
    media_id varchar2(255),
    PRIMARY KEY(id),
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

ALTER TABLE variants 
    MODIFY price NUMBER(18,2);

CREATE TABLE option_value_variant(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    option_value_id NUMBER,
    variant_id NUMBER,
    PRIMARY KEY(id),
    FOREIGN KEY (option_value_id) REFERENCES option_values(id),
    FOREIGN KEY (variant_id) REFERENCES variants(id) ON DELETE CASCADE
);

CREATE TABLE payment_type(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar2(100) NOT NULL;
);

CREATE TABLE cart
(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    client_id NUMBER NOT NULL,
    product_items ITEMS,
    PRIMARY KEY(id),
    FOREIGN KEY(client_id) REFERENCES users(id)
)
NESTED TABLE product_items STORE AS product_items_nested;

CREATE TABLE invoices
(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    client_id NUMBER NOT NULL,
    total_amount NUMBER(18,2) NOT NULL,
    payment_type_id NUMBER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(client_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(payment_type_id) REFERENCES payment_type(id)
);

CREATE TABLE invoice_details
(
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    invoice_id NUMBER,
    variant_id NUMBER,
    quantity NUMBER(18,2),
    PRIMARY KEY(id),
    FOREIGN KEY(invoice_id) REFERENCES invoices(id),
    FOREIGN KEY(variant_id) REFERENCES variants(id)
);

-- users
INSERT INTO users (name, email, password, address, phone_numbers, created_at, updated_at)VALUES
(Name('Visar', 'Buza'), 'visar.buza7@gmail.com','123456',Address('Rr. Nena Tereze','Prishtine','10000'),PHONE_LIST(045292300,044292198),CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);


-- products
INSERT INTO products(name, description, brand, price, stock, created_at, updated_at) VALUES
('Sweater','Lorem ipsum','Gucci',15,30,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

INSERT INTO products(name, description, brand, price, stock, created_at, updated_at) VALUES
('T Shirt','Lorem ipsum','Adiddas', 45,30,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

INSERT INTO products(name, description, brand, price, stock, created_at, updated_at) VALUES
('Jeans','High quality denim','Diesel',70,40,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

INSERT INTO products(name, description, brand, price, stock, created_at, updated_at) VALUES 
('Jacket', 'Lorem ipsum', 'Versace', 100,    40, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);



INSERT INTO options(name, product_id) VALUES ('Size', 1);

INSERT INTO options(name, product_id) VALUES ('Size',2);

INSERT INTO options(name, product_id) VALUES ('Color',2);

INSERT INTO options(name, product_id) VALUES ('Size',3);

INSERT INTO options(name, product_id) VALUES ('Fit',3);

INSERT INTO options(name, product_id) VALUES('Size',4);



INSERT INTO option_values(name, option_id)VALUES ('S',1);

INSERT INTO option_values(name, option_id) VALUES ('M',1);

INSERT INTO option_values(name, option_id)VALUES ('L',1);

INSERT INTO option_values(name, option_id)VALUES ('S',2);

INSERT INTO option_values(name, option_id) VALUES ('M',2);

INSERT INTO option_values(name, option_id)VALUES ('L',2);

INSERT INTO option_values(name, option_id) VALUES ('XXL', 2);

INSERT INTO option_values(name, option_id)VALUES ('Black',2);

INSERT INTO option_values(name, option_id) VALUES ('White',2);

INSERT INTO option_values(name, option_id)VALUES ('Gray',2);

INSERT INTO option_values(name, option_id)VALUES ('30',3);

INSERT INTO option_values(name, option_id) VALUES ('32',3);

INSERT INTO option_values(name, option_id)VALUES ('34',3);

INSERT INTO option_values(name, option_id)VALUES ('Regular',3);

INSERT INTO option_values(name, option_id) VALUES ('Slim',3);

INSERT INTO option_values(name, option_id)VALUES ('Skinny',3);

INSERT INTO option_values(name, option_id)VALUES ('S',4);

INSERT INTO option_values(name, option_id) VALUES ('M',4);

INSERT INTO option_values(name, option_id)VALUES ('L',4);

INSERT INTO option_values(name, option_id) VALUES ('XXL', 4);



INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (1, 'Small',15, 10, 1);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (1, 'Medium',15, 10, 1);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (1, 'Large',15, 10, 1);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Small White', 8, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Small Black',8,  5, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Small Gray', 8, 5, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Medium White',8, 5, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Medium Black',8, 19, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Medium Gray',8, 5, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Large White',8, 7, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Large Black',8, 3, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Large Gray',8, 5, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Extra Large White',10, 5, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Extra Large Black',10, 15, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (2, 'Extra Large Gray',10, 7, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '30 Slim', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '30 Regular', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '30 Skinny', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '32 Skinny', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '32 Regular', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '32 Slim', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '34 Slim', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '34 Regular', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (3, '34 Skinny', 70, 8, 3);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (4, 'Small Jacket', 100, 10, 5);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (4, 'Medium Jacket', 100, 10, 5);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (4, 'Large Jacket', 100, 10, 5);

INSERT INTO variants (product_id, description, price, stock, stock_threshold) VALUES (4, 'Extra Large Jacket', 100, 10, 5);



INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (37,1);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (38,2);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (39,3);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (40,4);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (45,4);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (40,5);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (44,5);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (40,6);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (46,6);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (41,7);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (45,7);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (41,8);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (44,8);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (41,9);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (46,9);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (42,10);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (45,10);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (42,11);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (44,11);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (42,12);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (46,12);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (43,13);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (45,13);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (43,14);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (44,14);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (43,15);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (46,15);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (51,16);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (47,16);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (50,17);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (47,17);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (52,18);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (47,18);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (52,19);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (48,19);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (50,20);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (48,20);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (51,21);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (48,21);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (49,22);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (51,22);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (49,23);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (50,23);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (49,24);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (52,24);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (53,25);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (54,26);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (55,27);

INSERT INTO option_value_variant (option_value_id, variant_id) VALUES (56,28);




INSERT INTO payment_type (name) VALUES ('PayPal');

INSERT INTO payment_type (name) VALUES ('Apple Pay');

INSERT INTO payment_type (name) VALUES ('VISA');

INSERT INTO payment_type (name) VALUES ('Master Card');

INSERT INTO payment_type (name) VALUES ('Maestro');

---------------------------------------------------------------------
-----Index-----------------------------------------------------------
Create Index Products_Name_index 
ON Products(name);

Create Index Users_name_index 
ON users(name.firstname,name.lastname);

---------------------------------------------------------------------
-----Unique index----------------------------------------------------
Create unique Index PaymentType_name_index 
ON Payment_type(name);

---------------------------------------------------------------------
--- Bitmap Index ----------------------------------------------------
CREATE bitmap INDEX variants_price_index
ON Variants(Price);

CREATE bitmap INDEX variants_stock_index 
ON Variants(Stock);
---------------------------------------------------------------------
------Function Based Index ------------------------------------------
CREATE INDEX products_totalmoney_index
ON  Products(Price * Stock);


---------------------------------------------------------------------
----------Views------------------------------------------------------
CREATE OR REPLACE FORCE VIEW perdoruest_gmail_pr AS 
  Select u.name.firstname as Emri,
     u.name.lastname as Mbiemri ,
         u.address.city as Qyteti 
           from users u 
      where u.email like '%@gmail.com' 
          and u.address.city = 'Prishtine';
 
Update 
   perdoruest_gmail_pr 
Set 
   Qyteti = 'Kamenice'
   where Emri like 'S%';
 
 
 
 Create  OR replace view  view2 As
    Select p1.name as Emri_i_produktit ,
        p1.brand as Brendi_i_produktit,
        p1.price as Qmimi
    from products p1
      where p1.Stock>30 
         and p1.price>70 
           and p1.name in
    (Select p.name as Emri_i_produktit 
     from products p 
        INNER JOIN options i ON p.id=i.product_id);


SELECT * FROM products, options WHERE  products.id = options.product_id



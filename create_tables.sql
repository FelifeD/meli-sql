-- Tabela Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(200),
    lastname VARCHAR(200),
    address VARCHAR(200),
    doc_number INT,
    doc_type VARCHAR(50),
    email VARCHAR(200),
    sex VARCHAR(10),
    gender VARCHAR(10),
    birth_date DATE,
    contact1 VARCHAR(50),
    contact2 VARCHAR(50),
    status_ativo BOOLEAN,
    created_at DATETIME,
    datetime_alteration DATETIME,
    datetime_cancelation DATETIME
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_datetime DATETIME,
    buyer_id INT,
    seller_id INT,
    item_id INT,
    quantity INT,
    order_value FLOAT,
    currency VARCHAR(50),
    order_status VARCHAR(50)
);

CREATE TABLE Items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(200),
    seller_id INT,
    price FLOAT,
    currency VARCHAR(50),
    category_id INT,
    status_ativo BOOLEAN,
    created_at DATETIME,
    datetime_alteration DATETIME,
    datetime_cancelation DATETIME
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(200),
    category_description TEXT,
    status_ativo BOOLEAN,
    created_at DATETIME,
    datetime_alteration DATETIME,
    datetime_cancelation DATETIME
);

CREATE TABLE ItemsHistory (
    item_history_key INT PRIMARY KEY,
    item_id INT,
    item_name VARCHAR(200),
    price FLOAT,
    currency VARCHAR(50),
    category_id INT,
    status_ativo BOOLEAN,
    created_at DATETIME,
    datetime_alteration DATETIME,
    datetime_record DATETIME
);

-- Adicionando chaves estrangeiras
ALTER TABLE Orders
    ADD CONSTRAINT fk_orders_buyer
    FOREIGN KEY (buyer_id) REFERENCES Customers(customer_id);

ALTER TABLE Orders
    ADD CONSTRAINT fk_orders_seller
    FOREIGN KEY (seller_id) REFERENCES Customers(customer_id);

ALTER TABLE Orders
    ADD CONSTRAINT fk_orders_item
    FOREIGN KEY (item_id) REFERENCES Items(item_id);

ALTER TABLE Items
    ADD CONSTRAINT fk_items_category
    FOREIGN KEY (category_id) REFERENCES Categories(category_id);

ALTER TABLE Items
    ADD CONSTRAINT fk_items_seller
    FOREIGN KEY (seller_id) REFERENCES Customers(customer_id);

ALTER TABLE ItemsHistory
    ADD CONSTRAINT fk_items_history_item
    FOREIGN KEY (item_id) REFERENCES Items(item_id);

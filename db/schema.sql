-- Marketplace Data System
-- PostgreSQL schema
-- Author: Serhii

-- Удаляем таблицы, если они уже существуют (чтобы не было конфликта)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS follows;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

-- Таблица пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица товаров
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    stock INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица заказов
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица элементов заказа
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT
);

-- Таблица платежей
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    amount DECIMAL(10,2),
    method VARCHAR(50),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица склада
CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    quantity INT,
    location VARCHAR(100)
);

-- Таблица событий
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    order_id INT REFERENCES orders(id),
    event_type VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица постов (например для отзывов или новостей)
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    body TEXT,
    user_id INT REFERENCES users(id),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица подписок / слежки
CREATE TABLE follows (
    following_user_id INT REFERENCES users(id),
    followed_user_id INT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (following_user_id, followed_user_id)
);

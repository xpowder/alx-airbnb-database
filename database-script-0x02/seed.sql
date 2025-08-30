-- ========================
-- Sample Data Seeding
-- ========================

-- Users
INSERT INTO users (first_name, last_name, email, password_hash, role)
VALUES
('Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', 'guest'),
('Bob', 'Smith', 'bob@example.com', 'hashed_pw2', 'host'),
('Charlie', 'Brown', 'charlie@example.com', 'hashed_pw3', 'guest');

-- Properties
INSERT INTO properties (host_id, name, description, location, price_per_night)
VALUES
((SELECT user_id FROM users WHERE email='bob@example.com'),
 'Seaside Villa', 'Beautiful villa by the sea', 'Miami, FL', 250.00),
((SELECT user_id FROM users WHERE email='bob@example.com'),
 'Downtown Loft', 'Modern loft in the city center', 'New York, NY', 180.00);

-- Bookings
INSERT INTO bookings (property_id, guest_id, start_date, end_date, total_price, status)
VALUES
((SELECT property_id FROM properties WHERE name='Seaside Villa'),
 (SELECT user_id FROM users WHERE email='alice@example.com'),
 '2025-09-01', '2025-09-05', 1000.00, 'confirmed');

-- Payments
INSERT INTO payments (booking_id, amount, payment_method, status)
VALUES
((SELECT booking_id FROM bookings LIMIT 1), 1000.00, 'card', 'paid');

-- Reviews
INSERT INTO reviews (property_id, user_id, rating, comment)
VALUES
((SELECT property_id FROM properties WHERE name='Seaside Villa'),
 (SELECT user_id FROM users WHERE email='alice@example.com'),
 5, 'Amazing stay! Highly recommend.');

-- Messages
INSERT INTO messages (sender_id, recipient_id, message_body)
VALUES
((SELECT user_id FROM users WHERE email='alice@example.com'),
 (SELECT user_id FROM users WHERE email='bob@example.com'),
 'Hi Bob, is your villa available in October?');


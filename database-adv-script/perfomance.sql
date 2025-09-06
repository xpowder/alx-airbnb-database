-- ===========================================
-- 1. Index Creation
-- ===========================================

-- Users table
CREATE INDEX idx_users_email ON users(email);

-- Properties table
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);

-- Bookings table
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- Reviews table
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- ===========================================
-- 2. Performance Testing Queries
-- ===========================================

-- Test 1: Find a user by email (login/authentication scenario)
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- Test 2: Fetch all properties listed by a host
EXPLAIN SELECT * FROM properties WHERE host_id = 10;

-- Test 3: Search properties by location
EXPLAIN SELECT * FROM properties WHERE location = 'New York';

-- Test 4: Get all bookings for a specific guest
EXPLAIN SELECT * FROM bookings WHERE guest_id = 42;

-- Test 5: Get all bookings for a property
EXPLAIN SELECT * FROM bookings WHERE property_id = 100;

-- Test 6: Check availability of a property by date
EXPLAIN SELECT * FROM bookings 
WHERE property_id = 100 
AND start_date >= '2025-09-01';

-- Test 7: Get all reviews for a property
EXPLAIN SELECT * FROM reviews WHERE property_id = 100;

-- ===========================================
-- 3. Join Performance Tests
-- ===========================================

-- Join users and bookings (who booked what)
EXPLAIN
SELECT u.user_id, u.name, b.booking_id, b.start_date
FROM users u
JOIN bookings b ON u.user_id = b.guest_id;

-- Join properties and reviews (property details + reviews)
EXPLAIN
SELECT p.property_id, p.title, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;

-- ===========================================================
-- Database Performance Optimization Script
-- ===========================================================
-- This script creates indexes on high-usage columns and
-- tests query performance using EXPLAIN ANALYZE.
-- Save as: performance.sql
-- ===========================================================

-- ==========================================
-- 1. Index Creation
-- ==========================================

-- Users table
-- Index on email for fast lookup during login/authentication
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Properties table
-- Index on host_id to quickly fetch properties listed by a host
CREATE INDEX IF NOT EXISTS idx_properties_host_id ON properties(host_id);
-- Index on location to optimize search queries
CREATE INDEX IF NOT EXISTS idx_properties_location ON properties(location);

-- Bookings table
-- Index on guest_id to quickly retrieve all bookings by a guest
CREATE INDEX IF NOT EXISTS idx_bookings_guest_id ON bookings(guest_id);
-- Index on property_id to quickly find all bookings for a property
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
-- Index on start_date to optimize date-range queries
CREATE INDEX IF NOT EXISTS idx_bookings_start_date ON bookings(start_date);

-- Reviews table
-- Index on property_id to quickly retrieve reviews for a property
CREATE INDEX IF NOT EXISTS idx_reviews_property_id ON reviews(property_id);

-- ==========================================
-- 2. Performance Testing Queries
-- ==========================================

-- Test 1: Find a user by email (login/authentication)
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- Test 2: Fetch all properties listed by a host
EXPLAIN ANALYZE SELECT * FROM properties WHERE host_id = 10;

-- Test 3: Search properties by location
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = 'New York';

-- Test 4: Get all bookings for a specific guest
EXPLAIN ANALYZE SELECT * FROM bookings WHERE guest_id = 42;

-- Test 5: Get all bookings for a property
EXPLAIN ANALYZE SELECT * FROM bookings WHERE property_id = 100;

-- Test 6: Check availability of a property by date
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE property_id = 100
AND start_date >= '2025-09-01';

-- Test 7: Get all reviews for a property
EXPLAIN ANALYZE SELECT * FROM reviews WHERE property_id = 100;

-- ==========================================
-- 3. Join Performance Tests
-- ==========================================

-- Join users and bookings (who booked what)
EXPLAIN ANALYZE
SELECT u.user_id, u.name, b.booking_id, b.start_date
FROM users u
JOIN bookings b ON u.user_id = b.guest_id;

-- Join properties and reviews (property details + reviews)
EXPLAIN ANALYZE
SELECT p.property_id, p.title, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;


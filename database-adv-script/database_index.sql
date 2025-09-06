-- 1. CREATE INDEX statements
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- 2. Performance testing queries using EXPLAIN or EXPLAIN ANALYZE
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';
EXPLAIN ANALYZE SELECT * FROM properties WHERE host_id = 10;
EXPLAIN ANALYZE SELECT * FROM bookings WHERE guest_id = 42;
EXPLAIN ANALYZE SELECT * FROM bookings WHERE property_id = 100;
EXPLAIN ANALYZE SELECT * FROM reviews WHERE property_id = 100;

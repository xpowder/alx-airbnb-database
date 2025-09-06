-- =========================================================
-- 1 INNER JOIN: Retrieve all bookings with their respective guests
-- =========================================================
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.name AS guest_name,
    u.email AS guest_email
FROM bookings b
INNER JOIN users u  
    ON b.guest_id = u.user_id;
    
-- =========================================================
-- 2 LEFT JOIN: Retrieve all properties with their reviews
--             Including properties that have no reviews
-- =========================================================
SELECT 
    p.property_id,
    p.title,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id
ORDER BY p.title, review_date DESC;

-- =========================================================
-- 3 FULL OUTER JOIN: Retrieve all users and all bookings
--             Including users without bookings and bookings without users
-- =========================================================
SELECT
    u.user_id,
    u.name AS guest_name,
    u.email AS guest_email,
    u.role,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM users AS u
FULL OUTER JOIN bookings AS b 
    ON u.user_id = b.guest_id
ORDER BY u.user_id, b.booking_id;

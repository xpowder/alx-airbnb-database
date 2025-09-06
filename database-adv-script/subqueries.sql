
-- =========================================================
-- 1 query to find all properties where the average rating is greater than 4.0 using a subquery
-- =========================================================



SELECT 
    p.property_id,
    p.title,
    p.location,

FROM properties p
WHERE p.property_id IN (
    SELECT b.property_id
    FROM bookings b
    JOIN reviews r ON b.booking_id = r.booking_id
    ORDER BY r.rating DESC
    HAVING AVG(r.rating) > 4.0
    
);


-- =========================================================
-- 2 Subquery in WHERE clause: Retrieve users with more than 3 bookings
-- =========================================================


SELECT
    u.user_id,
    u.name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.guest_id = u.user_id > 3
)

-- ===================================================
-- 1.Aggregation find all total number of bookings made by each user
-- ===================================================

SELECT
    u.user_id,
    u.name AS guest_name,
    u.email AS guest_email,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.guest_id
GROUP BY u.user_id, u.name, u.email
ORDER BY u.user_id;


-- ===================================================
-- 2.Using window functions to rank properties based on the number of bookings
-- ===================================================

SELECT
    p.property_id,
    p.title,
    COUNT(b.booking_id) AS total_bookings
    RANK() OVER (ORDER by COUNT(b.booking_id) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER by COUNT(b.booking_id) DESC) AS booking_row_number

FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.title
ORDER BY total_bookings DESC;
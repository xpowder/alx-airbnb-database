-- ===========================================================
-- Partition Booking table by start_date (RANGE)
-- ===========================================================

-- Step 1: Create a partitioned table
CREATE TABLE Booking_Partitioned (
    booking_id INT PRIMARY KEY,
    property_id INT NOT NULL,
    guest_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20),
    total_price DECIMAL(10,2),
    created_at TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions per year
CREATE TABLE bookings_2024 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Optional indexes on partitions
CREATE INDEX idx_bookings_2024_start_date ON bookings_2024(start_date);
CREATE INDEX idx_bookings_2025_start_date ON bookings_2025(start_date);

# Table Partitioning Performance Report

## 1. Introduction
Partitioning was applied to the `Booking` table to improve query performance on large datasets, especially for date-range queries.

## 2. Partitioning Strategy
- **Column:** start_date
- **Type:** RANGE
- **Partitions:** One per year (bookings_2024, bookings_2025, ...)

## 3. SQL Implementation
Partitioned table script saved in `partitioning.sql`.

## 4. Performance Testing
Example query: Fetch bookings between Jan 1, 2025, and Jun 30, 2025.

**Before partitioning:**
- Query scanned all rows in `Booking` table.
- EXPLAIN showed **Seq Scan**.

**After partitioning:**
- Query scanned only the `bookings_2025` partition.
- EXPLAIN showed **Index/Partition Scan**.
- Execution time decreased significantly.

## 5. Results
- Partitioning reduced query execution time for date-range queries.
- Scans are now limited to relevant partitions.
- Maintenance (archiving old bookings) is easier.

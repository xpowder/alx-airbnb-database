# Index Performance Optimization Report

## 1. Introduction
This report outlines the process of identifying and implementing **database indexes** to optimize query performance in the Airbnb Clone application. The goal is to reduce query execution time for frequent read operations (logins, searches, bookings, reviews) by indexing high-usage columns.

---

## 2. Identification of High-Usage Columns
Based on the system’s core features, we identified the following columns as candidates for indexing:

- **Users**
  - `email`: Frequently used for login and authentication.
- **Properties**
  - `host_id`: Used in joins with the `Users` table to fetch host details.
  - `location`: Used for property searches and filters.
- **Bookings**
  - `guest_id`: Used to retrieve booking history for a guest.
  - `property_id`: Used to fetch bookings for a property.
  - `start_date`: Used in availability and scheduling queries.
- **Reviews**
  - `property_id`: Used to fetch all reviews for a property’s detail page.

---

## 3. Index Implementation
The following SQL statements were added in **`perfomance.sql`**:

```sql
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

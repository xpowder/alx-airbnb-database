-- Airbnb Database Schema
-- File: database-script-0x01/schema.sql

-- ========================
-- Users Table
-- ========================
CREATE TABLE IF NOT EXISTS users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) CHECK (role IN ('guest', 'host', 'admin')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index on email for fast lookup
CREATE INDEX idx_users_email ON users(email);

-- ========================
-- Properties Table
-- ========================
CREATE TABLE IF NOT EXISTS properties (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20),
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index on city for faster searches
CREATE INDEX idx_properties_city ON properties(city);

-- ========================
-- Bookings Table
-- ========================
CREATE TABLE IF NOT EXISTS bookings (
    booking_id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    property_id UUID NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price_per_night_at_booking DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_booking_dates CHECK (end_date > start_date)
);

-- Indexes for fast queries by user and property
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_property ON bookings(property_id);

-- ========================
-- Reviews Table
-- ========================
CREATE TABLE IF NOT EXISTS reviews (
    review_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index on booking_id for quick review lookup
CREATE INDEX idx_reviews_booking ON reviews(booking_id);


# Entity-Relationship Diagram Requirements

## Entities & Attributes

### User
- user_id (UUID, PK, Indexed)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL, Indexed)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest | host | admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Constraints**
- Unique: email
- NOT NULL: required fields (first_name, last_name, email, password_hash, role)

---

### Property
- property_id (UUID, PK, Indexed)
- host_id (UUID, FK → User.user_id)
- name (VARCHAR, NOT NULL)
- description (TEXT)
- location (VARCHAR, NOT NULL)
- price_per_night (DECIMAL(10,2), NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Constraints**
- Foreign key: host_id references User(user_id)
- NOT NULL: name, location, price_per_night

---

### Booking
- booking_id (UUID, PK, Indexed)
- property_id (UUID, FK → Property.property_id)
- guest_id (UUID, FK → User.user_id)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL(10,2), NOT NULL)
- status (ENUM: pending | confirmed | canceled, NOT NULL)

**Constraints**
- Foreign keys: property_id → Property, guest_id → User
- status must be one of pending, confirmed, canceled

---

### Payment
- payment_id (UUID, PK, Indexed)
- booking_id (UUID, FK → Booking.booking_id)
- amount (DECIMAL(10,2), NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: card | paypal | transfer, NOT NULL)
- status (ENUM: paid | refunded, NOT NULL)

**Constraints**
- Foreign key: booking_id references Booking(booking_id)
- Ensures payment is linked to a valid booking

---

### Review
- review_id (UUID, PK, Indexed)
- property_id (UUID, FK → Property.property_id)
- user_id (UUID, FK → User.user_id)
- rating (INT, CHECK rating BETWEEN 1 AND 5)
- comment (TEXT, NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Constraints**
- Foreign keys: property_id → Property, user_id → User
- rating must be between 1 and 5

---

### Message
- message_id (UUID, PK, Indexed)
- sender_id (UUID, FK → User.user_id)
- recipient_id (UUID, FK → User.user_id)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Constraints**
- Foreign keys: sender_id → User, recipient_id → User
- NOT NULL: message_body

---

## Relationships
- **User → Property**: One-to-Many (a host can have many properties)
- **User → Booking**: One-to-Many (a guest can make many bookings)
- **Property → Booking**: One-to-Many (a property can have many bookings)
- **Booking → Payment**: One-to-One (each booking has one payment)
- **Property → Review**: One-to-Many (a property can have many reviews)
- **User → Review**: One-to-Many (a user can leave many reviews)
- **User → Message**: One-to-Many (a user can send/receive many messages)

---

## Indexing Strategy
- Primary keys: indexed automatically
- Additional indexes:
  - User.email
  - Property.property_id
  - Booking.property_id
  - Booking.booking_id
  - Payment.booking_id

---

## Deliverables
- Save editable ER diagram as: `ERD/airbnb_erd.drawio`
- (Optional) Export an image version: `ERD/airbnb_erd.png`


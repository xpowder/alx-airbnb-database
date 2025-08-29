# Airbnb Database Normalization

## Objective
Apply normalization principles to ensure the Airbnb database is in **Third Normal Form (3NF)**. This ensures minimal redundancy, avoids update anomalies, and maintains data integrity.

...

## Step 4: Summary of Normalization Steps

| Normal Form | Action Taken |
|-------------|--------------|
| 1NF | Ensured atomic columns and no repeating groups |
| 2NF | Ensured all non-key attributes fully depend on PK; moved price_per_night_at_booking to Booking |
| 3NF | Removed transitive dependency of total_amount on Property.price_per_night |

✅ **Database is now in 3NF.**


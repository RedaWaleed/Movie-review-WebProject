# Movie Review Database - MySQL

A comprehensive MySQL database schema for a movie review website with full support for users, movies, reviews, cast/crew, social features, and more.

## 📋 Table of Contents
- [Features](#features)
- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage](#usage)
- [Database Tables](#database-tables)
- [Relationships](#relationships)
- [Triggers](#triggers)
- [Sample Queries](#sample-queries)

## ✨ Features

### Core Features
- **User Management**: User accounts with roles (user, critic, admin), profiles, and authentication
- **Movie Database**: Comprehensive movie information including metadata, cast, crew, and production details
- **Review System**: User reviews with ratings, helpful votes, and comment threads
- **Social Features**: User following, activity feeds, and social interactions
- **Watchlist & Favorites**: Personal movie collections for users
- **Genre Classification**: Multi-genre support for movies
- **Cast & Crew**: Detailed information about actors, directors, and crew members
- **Streaming Availability**: Track where movies are available to watch
- **Awards Tracking**: Record movie and person awards and nominations
- **Collections**: Group related movies (franchises, series)

### Advanced Features
- **Automated Rating Calculations**: Triggers automatically update movie ratings when reviews are added/modified
- **Review Helpfulness**: Users can vote on review quality
- **Activity Logging**: Track user activities across the platform
- **Spoiler Warnings**: Reviews can be marked as containing spoilers
- **Review Moderation**: Status system for review approval and flagging

## 🗄️ Database Schema

### Main Tables
1. **users** - User accounts and profiles
2. **movies** - Movie information and metadata
3. **reviews** - User reviews and ratings
4. **people** - Actors, directors, and crew members
5. **genres** - Movie genres
6. **streaming_platforms** - Streaming service information
7. **production_companies** - Movie production companies
8. **collections** - Movie franchises and series

### Relationship Tables
- **movie_genres** - Links movies to genres (many-to-many)
- **movie_cast** - Links movies to actors with character information
- **movie_crew** - Links movies to crew members with job titles
- **movie_production_companies** - Links movies to production companies
- **movie_streaming** - Links movies to streaming platforms
- **movie_collections** - Links movies to collections/franchises
- **review_votes** - User votes on review helpfulness
- **review_comments** - Comments on reviews
- **watchlist** - User movie watchlists
- **favorites** - User favorite movies
- **user_followers** - User following relationships
- **awards** - Movie and person awards

## 🚀 Installation

### Prerequisites
- MySQL 8.0 or higher (recommended)
- MySQL 5.7+ (minimum)
- MySQL client or MySQL Workbench

### Step 1: Create the Database

```bash
# Login to MySQL
mysql -u root -p

# Or specify host if needed
mysql -u root -p -h localhost
```

### Step 2: Run the Schema File

```sql
-- From MySQL prompt
source d:/WebProject/database/movie_review_schema.sql;

-- Or from command line
mysql -u root -p < d:/WebProject/database/movie_review_schema.sql
```

### Step 3: Load Sample Data (Optional)

```sql
-- From MySQL prompt
source d:/WebProject/database/sample_data.sql;

-- Or from command line
mysql -u root -p movie_review_db < d:/WebProject/database/sample_data.sql
```

### Step 4: Verify Installation

```sql
USE movie_review_db;
SHOW TABLES;
SELECT COUNT(*) FROM movies;
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM reviews;
```

## 💻 Usage

### Connecting to the Database

**PHP (MySQLi)**
```php
<?php
$servername = "localhost";
$username = "root";
$password = "your_password";
$dbname = "movie_review_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
```

**PHP (PDO)**
```php
<?php
try {
    $pdo = new PDO(
        "mysql:host=localhost;dbname=movie_review_db;charset=utf8mb4",
        "root",
        "your_password",
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
} catch(PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>
```

**Node.js (mysql2)**
```javascript
const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'your_password',
    database: 'movie_review_db'
});

connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to database!');
});
```

**Python (mysql-connector)**
```python
import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="your_password",
    database="movie_review_db"
)

cursor = db.cursor()
```

## 📊 Database Tables

### Users Table
Stores user account information and profiles.

**Key Fields:**
- `user_id` - Primary key
- `username` - Unique username
- `email` - Unique email address
- `password_hash` - Hashed password
- `role` - User role (user, critic, admin)
- `is_verified` - Email verification status

### Movies Table
Stores comprehensive movie information.

**Key Fields:**
- `movie_id` - Primary key
- `title` - Movie title
- `release_date` - Release date
- `runtime` - Duration in minutes
- `average_rating` - Calculated average rating (0-5)
- `total_reviews` - Number of reviews
- `status` - Release status (released, upcoming, etc.)

### Reviews Table
Stores user reviews and ratings.

**Key Fields:**
- `review_id` - Primary key
- `movie_id` - Foreign key to movies
- `user_id` - Foreign key to users
- `rating` - Rating (0.0 to 5.0)
- `review_text` - Review content
- `is_spoiler` - Spoiler warning flag
- `helpful_count` - Number of helpful votes
- `status` - Review status (published, pending, flagged)

**Constraint:** One review per user per movie

## 🔗 Relationships

### One-to-Many Relationships
- Users → Reviews (one user can write many reviews)
- Movies → Reviews (one movie can have many reviews)
- Reviews → Comments (one review can have many comments)

### Many-to-Many Relationships
- Movies ↔ Genres (via movie_genres)
- Movies ↔ People (via movie_cast and movie_crew)
- Movies ↔ Production Companies (via movie_production_companies)
- Movies ↔ Streaming Platforms (via movie_streaming)
- Users ↔ Users (via user_followers for social following)

## ⚡ Triggers

The database includes several automated triggers:

### Rating Update Triggers
Automatically recalculate movie average ratings when reviews are:
- `update_movie_rating_after_insert` - Added
- `update_movie_rating_after_update` - Modified
- `update_movie_rating_after_delete` - Deleted

### Review Helpfulness Triggers
Automatically update helpful/not helpful counts when votes are:
- `update_review_helpful_after_insert` - Added
- `update_review_helpful_after_update` - Changed
- `update_review_helpful_after_delete` - Removed

## 📝 Sample Queries

### Get Top Rated Movies
```sql
SELECT title, average_rating, total_reviews
FROM movies
WHERE total_reviews >= 5
ORDER BY average_rating DESC
LIMIT 10;
```

### Get Movie with Full Details
```sql
SELECT 
    m.*,
    GROUP_CONCAT(DISTINCT g.genre_name) AS genres
FROM movies m
LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
LEFT JOIN genres g ON mg.genre_id = g.genre_id
WHERE m.movie_id = 1
GROUP BY m.movie_id;
```

### Get User's Reviews
```sql
SELECT 
    r.rating,
    r.title,
    r.review_text,
    m.title AS movie_title,
    r.created_at
FROM reviews r
JOIN movies m ON r.movie_id = m.movie_id
WHERE r.user_id = 1
ORDER BY r.created_at DESC;
```

### Get Movie Cast
```sql
SELECT 
    p.name,
    mc.character_name,
    mc.cast_order
FROM movie_cast mc
JOIN people p ON mc.person_id = p.person_id
WHERE mc.movie_id = 1
ORDER BY mc.cast_order;
```

For more queries, see `useful_queries.sql`.

## 🔒 Security Considerations

1. **Password Storage**: Always hash passwords before storing (use bcrypt, Argon2, or similar)
2. **SQL Injection**: Use prepared statements/parameterized queries
3. **Input Validation**: Validate all user inputs before database operations
4. **Access Control**: Implement proper role-based access control
5. **Rate Limiting**: Implement rate limiting for review submissions
6. **XSS Protection**: Sanitize user-generated content (reviews, comments)

## 🎯 Best Practices

1. **Indexing**: The schema includes indexes on frequently queried columns
2. **Foreign Keys**: All relationships use foreign keys with CASCADE delete
3. **Character Set**: Uses utf8mb4 for full Unicode support (including emojis)
4. **Constraints**: Includes CHECK constraints for data validation
5. **Timestamps**: Automatic timestamps for created_at and updated_at fields

## 📈 Performance Tips

1. **Use Indexes**: The schema includes indexes on common query fields
2. **Limit Results**: Always use LIMIT for large result sets
3. **Avoid SELECT ***: Select only needed columns
4. **Use JOINs Wisely**: Only join tables you need
5. **Cache Results**: Cache frequently accessed data (top movies, genres, etc.)
6. **Pagination**: Implement pagination for review lists and movie listings

## 🛠️ Maintenance

### Backup Database
```bash
mysqldump -u root -p movie_review_db > backup.sql
```

### Restore Database
```bash
mysql -u root -p movie_review_db < backup.sql
```

### Optimize Tables
```sql
OPTIMIZE TABLE movies, reviews, users;
```

### Check Table Status
```sql
SHOW TABLE STATUS FROM movie_review_db;
```

## 📦 Future Enhancements

Potential additions to consider:
- User notifications system
- Movie recommendations engine
- Advanced search with filters
- User badges and achievements
- Movie discussion forums
- Video reviews support
- Multi-language support
- API rate limiting table
- Email verification tokens
- Password reset tokens
- User sessions table

## 📄 License

This database schema is provided as-is for educational and commercial use.

## 🤝 Contributing

Feel free to suggest improvements or report issues!

---

**Created:** 2025-12-03  
**Database Version:** 1.0  
**MySQL Version:** 8.0+

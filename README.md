'Amazing!', 'This movie was incredible...');
```

## 🔧 Troubleshooting
# MovieHub - Movie Review Website

A modern, fully-functional movie review website with database integration, search functionality, and dynamic content loading.

## 🎬 Features

- **Search Functionality**: Real-time movie search with autocomplete dropdown
- **Movie Database**: 16+ movies with posters, ratings, and reviews
- **Dynamic Content**: Popular movies, trending movies, and all movies sections
- **Movie Details Modal**: Click any movie to see full details, cast, crew, and reviews
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **Modern UI**: Dark theme with pink accents and smooth animations

## 📋 Prerequisites

- **Web Server**: Apache (XAMPP, WAMP, MAMP) or any PHP-enabled server
- **MySQL**: Version 5.7+ or MySQL 8.0+
- **PHP**: Version 7.4+ or PHP 8.0+
- **Browser**: Modern browser (Chrome, Firefox, Edge, Safari)

## 🚀 Installation

### Step 1: Set Up the Database

1. **Start your MySQL server** (via XAMPP, WAMP, or standalone MySQL)

2. **Open MySQL command line or phpMyAdmin**

3. **Run the schema file**:
   ```bash
   mysql -u root -p < database/movie_review_schema.sql
   ```
   
   Or in phpMyAdmin:
   - Click "Import"
   - Select `database/movie_review_schema.sql`
   - Click "Go"

4. **Load sample data**:
   ```bash
   mysql -u root -p movie_review_db < database/sample_data.sql
   ```
   
   Or in phpMyAdmin:
   - Select `movie_review_db` database
   - Click "Import"
   - Select `database/sample_data.sql`
   - Click "Go"

### Step 2: Configure Database Connection

1. Open `config/database.php`

2. Update the database credentials if needed:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USER', 'root');
   define('DB_PASS', '');  // Your MySQL password
   define('DB_NAME', 'movie_review_db');
   ```

### Step 3: Set Up Web Server

#### Option A: Using XAMPP/WAMP

1. Copy the entire `WebProject` folder to your web server directory:
   - **XAMPP**: `C:\xampp\htdocs\WebProject`
   - **WAMP**: `C:\wamp64\www\WebProject`

2. Start Apache and MySQL from XAMPP/WAMP control panel

3. Open browser and navigate to:
   ```
   http://localhost/WebProject/
   ```

#### Option B: Using PHP Built-in Server

1. Open terminal/command prompt in the WebProject directory

2. Run:
   ```bash
   php -S localhost:8000
   ```

3. Open browser and navigate to:
   ```
   http://localhost:8000
   ```

## 🎯 Usage

### Search Movies
1. Click on the search box in the header
2. Type at least 2 characters
3. Results will appear in a dropdown below
4. Click any result to see full movie details

### Browse Movies
- **Popular Movies**: Highest-rated movies with multiple reviews
- **Trending Now**: Recently reviewed movies
- **All Movies**: Complete movie catalog

### View Movie Details
1. Click on any movie card
2. A modal will open showing:
   - Movie poster and information
   - Rating and reviews count
   - Plot summary
   - Cast and crew
   - User reviews

## 📁 Project Structure

```
WebProject/
├── api/
│   └── movies.php          # API endpoints for movies
├── config/
│   └── database.php        # Database configuration
├── database/
│   ├── movie_review_schema.sql   # Database schema
│   ├── sample_data.sql            # Sample data
│   ├── useful_queries.sql         # Helpful queries
│   └── README.md                  # Database documentation
├── img/
│   ├── movie-1.jpg to movie-8.jpg
│   ├── popular-movie-1.jpg to popular-movie-8.jpg
│   ├── wonka-movie-poster-5120x2880-13327.jpg
│   └── user.jpg
├── index.html              # Main HTML file
├── style.css               # Stylesheet
├── main.js                 # JavaScript functionality
└── README.md               # This file
```

## 🎨 Customization

### Change Colors
Edit `style.css` and modify the CSS variables:
```css
:root {
    --main-color: #ff007f;      /* Primary color */
    --hover-color: #ff007f;     /* Hover color */
    --body-color: #1e1e2a;      /* Background */
    --container-color: #2d2e37; /* Card background */
    --text-color: #fcfeff;      /* Text color */
}
```

### Add More Movies
1. Add movie images to the `img/` folder
2. Insert movie data into the database:
   ```sql
   INSERT INTO movies (title, release_date, runtime, plot_summary, poster_url, ...)
   VALUES ('Movie Title', '2024-01-01', 120, 'Plot...', 'img/your-image.jpg', ...);
   ```

### Add Reviews
```sql
INSERT INTO reviews (movie_id, user_id, rating, title, review_text)
VALUES (1, 1, 5.0, 
### Movies Not Loading
1. Check if MySQL is running
2. Verify database credentials in `config/database.php`
3. Check browser console for errors (F12)
4. Ensure `api/movies.php` is accessible

### Images Not Showing
1. Verify image paths in the database match actual files
2. Check file permissions on the `img/` folder
3. Ensure images exist in the `img/` directory

### Search Not Working
1. Check browser console for JavaScript errors
2. Verify API endpoint is accessible: `http://localhost/WebProject/api/movies.php?action=get_all`
3. Check PHP error logs

### Database Connection Errors
1. Verify MySQL is running
2. Check database credentials
3. Ensure `movie_review_db` database exists
4. Check PHP PDO extension is enabled

## 📊 Database Information

- **Database Name**: `movie_review_db`
- **Tables**: 20+ tables
- **Sample Data**: 16 movies, 8 users, 40+ reviews
- **Features**: Automated triggers, foreign keys, indexes

See `database/README.md` for detailed database documentation.

## 🌟 Features Breakdown

### Implemented
✅ Search functionality with real-time results  
✅ Popular movies section  
✅ Trending movies section  
✅ All movies catalog  
✅ Movie details modal  
✅ Reviews display  
✅ Responsive design  
✅ Database integration  
✅ RESTful API  

### Future Enhancements
- User authentication and login
- Add review functionality
- Watchlist and favorites
- User profiles
- Advanced filtering (by genre, year, rating)
- Pagination for large movie lists
- Movie trailers integration
- Social sharing features

## 💡 Tips

1. **Performance**: The API uses indexed queries for fast searching
2. **Security**: Always use prepared statements (already implemented)
3. **Scalability**: The database schema supports thousands of movies
4. **SEO**: Meta tags are included for better search engine visibility

## 📝 License

This project is free to use for educational and commercial purposes.

## 🤝 Support

For issues or questions:
1. Check the troubleshooting section
2. Review database documentation in `database/README.md`
3. Check browser console and PHP error logs

---

**Enjoy your MovieHub! 🎬🍿**

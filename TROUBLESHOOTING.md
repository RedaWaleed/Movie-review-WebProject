# 🔧 Database Setup Troubleshooting Guide

## The Error You're Seeing

The error message shows the SQL statement itself, which usually means:
1. The SQL file wasn't executed properly
2. You're seeing the output instead of the result
3. There might be a foreign key constraint issue

---

## ✅ Solution: Follow These Steps

### **Option 1: Use the New Setup Script (Easiest)**

1. **Run the new setup script:**
   ```bash
   setup-database.bat
   ```
   
   This script has your password already configured and better error handling.

---

### **Option 2: Manual Setup via Command Line**

1. **Open Command Prompt** in the WebProject folder

2. **Create the database:**
   ```bash
   mysql -u root -pMaybeReda -e "DROP DATABASE IF EXISTS movie_review_db; CREATE DATABASE movie_review_db;"
   ```

3. **Import the schema:**
   ```bash
   mysql -u root -pMaybeReda movie_review_db < database\movie_review_schema.sql
   ```

4. **Import the sample data:**
   ```bash
   mysql -u root -pMaybeReda movie_review_db < database\sample_data.sql
   ```

5. **Verify it worked:**
   ```bash
   mysql -u root -pMaybeReda movie_review_db -e "SELECT COUNT(*) as movie_count FROM movies;"
   ```

---

### **Option 3: Use phpMyAdmin (Visual)**

1. **Open phpMyAdmin** (usually at `http://localhost/phpmyadmin`)

2. **Create database:**
   - Click "New" in the left sidebar
   - Database name: `movie_review_db`
   - Collation: `utf8mb4_unicode_ci`
   - Click "Create"

3. **Import schema:**
   - Select `movie_review_db` database
   - Click "Import" tab
   - Choose file: `database/movie_review_schema.sql`
   - Click "Go"
   - Wait for success message

4. **Import sample data:**
   - Still in `movie_review_db` database
   - Click "Import" tab
   - Choose file: `database/sample_data.sql`
   - Click "Go"
   - Wait for success message

5. **Verify:**
   - Click "SQL" tab
   - Run: `SELECT * FROM movies;`
   - You should see 16 movies

---

### **Option 4: Step-by-Step Troubleshooting**

If you're still having issues, let's diagnose:

1. **Test MySQL connection:**
   ```bash
   mysql -u root -pMaybeReda -e "SELECT 'Connection works!' as status;"
   ```
   
   ✅ If this works: MySQL is running and password is correct
   ❌ If this fails: Check MySQL is running and password is correct

2. **Check if database exists:**
   ```bash
   mysql -u root -pMaybeReda -e "SHOW DATABASES LIKE 'movie_review_db';"
   ```
   
   ✅ If you see `movie_review_db`: Database exists
   ❌ If empty: Database wasn't created

3. **Check if tables exist:**
   ```bash
   mysql -u root -pMaybeReda movie_review_db -e "SHOW TABLES;"
   ```
   
   ✅ If you see 20+ tables: Schema was imported
   ❌ If empty or error: Schema wasn't imported

4. **Run troubleshooting SQL:**
   ```bash
   mysql -u root -pMaybeReda movie_review_db < database\troubleshoot.sql
   ```

---

## 🚨 Common Issues & Solutions

### Issue 1: "Access denied for user 'root'"
**Solution:** Password is wrong
- Check your MySQL password
- Update `config/database.php` with correct password
- Update setup script with correct password

### Issue 2: "Unknown database 'movie_review_db'"
**Solution:** Database wasn't created
- Run: `mysql -u root -pMaybeReda -e "CREATE DATABASE movie_review_db;"`
- Then import schema again

### Issue 3: "Table 'movies' doesn't exist"
**Solution:** Schema wasn't imported
- Import `database/movie_review_schema.sql` first
- Then import `database/sample_data.sql`

### Issue 4: "Duplicate entry" or "Cannot add foreign key constraint"
**Solution:** Data already exists or tables are in wrong order
- Clear database: `mysql -u root -pMaybeReda -e "DROP DATABASE movie_review_db; CREATE DATABASE movie_review_db;"`
- Import schema first, then data

### Issue 5: SQL shows on screen instead of executing
**Solution:** You're viewing the file instead of executing it
- Don't open the SQL file in a text editor and copy-paste
- Use the command line or phpMyAdmin import feature
- Use the `<` redirect operator: `mysql ... < file.sql`

---

## ✅ Verify Everything Works

After setup, run this command:

```bash
mysql -u root -pMaybeReda movie_review_db -e "SELECT COUNT(*) as movies, (SELECT COUNT(*) FROM reviews) as reviews, (SELECT COUNT(*) FROM users) as users FROM movies;"
```

**Expected output:**
```
+--------+---------+-------+
| movies | reviews | users |
+--------+---------+-------+
|     16 |      40 |     8 |
+--------+---------+-------+
```

---

## 🌐 Test the Website

1. **Start your web server:**
   - XAMPP/WAMP: Start Apache
   - OR run: `php -S localhost:8000`

2. **Test database connection:**
   ```
   http://localhost/WebProject/test-connection.php
   ```
   
   All tests should be ✓ green

3. **Open the website:**
   ```
   http://localhost/WebProject/
   ```
   
   You should see movies loading!

---

## 📞 Still Having Issues?

If none of the above works, please provide:
1. The exact error message you see
2. Which method you tried (command line, phpMyAdmin, etc.)
3. The output of: `mysql -u root -pMaybeReda -e "SELECT VERSION();"`

---

## 🎯 Quick Commands Reference

```bash
# Create database
mysql -u root -pMaybeReda -e "CREATE DATABASE movie_review_db;"

# Import schema
mysql -u root -pMaybeReda movie_review_db < database\movie_review_schema.sql

# Import data
mysql -u root -pMaybeReda movie_review_db < database\sample_data.sql

# Check movies
mysql -u root -pMaybeReda movie_review_db -e "SELECT title FROM movies;"

# Check reviews
mysql -u root -pMaybeReda movie_review_db -e "SELECT COUNT(*) FROM reviews;"

# Reset everything
mysql -u root -pMaybeReda -e "DROP DATABASE IF EXISTS movie_review_db; CREATE DATABASE movie_review_db;"
```

---

**Good luck! Your MovieHub will be running soon! 🎬**

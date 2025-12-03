@echo off
echo ========================================
echo MovieHub - Quick Setup Script
echo ========================================
echo.

REM Check if MySQL is accessible
echo [1/4] Checking MySQL connection...
mysql --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: MySQL is not found in PATH
    echo Please make sure MySQL is installed and added to PATH
    echo Or use phpMyAdmin to import the SQL files manually
    pause
    exit /b 1
)
echo MySQL found!
echo.

REM Prompt for MySQL credentials
echo [2/4] MySQL Setup
set /p MYSQL_USER="Enter MySQL username (default: root): "
if "%MYSQL_USER%"=="" set MYSQL_USER=root

set /p MYSQL_PASS="Enter MySQL password (press Enter if no password): "

echo.
echo [3/4] Creating database and importing schema...
mysql -u %MYSQL_USER% -p%MYSQL_PASS% < database\movie_review_schema.sql
if %errorlevel% neq 0 (
    echo ERROR: Failed to create database schema
    echo Please check your MySQL credentials and try again
    pause
    exit /b 1
)
echo Database schema created successfully!
echo.

echo [4/4] Importing sample data...
mysql -u %MYSQL_USER% -p%MYSQL_PASS% movie_review_db < database\sample_data.sql
if %errorlevel% neq 0 (
    echo ERROR: Failed to import sample data
    pause
    exit /b 1
)
echo Sample data imported successfully!
echo.

echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Update database credentials in config\database.php if needed
echo 2. Start your web server (XAMPP/WAMP) or run: php -S localhost:8000
echo 3. Open http://localhost/WebProject/ in your browser
echo.
echo Enjoy MovieHub!
echo.
pause

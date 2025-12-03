<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MovieHub - Database Test</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e1e2a 0%, #2d2e37 100%);
            color: #fcfeff;
            padding: 2rem;
            min-height: 100vh;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #2d2e37;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        }
        h1 {
            color: #ff007f;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .test-section {
            background: rgba(255,255,255,0.05);
            padding: 1.5rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        .test-section h2 {
            color: #ff007f;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }
        .status {
            padding: 0.8rem;
            border-radius: 0.3rem;
            margin-bottom: 1rem;
        }
        .success {
            background: rgba(0,255,0,0.1);
            border-left: 4px solid #00ff00;
            color: #00ff00;
        }
        .error {
            background: rgba(255,0,0,0.1);
            border-left: 4px solid #ff0000;
            color: #ff0000;
        }
        .info {
            background: rgba(255,255,0,0.1);
            border-left: 4px solid #ffff00;
            color: #ffff00;
        }
        pre {
            background: #1e1e2a;
            padding: 1rem;
            border-radius: 0.3rem;
            overflow-x: auto;
            font-size: 0.9rem;
        }
        .btn {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background: #ff007f;
            color: white;
            text-decoration: none;
            border-radius: 0.5rem;
            margin-top: 1rem;
            transition: 0.3s;
        }
        .btn:hover {
            background: #cc0066;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            padding: 0.8rem;
            text-align: left;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        th {
            background: rgba(255,0,127,0.2);
            color: #ff007f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎬 MovieHub - Database Connection Test</h1>
        
        <?php
        // Test 1: Check if config file exists
        echo '<div class="test-section">';
        echo '<h2>Test 1: Configuration File</h2>';
        if (file_exists('config/database.php')) {
            echo '<div class="status success">✓ Configuration file found</div>';
            require_once 'config/database.php';
        } else {
            echo '<div class="status error">✗ Configuration file not found at config/database.php</div>';
            echo '</div></div></body></html>';
            exit;
        }
        echo '</div>';
        
        // Test 2: Database Connection
        echo '<div class="test-section">';
        echo '<h2>Test 2: Database Connection</h2>';
        try {
            $pdo = getDBConnection();
            echo '<div class="status success">✓ Successfully connected to MySQL database</div>';
            echo '<pre>';
            echo "Host: " . DB_HOST . "\n";
            echo "Database: " . DB_NAME . "\n";
            echo "User: " . DB_USER . "\n";
            echo '</pre>';
        } catch (Exception $e) {
            echo '<div class="status error">✗ Database connection failed</div>';
            echo '<pre>' . htmlspecialchars($e->getMessage()) . '</pre>';
            echo '</div></div></body></html>';
            exit;
        }
        echo '</div>';
        
        // Test 3: Check Tables
        echo '<div class="test-section">';
        echo '<h2>Test 3: Database Tables</h2>';
        try {
            $stmt = $pdo->query("SHOW TABLES");
            $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
            
            if (count($tables) > 0) {
                echo '<div class="status success">✓ Found ' . count($tables) . ' tables in database</div>';
                echo '<pre>' . implode("\n", $tables) . '</pre>';
            } else {
                echo '<div class="status error">✗ No tables found. Please run the schema SQL file.</div>';
            }
        } catch (Exception $e) {
            echo '<div class="status error">✗ Error checking tables</div>';
            echo '<pre>' . htmlspecialchars($e->getMessage()) . '</pre>';
        }
        echo '</div>';
        
        // Test 4: Check Data
        echo '<div class="test-section">';
        echo '<h2>Test 4: Sample Data</h2>';
        try {
            // Check movies
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM movies");
            $movieCount = $stmt->fetch()['count'];
            
            // Check users
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM users");
            $userCount = $stmt->fetch()['count'];
            
            // Check reviews
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM reviews");
            $reviewCount = $stmt->fetch()['count'];
            
            if ($movieCount > 0 && $userCount > 0) {
                echo '<div class="status success">✓ Sample data found</div>';
                echo '<table>';
                echo '<tr><th>Table</th><th>Count</th></tr>';
                echo '<tr><td>Movies</td><td>' . $movieCount . '</td></tr>';
                echo '<tr><td>Users</td><td>' . $userCount . '</td></tr>';
                echo '<tr><td>Reviews</td><td>' . $reviewCount . '</td></tr>';
                echo '</table>';
            } else {
                echo '<div class="status info">⚠ No sample data found. Please run the sample_data.sql file.</div>';
            }
        } catch (Exception $e) {
            echo '<div class="status error">✗ Error checking data</div>';
            echo '<pre>' . htmlspecialchars($e->getMessage()) . '</pre>';
        }
        echo '</div>';
        
        // Test 5: API Endpoint
        echo '<div class="test-section">';
        echo '<h2>Test 5: API Endpoint</h2>';
        if (file_exists('api/movies.php')) {
            echo '<div class="status success">✓ API endpoint file found</div>';
            echo '<p>Test the API:</p>';
            echo '<ul style="margin-left: 2rem; margin-top: 0.5rem;">';
            echo '<li><a href="api/movies.php?action=get_all" target="_blank" style="color: #ff007f;">Get All Movies</a></li>';
            echo '<li><a href="api/movies.php?action=get_popular" target="_blank" style="color: #ff007f;">Get Popular Movies</a></li>';
            echo '<li><a href="api/movies.php?action=search&q=inception" target="_blank" style="color: #ff007f;">Search for "inception"</a></li>';
            echo '</ul>';
        } else {
            echo '<div class="status error">✗ API endpoint file not found</div>';
        }
        echo '</div>';
        
        // Test 6: Sample Movies
        echo '<div class="test-section">';
        echo '<h2>Test 6: Sample Movies</h2>';
        try {
            $stmt = $pdo->query("SELECT title, release_date, average_rating, total_reviews FROM movies LIMIT 5");
            $movies = $stmt->fetchAll();
            
            if (count($movies) > 0) {
                echo '<div class="status success">✓ Successfully retrieved sample movies</div>';
                echo '<table>';
                echo '<tr><th>Title</th><th>Release Date</th><th>Rating</th><th>Reviews</th></tr>';
                foreach ($movies as $movie) {
                    echo '<tr>';
                    echo '<td>' . htmlspecialchars($movie['title']) . '</td>';
                    echo '<td>' . $movie['release_date'] . '</td>';
                    echo '<td>' . number_format($movie['average_rating'], 1) . '/5</td>';
                    echo '<td>' . $movie['total_reviews'] . '</td>';
                    echo '</tr>';
                }
                echo '</table>';
            }
        } catch (Exception $e) {
            echo '<div class="status error">✗ Error retrieving movies</div>';
            echo '<pre>' . htmlspecialchars($e->getMessage()) . '</pre>';
        }
        echo '</div>';
        
        // Final Status
        echo '<div class="test-section" style="text-align: center;">';
        echo '<h2>✅ All Tests Passed!</h2>';
        echo '<p>Your MovieHub database is set up correctly and ready to use.</p>';
        echo '<a href="index.html" class="btn">Go to MovieHub →</a>';
        echo '</div>';
        ?>
    </div>
</body>
</html>

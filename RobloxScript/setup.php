<?php
require 'db.php';

$adminPass = password_hash('admin123', PASSWORD_DEFAULT);
$conn->query("INSERT INTO users (username, password, role) VALUES ('admin', '$adminPass', 'admin')");

$pass1 = password_hash('juan123', PASSWORD_DEFAULT);
$conn->query("INSERT INTO users (username, password, role) VALUES ('juan', '$pass1', 'user')");
$id1 = $conn->insert_id;
$conn->query("INSERT INTO students (user_id, name, section_year, course, address)
              VALUES ($id1, 'Juan Dela Cruz', 'BSIT-2A', 'BS Information Technology', 'Quezon City')");

$pass2 = password_hash('maria123', PASSWORD_DEFAULT);
$conn->query("INSERT INTO users (username, password, role) VALUES ('maria', '$pass2', 'user')");
$id2 = $conn->insert_id;
$conn->query("INSERT INTO students (user_id, name, section_year, course, address)
              VALUES ($id2, 'Maria Clara', 'BSCS-1B', 'BS Computer Science', 'Manila City')");

echo "<h2>✅ Setup complete!</h2>";
echo "Admin → <b>admin</b> / <b>admin123</b><br>";
echo "User → <b>juan</b> / <b>juan123</b><br>";
echo "User → <b>maria</b> / <b>maria123</b><br><br>";
echo "<b style='color:red'>⚠️ Now DELETE setup.php from your folder for security!</b>";
?>
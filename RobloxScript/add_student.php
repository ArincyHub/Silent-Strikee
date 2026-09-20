<?php
require 'db.php';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
$message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name         = trim($_POST['name']);
    $section_year = trim($_POST['section_year']);
    $course       = trim($_POST['course']);
    $address      = trim($_POST['address']);
    $username     = trim($_POST['username']);
    $password     = password_hash($_POST['password'], PASSWORD_DEFAULT); // ENCRYPTED

    $stmt = $conn->prepare("INSERT INTO users (username, password, role) VALUES (?, ?, 'user')");
    $stmt->bind_param("ss", $username, $password);

    if ($stmt->execute()) {
        $user_id = $conn->insert_id;
        $stmt2 = $conn->prepare("INSERT INTO students (user_id, name, section_year, course, address) VALUES (?,?,?,?,?)");
        $stmt2->bind_param("issss", $user_id, $name, $section_year, $course, $address);
        $stmt2->execute();
        $message = "✅ Student saved successfully!";
    } else {
        $message = "❌ Username already exists.";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar">
    <span class="brand">🎓 SIS — Admin Panel</span>
    <span><a href="admin_dashboard.php">← Back to Dashboard</a></span>
</nav>
<div class="container form-card" style="max-width:500px;">
    <h2>Add New Student</h2>
    <?php if ($message) echo "<p class='success'>$message</p>"; ?>
    <form method="POST">
        <label>Full Name</label>
        <input type="text" name="name" required>
        <label>Section / Year</label>
        <input type="text" name="section_year" placeholder="e.g. BSIT-2A" required>
        <label>Course</label>
        <input type="text" name="course" placeholder="e.g. BS Information Technology" required>
        <label>Address</label>
        <input type="text" name="address" required>
        <hr style="margin:15px 0;">
        <label>Username (student login)</label>
        <input type="text" name="username" required>
        <label>Password</label>
        <input type="password" name="password" required>
        <button type="submit" class="btn btn-primary full">💾 Save Student</button>
    </form>
</div>
</body>
</html>
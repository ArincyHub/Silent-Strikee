<?php
require 'db.php';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'user') {
    header("Location: login.php");
    exit();
}
$stmt = $conn->prepare("SELECT * FROM students WHERE user_id = ?");
$stmt->bind_param("i", $_SESSION['user_id']);
$stmt->execute();
$student = $stmt->get_result()->fetch_assoc();
?>
<!DOCTYPE html>
<html>
<head>
    <title>My Information</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar">
    <span class="brand">🎓 Student Portal</span>
    <span>Welcome, <b><?php echo $_SESSION['username']; ?></b> | <a href="logout.php">Logout</a></span>
</nav>
<div class="container" style="max-width:600px;">
    <div class="page-header">
        <h2>My Information</h2>
        <a href="user_edit.php" class="btn btn-edit">✏️ Edit My Info</a>
    </div>
    <?php if ($student): ?>
        <div class="info-row"><span class="info-label">Name</span> <?php echo htmlspecialchars($student['name']); ?></div>
        <div class="info-row"><span class="info-label">Section / Year</span> <?php echo htmlspecialchars($student['section_year']); ?></div>
        <div class="info-row"><span class="info-label">Course</span> <?php echo htmlspecialchars($student['course']); ?></div>
        <div class="info-row"><span class="info-label">Address</span> <?php echo htmlspecialchars($student['address']); ?></div>
    <?php else: ?>
        <p>No record found. Please contact the admin.</p>
    <?php endif; ?>
</div>
</body>
</html>
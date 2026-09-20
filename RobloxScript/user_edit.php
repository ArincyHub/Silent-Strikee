<?php
require 'db.php';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'user') {
    header("Location: login.php");
    exit();
}
$user_id = $_SESSION['user_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $stmt = $conn->prepare("UPDATE students SET name=?, section_year=?, course=?, address=? WHERE user_id=?");
    $stmt->bind_param("ssssi", $_POST['name'], $_POST['section_year'], $_POST['course'], $_POST['address'], $user_id);
    $stmt->execute();
    header("Location: user_dashboard.php");
    exit();
}
$stmt = $conn->prepare("SELECT * FROM students WHERE user_id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$student = $stmt->get_result()->fetch_assoc();
?>
<!DOCTYPE html>
<html>
<head>
    <title>Edit My Info</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar">
    <span class="brand">🎓 Student Portal</span>
    <span><a href="user_dashboard.php">← Back</a></span>
</nav>
<div class="container form-card" style="max-width:500px;">
    <h2>Edit My Information</h2>
    <form method="POST">
        <label>Full Name</label>
        <input type="text" name="name" value="<?php echo htmlspecialchars($student['name']); ?>" required>
        <label>Section / Year</label>
        <input type="text" name="section_year" value="<?php echo htmlspecialchars($student['section_year']); ?>" required>
        <label>Course</label>
        <input type="text" name="course" value="<?php echo htmlspecialchars($student['course']); ?>" required>
        <label>Address</label>
        <input type="text" name="address" value="<?php echo htmlspecialchars($student['address']); ?>" required>
        <button type="submit" class="btn btn-edit full">✏️ Update My Info</button>
    </form>
</div>
</body>
</html>
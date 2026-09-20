<?php
require 'db.php';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
$id = (int) $_GET['id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $stmt = $conn->prepare("UPDATE students SET name=?, section_year=?, course=?, address=? WHERE id=?");
    $stmt->bind_param("ssssi", $_POST['name'], $_POST['section_year'], $_POST['course'], $_POST['address'], $id);
    $stmt->execute();
    header("Location: admin_dashboard.php");
    exit();
}
$stmt = $conn->prepare("SELECT * FROM students WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$student = $stmt->get_result()->fetch_assoc();
?>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar">
    <span class="brand">🎓 SIS — Admin Panel</span>
    <span><a href="admin_dashboard.php">← Back to Dashboard</a></span>
</nav>
<div class="container form-card" style="max-width:500px;">
    <h2>Edit Student</h2>
    <form method="POST">
        <label>Full Name</label>
        <input type="text" name="name" value="<?php echo htmlspecialchars($student['name']); ?>" required>
        <label>Section / Year</label>
        <input type="text" name="section_year" value="<?php echo htmlspecialchars($student['section_year']); ?>" required>
        <label>Course</label>
        <input type="text" name="course" value="<?php echo htmlspecialchars($student['course']); ?>" required>
        <label>Address</label>
        <input type="text" name="address" value="<?php echo htmlspecialchars($student['address']); ?>" required>
        <button type="submit" class="btn btn-edit full">✏️ Update Record</button>
    </form>
</div>
</body>
</html>
<?php
require 'db.php';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
$result = $conn->query("SELECT * FROM students ORDER BY id ASC");
?>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar">
    <span class="brand">🎓 SIS — Admin Panel</span>
    <span>Welcome, <b><?php echo $_SESSION['username']; ?></b> | <a href="logout.php">Logout</a></span>
</nav>
<div class="container">
    <div class="page-header">
        <h2>Student Records</h2>
        <a href="add_student.php" class="btn btn-primary">+ Add New Student</a>
    </div>
    <table>
        <tr><th>ID</th><th>Name</th><th>Section/Year</th><th>Course</th><th>Address</th><th>Action</th></tr>
        <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?php echo $row['id']; ?></td>
            <td><?php echo htmlspecialchars($row['name']); ?></td>
            <td><?php echo htmlspecialchars($row['section_year']); ?></td>
            <td><?php echo htmlspecialchars($row['course']); ?></td>
            <td><?php echo htmlspecialchars($row['address']); ?></td>
            <td>
                <a class="btn btn-edit" href="edit_student.php?id=<?php echo $row['id']; ?>">Edit</a>
                <a class="btn btn-delete" href="delete_student.php?id=<?php echo $row['id']; ?>"
                   onclick="return confirm('Delete this record?')">Delete</a>
            </td>
        </tr>
        <?php endwhile; ?>
    </table>
</div>
</body>
</html>
<?php
require 'db.php';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
$id = (int) $_GET['id'];
$stmt = $conn->prepare("SELECT user_id FROM students WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$row = $stmt->get_result()->fetch_assoc();

if ($row) { // deleting the user cascades and deletes the student record too
    $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
    $stmt->bind_param("i", $row['user_id']);
    $stmt->execute();
}
header("Location: admin_dashboard.php");
exit();
?>
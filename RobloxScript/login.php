<?php
require 'db.php';
$error = "";

if (isset($_SESSION['role'])) { // already logged in
    header("Location: " . ($_SESSION['role'] === 'admin' ? 'admin_dashboard.php' : 'user_dashboard.php'));
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim($_POST['username']);
    $password = $_POST['password'];

    $stmt = $conn->prepare("SELECT id, username, password, role FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {  // checks ENCRYPTED password
            $_SESSION['user_id']  = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['role']     = $user['role'];
            header("Location: " . ($user['role'] === 'admin' ? 'admin_dashboard.php' : 'user_dashboard.php'));
            exit();
        }
    }
    $error = "Invalid username or password.";
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Student Information System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body class="login-body">
    <div class="login-card">
        <h2>🎓 Student Information System</h2>
        <p class="subtitle">Please login to continue</p>
        <?php if ($error) echo "<div class='alert'>$error</div>"; ?>
        <form method="POST">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit" class="btn btn-primary full">LOGIN</button>
        </form>
    </div>
</body>
</html>
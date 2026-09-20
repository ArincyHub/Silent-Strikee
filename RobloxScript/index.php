<?php session_start(); include 'db.php'; 
if(!isset($_SESSION['user'])) { header("Location: login.php"); }
?>
<h2>Student List</h2>
<!-- Add Button for Admin Only -->
<?php if($_SESSION['role'] == 'admin') { echo "<button>Add Student</button>"; } ?>

<table border="1">
    <tr><th>Name</th><th>Section</th><th>Course</th><th>Address</th></tr>
    <?php
    $res = mysqli_query($conn, "SELECT * FROM students");
    while($row = mysqli_fetch_assoc($res)){
        echo "<tr><td>{$row['name']}</td><td>{$row['section_year']}</td><td>{$row['course']}</td><td>{$row['address']}</td></tr>";
    }
    ?>
</table>
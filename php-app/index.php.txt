<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Simple Blog System</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .post { border: 1px solid #ccc; padding: 10px; margin: 10px 0; }
        .post h2 { margin: 0 0 10px; }
        form { margin: 20px 0; }
        label { display: block; margin: 5px 0; }
        input[type="text"], textarea { width: 100%; padding: 5px; }
        button { padding: 10px 15px; background: #5cb85c; color: #fff; border: none; cursor: pointer; }
        button.edit { background: #f0ad4e; }
        button.delete { background: #d9534f; }
    </style>
</head>
<body>

<h1>Simple Blog System</h1>

<?php
include 'db.php';

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['create'])) {
        $title = $_POST['title'];
        $content = $_POST['content'];
        $stmt = $pdo->prepare("INSERT INTO posts (title, content) VALUES (:title, :content)");
        $stmt->execute(['title' => $title, 'content' => $content]);
    } elseif (isset($_POST['update'])) {
        $id = $_POST['id'];
        $title = $_POST['title'];
        $content = $_POST['content'];
        $stmt = $pdo->prepare("UPDATE posts SET title = :title, content = :content WHERE id = :id");
        $stmt->execute(['id' => $id, 'title' => $title, 'content' => $content]);
    }
    header('Location: index.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $stmt = $pdo->prepare("DELETE FROM posts WHERE id = :id");
    $stmt->execute(['id' => $id]);
    header('Location: index.php');
    exit;
}

// Fetch all posts
$stmt = $pdo->query("SELECT * FROM posts ORDER BY created_at DESC");
$posts = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!-- Form for creating and updating posts -->
<form action="index.php" method="post">
    <input type="hidden" name="id" id="postId">
    <label for="title">Title:</label>
    <input type="text" id="title" name="title" required>
    <label for="content">Content:</label>
    <textarea id="content" name="content" required></textarea>
    <button type="submit" name="create" id="createButton">Create</button>
    <button type="submit" name="update" id="updateButton" style="display:none;">Update</button>
</form>

<!-- List of blog posts -->
<?php foreach ($posts as $post): ?>
    <div class="post">
        <h2><?php echo htmlspecialchars($post['title']); ?></h2>
        <p><?php echo nl2br(htmlspecialchars($post['content'])); ?></p>
        <small>Posted on <?php echo $post['created_at']; ?></small>
        <p>
            <button class="edit" onclick="editPost(<?php echo $post['id']; ?>, '<?php echo htmlspecialchars(addslashes($post['title'])); ?>', '<?php echo htmlspecialchars(addslashes($post['content'])); ?>')">Edit</button>
            <a href="index.php?delete=<?php echo $post['id']; ?>"><button class="delete">Delete</button></a>
        </p>
    </div>
<?php endforeach; ?>

<script>
    function editPost(id, title, content) {
        document.getElementById('postId').value = id;
        document.getElementById('title').value = title;
        document.getElementById('content').value = content;
        document.getElementById('createButton').style.display = 'none';
        document.getElementById('updateButton').style.display = 'inline';
    }
</script>

</body>
</html>

<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/models/Product.php';
header('Content-Type: text/html; charset=utf-8');

$productModel = new Product();

// 상품 ID 가져오기
$productId = isset($_GET['id']) ? intval($_GET['id']) : 0;

// 상품 정보 가져오기
$product = $productModel->getProductById($productId);
if (!$product) {
    echo "<script>alert('존재하지 않는 상품입니다.'); location.href='/product/index.php';</script>";
    exit;
}

// 상품 이미지 가져오기
$productImages = $productModel->getProductImages($productId);
$imageUrlArray= array();

// 이미지 분류
foreach ($productImages as $image) {
    $imageUrlArray[] = $image['image_url'];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/public/css/bootstrap.css">
    <link rel="stylesheet" href="/public/css/custom-style.css">
    <title><?php echo htmlspecialchars($product['name']); ?></title>
</head>
<body>
<?php include $_SERVER['DOCUMENT_ROOT'] . '/views/home/header.php'; ?>

<div class="container">
    <a href="/views/product/index.php" class="text-decoration-none text-black">상품 리스트</a>
    <div class="d-flex justify-content-between">
        <!-- 왼쪽: 대표 이미지 및 추가 이미지 선택 -->
        <div class="product-thumbnail mb-3">
            <img id="main-image" src="<?php echo  $imageUrlArray[0]; ?>" alt="대표 이미지" class="img-fluid">
        </div>
        <!-- 오른쪽: 상품 정보 및 구매 -->
        <div class="border-box" style="padding: 20px; background-color: #f9f9f9;">
            <div class="mb-3">
                <h4><?php echo htmlspecialchars($product['name']); ?></h4>
                <p>가격: <strong><?php echo number_format($product['price']); ?>원</strong></p>
            </div>
            <div class="mb-3">
                <label for="quantity">수량</label>
                <input type="number" id="quantity" class="form-control" min="1" value="1" style="width: 100px;" oninput="updateTotal(<?php echo $product['price']; ?>)">
                <p class="mt-2">총 상품 금액: <span id="total-amount" class="text-danger">0원</span></p>
            </div>
            <div class="d-grid gap-2 mb-3">
                <button type="button" class="btn btn-success btn-lg" onclick="location.href='/order/checkout.php?id=<?php echo $productId; ?>'">
                    구매하기
                </button>
            </div>
            <div class="d-flex justify-content-between">
                <button type="button" class="btn btn-outline-secondary btn-lg">찜하기</button>
                <form method="POST" action="/controllers/CartController.php">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="product_id" value="<?= $productId ?>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn btn-primary btn-lg">장바구니</button>
                </form>
            </div>
        </div>
    </div>
    <!-- 추가 이미지 -->
    <div class="thumbnail-images">
        <?php foreach ($imageUrlArray as $imageUrl): ?>
            <img src="<?php echo $imageUrl; ?>" alt="추가 이미지" class="img-thumbnail me-2 mb-2"
                style="width: 80px; height: 80px; cursor: pointer;"
                onclick="changeImage('<?php echo $imageUrl; ?>')">
        <?php endforeach; ?>
    </div>
    <!-- 상품 설명을 구매 섹션 아래로 이동 -->
    <div class="mt-5">
        <div class="description-content">
            <?php echo $product['description']; // HTML 태그 유지 ?>
        </div>
    </div>
</div>

<?php include $_SERVER['DOCUMENT_ROOT'] . '/views/home/footer.php'; ?>
<script src="/public/js/custom/product.js"></script>
</body>
</html>
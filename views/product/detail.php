<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/models/Product.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/models/Wishlist.php';
header('Content-Type: text/html; charset=utf-8');

session_start();

// 모델 불러오기
$productModel = new Product();
$wishlistModel = new Wishlist();


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
$imageUrlArray = array();

// 이미지 분류
foreach ($productImages as $image) {
    $imageUrlArray[] = $image['image_url'];
}

// 로그인 여부 확인
$isLoggedIn = isset($_SESSION['user']);
$uid = $isLoggedIn ? $_SESSION['user']['uid'] : null;

// 찜 상태 확인
$isInWishlist = false;
if ($isLoggedIn) {
    $isInWishlist = $wishlistModel->isProductInWishlist($uid, $productId);
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
<?php include $_SERVER['DOCUMENT_ROOT'] . '/views/main/header.php'; ?>
<div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cartModalLabel">알림</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>장바구니에 상품을 담았습니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">계속 쇼핑</button>
                <a href="/views/user/cart/index.php" class="btn btn-primary">장바구니로</a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <a href="/views/product/index.php" class="btn btn-secondary mb-4">뒤로 가기</a>
    <div class="d-flex justify-content-between">
        <!-- 왼쪽: 대표 이미지 및 추가 이미지 선택 -->
        <div class="product-thumbnail mb-3">
            <img id="main-image" src="<?php echo $imageUrlArray[0]; ?>" alt="대표 이미지" class="img-fluid">
        </div>
        <!-- 오른쪽: 상품 정보 및 구매 -->
        <div class="border-box" style="padding: 20px; background-color: #f9f9f9;">
            <div class="mb-1">
                <h4 id="product_name"><?php echo htmlspecialchars($product['name']); ?></h4><br>
                <p id ="product_price" class="price">가격: <strong><?php echo number_format($product['price']); ?>원</strong></p>
            </div>
            <div class="mb-3">
                <label for="quantity">수량</label>
                <input
                        type="number"
                        id="quantity"
                        name="quantity"
                        class="form-control"
                        min="1"
                        value="1"
                        style="width: 100px;"
                        oninput="updateTotal(<?php echo $product['price']; ?>)">
                <p class="mt-2">총 상품 금액: <span id="total-price"
                                               class="text-danger"><?php echo $product['price']; ?>원</span></p>
            </div>
            <div class="d-grid gap-2 mb-3">
                <button type="button" class="btn btn-outline-primary"
                        onclick="addToCart(<?= $product['id'] ?>, parseInt(document.getElementById('quantity').value || 1), 'redirect')">
                    <i class="bi bi-upc-scan"></i> 구매하기
                </button>
            </div>
            <div class="d-flex justify-content-between">
                <?php if ($isLoggedIn): ?>
                    <?php if ($isInWishlist): ?>
                        <button class="btn btn-outline-secondary" onclick="removeFromWishlist(<?= $productId ?>)">
                            <i class="bi bi-heart-fill"></i> 찜 취소
                        </button>
                    <?php else: ?>
                        <button class="btn btn-outline-danger" onclick="addToWishlist(<?= $productId ?>)">
                            <i class="bi bi-heart"></i> 찜하기
                        </button>
                    <?php endif; ?>
                <?php else: ?>
                    <button class="btn btn-outline-primary" onclick="promptLogin()">
                        <i class="bi bi-person"></i> 찜하기
                    </button>
                <?php endif; ?>
                <button
                        type="button"
                        class="btn btn-outline-success"
                        data-bs-toggle="modal" data-bs-target="#cartModal"
                        onclick="addToCart(<?php echo $product['id']; ?>, parseInt(document.getElementById('quantity').value || 1), 'modal')">
                    <i class="bi bi-cart-plus"></i> 장바구니에 추가
                </button>
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
        <div class="">
            <?php echo $product['description']; // HTML 태그 유지 ?>
        </div>
    </div>
    <!-- 댓글 작성할 예정
    <div class="mt-4">
        <h5>댓글 <//?php echo count($comments); ?>개</h5>
        <//?php if (!empty($comments)): ?>
            <ul class="list-group mb-4">
                <//?php foreach ($comments as $comment): ?>
                    <li class="list-group-item d-flex justify-content-between">
                        <div>
                            <strong><//?php echo htmlspecialchars($comment['username']); ?></strong><br>
                            <span><//?php echo htmlspecialchars($comment['content']); ?></span><br>
                            <small class="text-muted">작성일: <//?php echo $comment['created_at']; ?></small>
                        </div>
                    </li>
                <//?php endforeach; ?>
            </ul>
        <//?php else: ?>
            <p>댓글이 없습니다.</p>
        <//?php endif; ?>
    </div>-->
</div>

<?php include $_SERVER['DOCUMENT_ROOT'] . '/views/main/footer.php'; ?>
<script src="/public/js/custom/cart.js"></script>
<script src="/public/js/custom/product.js"></script>
</body>
</html>
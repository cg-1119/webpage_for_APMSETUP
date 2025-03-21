<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/config/database.php';

class OrderDetail
{
    private $db;

    public function __construct()
    {
        $this->db = new Database();
    }

    // 1. 주문 상세 추가
    public function setOrderDetail($orderId, $productId, $quantity, $price)
    {
        try {
            $pdo = $this->db->connect();
            $stmt = $pdo->prepare("INSERT INTO order_details (order_id, product_id, quantity, price) 
                VALUES (:order_id, :product_id, :quantity, :price)");
            return $stmt->execute([
                'order_id' => $orderId,
                'product_id' => $productId,
                'quantity' => $quantity,
                'price' => $price
            ]);
        } catch (PDOException $e) {
            error_log("OrderDetail Model setOrderDetail Exception", $e->getMessage());
            return false;
        }
    }

    // 특정 주문의 상세 정보 조회
    public function getOrderDetailsByOrderId($orderId)
    {
        try {
            $pdo = $this->db->connect();
            $stmt = $pdo->prepare("
           SELECT 
            od.product_id, 
            od.quantity, 
            od.price AS price,
            p.name AS product_name, 
            pi.file_path AS product_image,
            pi.is_thumbnail
        FROM 
            order_details od
        JOIN 
            products p ON od.product_id = p.id
        LEFT JOIN 
            product_images pi ON p.id = pi.product_id AND pi.is_thumbnail = 1 -- 썸네일 이미지 우선
        WHERE 
            od.order_id = :orderId;
        ");
            $stmt->execute(['orderId' => $orderId]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            error_log("OrderDetail Model getOrderDetailsByOrderId Exception: " . $e->getMessage());
            return false;
        }
    }
}

<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/config/database.php';

class Payment
{
    private $db;

    public function __construct()
    {
        $this->db = new Database();
    }

    // 결제 데이터 추가
    public function setPayment($orderId, $paymentMethod, $paymentInfo, $paymentPrice)
    {
        $pdo = $this->db->connect();
        try {
            $stmt = $pdo->prepare("INSERT INTO payments (order_id, payment_method, payment_info, payment_price) 
                VALUES (:order_id, :payment_method, :payment_info, :payment_price)");
            $stmt->execute([
                'order_id' => $orderId,
                'payment_method' => $paymentMethod,
                'payment_info' => $paymentInfo,
                'payment_price' => $paymentPrice
            ]);
            return $pdo->lastInsertId();
        } catch (PDOException $e) {
            echo "Payment Model setPayment Exception: " . $e->getMessage();
            return false;
        }
    }

    // 주문 상태 변경
    public function setOrderStatus($orderId, $status)
    {
        $pdo = $this->db->connect();
        try {
            $stmt = $pdo->prepare("UPDATE orders SET status = :status WHERE id = :orderId");
            $stmt->bindParam(":orderId", $orderId, PDO::PARAM_INT);
            $stmt->bindParam(":status", $status);
            return $stmt->execute();
        } catch (PDOException $e) {
            echo "Payment Model setOrderStatus Exception: " . $e->getMessage();
            return false;
        }

    }

    // 특정 주문의 결제 정보 조회
    public function getPaymentByOrderId($orderId)
    {
        $pdo = $this->db->connect();
        try {
            $stmt = $pdo->prepare("SELECT * FROM payments WHERE order_id = :order_id");
            $stmt->execute(['order_id' => $orderId]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Payment Model getPaymentByOrderId Exception: " . $e->getMessage();
            return false;
        }
    }
}

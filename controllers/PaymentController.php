<?php
require_once $_SERVER['DOCUMENT_ROOT'] . "/models/Payment.php";
header('Content-Type: text/html; charset=utf-8');
class PaymentController
{
    private $paymentModel;
    public function __construct()
    {
        $this->paymentModel = new Payment();
    }

    public function addPayment()
    {
        try
        {
            $orderId = $_POST["orderId"] ?? null;
            $paymentMethod = $_POST["paymentMethod"] ?? null;
            $paymentPrice = $_POST["paymentPrice"] ?? null;
            $paymentInfo = $_POST["paymentInfo"] ?? null;

            $this->paymentModel->addPayment($orderId, $paymentMethod, $paymentPrice, $paymentInfo);
            return ['success' => true, 'message' => '결제가 성공적으로 처리되었습니다.'];

        }catch (Exception $e){
            error_log("addPayment error: " . $e->getMessage());
            return ['success' => false, 'message' => '결제 처리 중 오류가 발생했습니다.'];
        }
    }
    public function getPaymentByOrderId($orderId)
    {
        try
        {
            return $this->paymentModel->getPaymentByOrderId($orderId);
        } catch (Exception $e){
            error_log("getPaymentByOrderId error: " . $e->getMessage());
            return null;
        }
    }
    public function getAllPayments()
    {
        try
        {
            $payments = $this->paymentModel->getAllPayments();
            return $payments;
        } catch (Exception $e){
            error_log("getAllPayments error: " . $e->getMessage());
            return null;
        }
    }
}

// 요청 처리
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $controller = new PaymentController();

    if ($_POST["action"] === "addPayment") $controller->addPayment();
    else if ($_POST["action"] === "getPaymentByOrderId") $controller->getPaymentByOrderId($_POST["orderId"]);
    else if ($_POST["action"] === "getAllPayments") $controller->getAllPayments();
}
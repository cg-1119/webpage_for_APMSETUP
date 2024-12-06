<?php
require_once $_SERVER['DOCUMENT_ROOT'] . "/config/database.php";

class User {
    private $db;

    public function __construct() {
        $this->db = new Database();
    }

    // 사용자 등록
    public function setUser($id, $pw, $name, $email, $phone, $address) {
        $pdo = $this->db->connect();

        try {
            $stmt = $pdo->prepare("INSERT INTO users (id, pw, name, email, phone, address) VALUES (:id, :pw, :name, :email, :phone, :address)");
            $stmt->bindParam(':id', $id, PDO::PARAM_STR);
            $stmt->bindParam(':pw', $pw, PDO::PARAM_STR);
            $stmt->bindParam(':name', $name, PDO::PARAM_STR);
            $stmt->bindParam(':email', $email, PDO::PARAM_STR);
            $stmt->bindParam(':phone', $phone, PDO::PARAM_STR);
            $stmt->bindParam(':address', $address, PDO::PARAM_STR);
            return $stmt->execute();
        } catch (PDOException $e) {
            error_log("Register User Error: " . $e->getMessage());
            return false;
        }
    }

    // 사용자 조회
    public function getUserByUid($uid) {
        $pdo = $this->db->connect();

        try {
            $stmt = $pdo->prepare("SELECT * FROM users WHERE uid = :uid");
            $stmt->bindParam(':uid', $uid, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } catch (PDOException $e) {
            error_log("getUserByUid error: " . $e->getMessage());
        }
    }
    // 배송지 변경
    public function setUserAddressByUid($uid, $address) {
        $pdo = $this->db->connect();

        try {
            $stmt = $pdo->prepare("UPDATE users SET address = :address WHERE uid = :uid");
            $stmt->bindParam(':uid', $uid, PDO::PARAM_INT);
            $stmt->bindParam(':address', $address, PDO::PARAM_STR);
            $result = $stmt->execute();
            $this->refreshSessionData($uid);
            return $result;
        } catch (PDOException $e) {
            error_log("Get User Error: " . $e->getMessage());
        }
    }

    // 세션 정보 최신화
    private function refreshSessionData($uid) {
        $pdo = $this->db->connect();

        try {
            $stmt = $pdo->prepare("SELECT * FROM users WHERE uid = :uid");
            $stmt->bindParam(':uid', $uid, PDO::PARAM_INT);
            $stmt->execute();

            session_start();
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            if ($user) $_SESSION['user'] = $user;
        } catch (PDOException $e) {
            error_log("유저 정보 불러오기 오류" . $e->getMessage());
        }
    }

    // 개인정보 중복 체크
    public function checkDuplicate($id, $phone) {
        $pdo = $this->db->connect();

        try {
            $stmt = $pdo->prepare("SELECT phone FROM users WHERE id = :id AND phone = :phone");
            $stmt->bindParam(':id', $id, PDO::PARAM_STR);
            $stmt->bindParam(':phone', $phone, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Check Duplicate Error: " . $e->getMessage());
            return false;
        }
    }

    // 아이디 찾기
    public function queryToFindId($name, $phone) {
        $pdo = $this->db->connect();

        try {
            $stmt = $pdo->prepare("SELECT id FROM users WHERE name = :name AND phone = :phone");
            $stmt->bindParam(':name', $name, PDO::PARAM_STR);
            $stmt->bindParam(':phone', $phone, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Query To Find ID Error: " . $e->getMessage());
            return null;
        }
    }

    // 비밀번호 찾기
    public function queryToResetPw($id, $name) {
        $pdo = $this->db->connect();

        try {
            $stmt = $pdo->prepare("SELECT id FROM users WHERE id = :id AND name = :name");
            $stmt->bindParam(':id', $id, PDO::PARAM_STR);
            $stmt->bindParam(':name', $name, PDO::PARAM_STR);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            return $result ? $result : null;
        } catch (PDOException $e) {
            error_log("Query To Reset Password Error: " . $e->getMessage());
            return null;
        }
    }

    // 비밀번호 업데이트
    public function updatePassword($id, $newPassword) {
        $pdo = $this->db->connect();

        try {
            // 비밀번호 해싱 (SHA-256)
            $hashedPassword = hash('sha256', $newPassword);

            $stmt = $pdo->prepare("UPDATE users SET pw = :pw WHERE id = :id");
            $stmt->bindParam(':pw', $hashedPassword, PDO::PARAM_STR);
            $stmt->bindParam(':id', $id, PDO::PARAM_STR);
            return $stmt->execute();
        } catch (PDOException $e) {
            error_log("Update Password Error: " . $e->getMessage());
            return false;
        }
    }
}
?>
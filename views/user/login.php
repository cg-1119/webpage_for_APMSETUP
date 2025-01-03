<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="/public/css/bootstrap.css">
    <link rel="stylesheet" href="/public/css/custom-style.css">
</head>

<body>
<?php
include $_SERVER['DOCUMENT_ROOT'] . '/views/main/header.php';
?>
<div class="container mt-5">
    <div class="d-flex justify-content-center"><h2 class="m-5">로그인</h2></div>
    <form class="needs-validation" method="POST" action="/controllers/LoginController.php" novalidate>
        <div class="mt-5 d-flex flex-column justify-content-center">
            <div class="border-box">
                <div style="padding:24px; width: 100%;">
                    <div class="has-validation">
                        <input type="text" class="form-control " name="id" id="idValidation"
                               placeholder="ID"
                               required>
                        <div class="invalid-feedback">
                            아이디를 입력해 주세요.
                        </div>
                    </div>
                    <div class="has-validation">
                        <input type="password" class="mt-4 form-control" name="password" id="pwValidation"
                               placeholder="비밀번호" required>
                        <div class="invalid-feedback">
                            비밀번호를 입력해 주세요.
                        </div>
                    </div>
                    <input class ="form-control" type="hidden" name="action" value="login">
                    <button type="submit" class="mt-5 btn btn-secondary" style="width: 100%;">로그인</button>
                </div>
            </div>
        </div>
    </form>
    <div class="mt-2 d-flex justify-content-center" style="width: 100%">
        <a class="nav-link text-secondary" href="join/agree.php">회원가입</a>
        <span class="link-border"></span>
        <a class="nav-link text-secondary" href="find/find_id.php">아이디 찾기</a>
        <span class="link-border"></span>
        <a class="nav-link text-secondary" href="find/find_pw.php">비밀번호 찾기</a>
    </div>
</div>

<script src="../../public/js/custom/validation.js"></script>
<?php
include $_SERVER['DOCUMENT_ROOT'] . '/views/main/footer.php';
?>
</body>

</html>
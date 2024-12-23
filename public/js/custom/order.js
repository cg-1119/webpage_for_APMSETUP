// 포인트 유효성
function validatePointInput(pointInput) {
    const max = parseInt(pointInput.max);
    const min = parseInt(pointInput.min);
    const value = parseInt(pointInput.value);

    if (value > max) {
        pointInput.value = max; // max 값을 초과하면 max로 설정
    } else if (value < min || isNaN(value)) {
        pointInput.value = min;
    }
}
// 사용 포인트 값 전달 함수
function updatePointData(pointInput) {
    const usedPoint = pointInput.value;
    const paymentButton = document.querySelector('button[data-point]');
    if (paymentButton) {
        paymentButton.setAttribute('data-point', usedPoint);
    }
}

// 최종 금액 계산
function updateFinalPrice(pointInput) {
    const totalPriceText = document.getElementById('totalPrice').textContent;
    const totalPrice = parseInt(totalPriceText.replace(/[^0-9]/g, ''), 10); // 쉼표 제거 후 숫자로 변환

    let usedPoints = parseInt(pointInput.value, 10) || 0;
    // 최종 금액 계산
    const finalPrice = totalPrice - usedPoints;

    // DOM 업데이트
    document.getElementById('point').textContent = new Intl.NumberFormat('ko-KR').format(Math.round(finalPrice / 100)) + ' 원'; // 적립 예정 포인트
    document.getElementById('finalPrice').textContent = new Intl.NumberFormat('ko-KR').format(finalPrice) + ' 원'; // 최종 결제 금액
    document.getElementById('submitFinalPrice').setAttribute('data-finalPrice', finalPrice); // 결제 금액 데이터 전달
}

// 유효성, 포인트 값 전달, 금액 계산 핸들링 함수
function pointInputChange(pointInput) {
    validatePointInput(pointInput);
    updatePointData(pointInput);
    updateFinalPrice(pointInput);
}

// 결제 수단 변경
function togglePaymentFields(selectedMethod) {
    document.querySelectorAll('.payment-fields').forEach(field => field.classList.add('d-none'));
    if (selectedMethod === 'card') {
        document.getElementById('cardFields').classList.remove('d-none');
    } else if (selectedMethod === 'phone') {
        document.getElementById('phoneFields').classList.remove('d-none');
    } else if (selectedMethod === 'account') {
        document.getElementById('accountFields').classList.remove('d-none');
    }
}

// 주문 생성 함수
function createOrder(data) {
    const uid = data.getAttribute('data-user');
    const cart = JSON.parse(data.getAttribute('data-cart'));
    let address = '';
    let phone = '';
    const finalPrice = data.getAttribute('data-finalPrice')

    const useDefaultAddress = document.querySelector('input[name=address]:checked').value

    // 배송지 값 설정
    if (useDefaultAddress) {
        address = document.getElementById('default-address').textContent;
        phone = document.getElementById('default-phone').textContent;
    } else {
        address = document.querySelector('input[name="address"].form-control').value;
        phone = document.querySelector('input[name="phone"]').value;
    }

    const formData = new FormData();
    formData.append('action', 'createOrder');
    formData.append('uid', uid);
    formData.append('address', address || '기본 주소');
    formData.append('phone', phone || '기본 전화번호');
    formData.append('cart', JSON.stringify(cart));
    formData.append('finalPrice', finalPrice)

    return fetch('/controllers/OrderController.php', {
        method: 'POST',
        body: formData,
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // 데이터를 특정 ID를 가진 DOM 요소에 저장
                const orderDataElement = document.getElementById('orderData')
                orderDataElement.setAttribute('data-order-id', data.orderId);
                orderDataElement.setAttribute('data-user-id', data.userId);
                orderDataElement.setAttribute('data-final-price', data.finalPrice);
                return data;
            } else {
                alert('주문 생성 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('주문 생성 오류:', error);
        });
}

// 결제 정보 제출
function submitCheckout(orderId, userId, finalPrice) {
    const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
    const paymentInfo = document.querySelector(`#${paymentMethod}Fields input`).value;
    const point = document.querySelector('input[name="point"]').value;

    // 결제 데이터 서버로 전송
    fetch('/controllers/PaymentController.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            action: 'addPayment',
            orderId: orderId,
            userId: userId,
            paymentPrice: finalPrice,
            point: point,
            paymentMethod: paymentMethod,
            paymentInfo: paymentInfo
        })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                localStorage.removeItem('cart'); // 장바구니 초기화
                alert('결제가 완료되었습니다!');
                window.location.href = `/views/order/order_complete.php?orderId=${data.orderId}`;
            } else {
                alert('결제 실패: ' + data.message);
            }
        })
        .catch(error => console.error('결제 처리 오류:', error));
}

// 테이블 생성 핸들링 함수
function createOrderPayment(data) {
    createOrder(data)
        .then(orderData => {
            submitCheckout(orderData.orderId, orderData.userId, orderData.finalPrice);
        })
        .catch(error => {
            console.error('주문, 결제 처리 오류', error);
            alert(error.message);
        });
}
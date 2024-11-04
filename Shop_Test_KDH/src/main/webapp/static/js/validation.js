/**
 *  유효성 검사 
 */
function checkProduct() {
	let form = document.product
	let productId = form.productId
	let name = form.name
	let unitPrice = form.unitPrice
	let unitsInStock = form.unitsInStock
	
	let msg = ''
	
	// 상품아이디 체크
	// - P숫자 6자리
	let productIdCheck = /^P[0-9]{6}$/
	msg = '상품 아이디는 "P6자리" 로 입력해주세요' 
	if( !check(productIdCheck, productId, msg) ) return false
	
	// 상품명 체크
	// - 2글자 이상 20글자 이하
	let nameCheck = /^.{2,20}$/
	msg = '상품명은 2~20자 이내로 입력해주세요'
	if( !check(nameCheck, name, msg) ) return false
	
	// 가격 체크
	// - 숫자로 1글자 이상
	let priceCheck = /^\d{1,}$/
	msg = '가격은 1글자 이상의 숫자로 입력해주세요'
	if( !check(priceCheck, unitPrice, msg) ) return false
	
	// 재고 체크
	// - 숫자로 1글자 이상
	let stockCheck = /^\d{1,}$/
	msg = '재고는 1글자 이상의 숫자로 입력해주세요'
	if( !check(stockCheck, unitsInStock, msg) ) return false
	
	return true
}



function checkProduct1() {
    const productCode = document.querySelector('input[name="code"]').value;
    const codePattern = /^p\d{6}$/; // p로 시작하고 뒤에 6자리 숫자

    if (!codePattern.test(productCode)) {
        alert("상품 코드는 'p'로 시작하고 6자리 숫자로 구성되어야 합니다. 예: p123456");
        return false; // 폼 제출 중단
    }

    // 다른 검사가 필요하다면 추가

    return true; // 모든 검사가 통과되면 폼 제출
}

function checkAccount() {
	// 정규 표현식 설정
	const idPattern = /^[a-zA-Z가-힣][a-zA-Z가-힣0-9]*$/; // 아이디: 영문 또는 한글로 시작
	const passwordPattern = /^(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,}$/; // 비밀번호: 특수문자 1개 이상 포함, 6자 이상
	const namePattern = /^[가-힣]+$/; // 이름: 한글만 입력

	    // 각 입력 필드의 유효성 검사
	    if (!check(idPattern, form.id, "아이디는 영문 또는 한글로 시작해야 합니다.")) {
	        return false;
	    }
	    if (!check(passwordPattern, form.pw, "비밀번호는 영문, 숫자, 특수문자만 사용하고 특수문자를 최소 1개 포함하여 6자 이상이어야 합니다.")) {
	        return false;
	    }
	    if (!check(namePattern, form.name, "이름은 한글만 입력해야 합니다.")) {
	        return false;
	    }
	    return true; // 모든 필드가 유효한 경우 폼 제출 허용
	}
	

// 정규표현식 유효성 검사 함수
function check(regExp, element, msg) {
	
	if( regExp.test(element.value) ) {
		return true
	}
	alert(msg)
	element.select()
	element.focus()
	return false
}
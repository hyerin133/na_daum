<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(() => {
	$(enrollModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${empty header.referer || header.referer.contains('/member/memberLogin.do') ? pageContext.request.contextPath : header.referer}';
		});
});
</script>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="enrollModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원가입</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form
					id="memberEnrollFrm"
					method="post">
					<div class="modal-body">	
						<label for="id">아이디</label>						
						<input
							type="text" class="form-control" name="id" id="id" value="sinsa"
							placeholder="영문으로 시작하고 숫자포함 4자리 이상 20자리 이하만 사용 가능합니다." required>
						<span class="text-success guide ok">이 아이디는 사용가능합니다.</span>
						<span class="text-danger guide error">이 아이디는 사용불가능합니다.</span>
						<input type="hidden" id="idValid" value="0" />
						<br /> 
						<label for="password">비밀번호</label>
						<input
							type="password" class="form-control" name="password" id="password" value="1234"
							placeholder="비밀번호는 숫자, 영어포함 8 ~ 15자리 사이 입니다." required>
						<br /> 
						<label for="passwordCheck">비밀번호 확인</label>
						<input
							type="password" class="form-control" id="passwordCheck" value="1234"
							placeholder="비밀번호 확인" required>
						<span class="text-danger pw-error">비밀번호가 일치하지 않습니다.</span>
						<br /> 
						<label for="name">이름</label>
						<input
							type="text" class="form-control" name="name" id="name" value="신사임당"
							placeholder="이름" required>
						<span class="text-danger name-error">한글만 입력 가능합니다.</span>
						<br /> 
						<label for="nickname">별명</label>
						<input
							type="text" class="form-control" name="nickname" id="nickname" value="신사"
							placeholder="별명" required>
						<span class="text-danger nickname-error">한글과 영어 숫자만 사용 가능합니다.</span>
						<br /> 
						<label for="email">이메일</label>
						<input
							type="text" id="email" value="jae6140"
							placeholder="이메일" required>@
						<input type="text" id="selfWrite" />
						<input type="hidden" name="email" id="addEmail" required/>
						<select id="siteSelect">
							<option value="">선택</option>
							<option value="self">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="google.com">구글</option>
						</select>
						<br /> 
						<!-- <div class="phone-wrap">
							<input type="text" />
						</div> -->
						<div class="address-wrap">
							<input type="text" id="postcode" readonly="readonly"/>
							<input type="button" class="address_button" onclick="findAddress()" value="주소검색"><br />
							<input type="text" id="allAddress" class="form-control" readonly="readonly"/><br />
							<input type="text" id="detailAddress" class="form-control" readonly="readonly"/>
							<input type="hidden" name="address" class="form-control addAddress" required />
						</div>
					</div>
					<div class="modal-footer">
						<div>
							<input type="submit" class="btn btn-outline-success enroll" value="회원가입">
							<button type="button" class="btn btn-outline-danger" data-dismiss="modal">닫기</button>
						</div>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		</div>
	</div>
	
<script>
$(memberEnrollFrm).submit((e) => {
	
	if($(addEmail).val() == ''){
		return false;
	}
	
	if($(".addAddress").val() == ''){
		$(".address_button").focus();
		return false;
	}
});

// 이메일
$(selfWrite).hide();

$(siteSelect).change(() => {
	if($(siteSelect).val() == 'self'){
		$(selfWrite).show();
	}else{
		$(selfWrite).hide();
	}
	
	$(addEmail).val($(email).val() + '@' + $(siteSelect).val())
	
});

$(selfWrite).blur(() => {
	$(addEmail).val($(email).val() + '@' + $(selfWrite).val());
});


// 비밀번호 검사
const $pwError = $(".pw-error");
$pwError.hide();
$(passwordCheck).blur((e) => {
	const $password = $(password);
	const $passwordCheck = $(passwordCheck);
	
	if($password.val() != $passwordCheck.val()){
		$pwError.show();
	}
});

// 아이디 중복 검사
const $idError = $(".guide.error");
const $idOk = $(".guide.ok");
$idError.hide();
$idOk.hide();
$(id).keyup((e) => {
	const idVal = $(e.target).val();	
	const $idValid = $(idValid);
	
	if(idVal.length < 4){
		$(".guide").hide();
		$idValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
		data:{
			id: idVal
		},
		success(resp){
			console.log(resp);
			const {available} = resp;
			if(available){
				$idError.hide();
				$idOk.show();
				$idValid.val(1);
			}else{
				$idError.show();
				$idOk.hide();
				$idValid.val(0);
			}
		},
		error: console.log
	});
});

// 주소 합치기
$(detailAddress).blur((e) => {
	$(".addAddress").val($(allAddress).val() + ' ' + $(detailAddress).val());
});

// 카카오 우편번호 서비스
//http://postcode.map.daum.net/guide
function findAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
        	
        	 var addr = ''; // 주소 변수
             var extraAddr = ''; // 참고항목 변수

             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                 addr = data.roadAddress;
             } else { // 사용자가 지번 주소를 선택했을 경우(J)
                 addr = data.jibunAddress;
             }

             // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
             if(data.userSelectedType === 'R'){
                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                     extraAddr += data.bname;
                 }
                 // 건물명이 있고, 공동주택일 경우 추가한다.
                 if(data.buildingName !== '' && data.apartment === 'Y'){
                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                 }
                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                 if(extraAddr !== ''){
                     extraAddr = ' (' + extraAddr + ')';
                 }
                 // 조합된 참고항목을 해당 필드에 넣는다.
                 addr += extraAddr;
             
             } else {
                 addr += ' ';
             }

             // 우편번호와 주소 정보를 해당 필드에 넣는다.
             $("#postcode").val(data.zonecode);
             $("#allAddress").val(addr);
             // 커서를 상세주소 필드로 이동한다.
             $("#detailAddress")
             	.attr('readonly', false)
             	.focus();
        }
    }).open();
}
</script>

</body>
</html>
//자바스크립트 
/*공통*/
//타이머 함수
//1입력시 회원가입페이지 2입력시 비밀번호찾기 3입력시 아이디찾기로 타임아웃시 이동페이지 설정
function timer(number) {
	
	$("#timer").attr("placeholder", "인증번호 확인 3:00");
	let min = 2;
	let sec = 59;
	interver = setInterval(function() {
		if ($(".getConfirmNumber").val() == confirmCode) {
			clearInterval(interver);
			return
		} else {
			if (min === 0 && sec === 0) {
				confirmCode = 0;
				alert("인증시간 초과")
				
				switch (number) {
					case 1:
						location.href = "index.jsp?main=login/joinForm.jsp"
						break;
					case 2:
						location.href = "index.jsp?main=login/findPwForm.jsp"
						break;

					case 3:
						location.href = "index.jsp?main=login/findEmailForm.jsp"
						break;
				}
			}
			if (sec === 0) {
				$("#timer").attr("placeholder", "인증번호 확인 " + min + ":00");
				--min;
				sec = 60;
			} else {
				if (sec < 10) {
					$("#timer").attr("placeholder", "인증번호 확인 " + min + ":0" + sec);
				} else {
					$("#timer").attr("placeholder", "인증번호 확인 " + min + ":" + sec);
				}
			}
			sec--;
		}
	}, 900);
}




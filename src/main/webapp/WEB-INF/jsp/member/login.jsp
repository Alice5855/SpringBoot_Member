<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	html,
	body {
	  width: 100%;
	  height: 100%;
	}
	
	body {
	  display: flex;
	  align-items: center;
	  padding-top: 40px;
	  padding-bottom: 40px;
	  background-color: #f5f5f5;
	  justify-content: center
	}
	
	.form-signin {
	  max-width: 330px;
	  padding: 15px;
	}
	
	.form-signin .form-floating:focus-within {
	  z-index: 2;
	}
	
	.form-signin input[type="text"] {
	  margin-bottom: -1px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	
	.form-signin input[type="password"] {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
	
</style>
<main class="form-signin w-100 m-auto">
	<form id="loginForm" name="loginForm" class="form-signin text-center">
		<h2 class="h3 mb-3 fw-normal">Please sign in</h2>
		
		<div class="form-floating">
			<input type="text" id="memberId" name="memberId" class="form-control" placeholder="ID" required autofocus>
			<label for="memberId">ID</label>
		</div>
		<div class="form-floating">
			<input type="password" id="memberPw" name="memberPw" class="form-control" placeholder="Password" required>
			<label for="memberPw">Password</label>
		</div>
		
		<button class="btn btn-lg btn-primary w-100 mb-2" type="button" onclick="javascript:fn_signIn();">Sign in</button>
		<button class="btn btn-lg btn-info w-100" type="button" onclick="javascript:fn_signUp();">Sign up</button>
	</form>
</main>

<script>
	var submitYN = false;

	<%-- 로그인 --%>
	function fn_signIn(){

		if(document.getElementById("memberId").value.length < 1){
			alert("아이디를 입력하세요.");
			document.getElementById("memberId").focus()
			return;
		}
		
		if(document.getElementById("memberPw").value.length < 1){
			alert("비밀번호를 입력하세요.");
			document.getElementById("memberPw").focus()
			return;
		}
		
		if(!submitYN){
			submitYN = true;
			
			$.ajax({
				 url :"/loginAction.do"
				,type:"post"
				,data:$("#loginForm").serialize()
				,success:function(data){
					if(data != "N"){
						alert(data + "회원님, 환영합니다");
						location.href="/selectMemberList.do?page=0&size=10"
					}else{
						alert("회원정보 가입을 해주세요");
					}
				}
			    ,error: function(xhr, status, error){
			    	alert("에러발생");
			    }
			    ,complete : function() {
			    	submitYN = false;
			    }
			    
			});
			
		}
		
	}

	<%-- 멤버등록화면으로 이동 --%>
	function fn_signUp(){
		location.href = "/fwdMemberReg.do";
	}

</script>
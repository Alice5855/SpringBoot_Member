<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.input-group{
		margin-top: 25px;
	}
	.img-wrapper{
		width: 150px;
		height: 180px;
	}
	.img-wrapper img{
		object-fit: cover;
	}
</style>
<div class="container">
	<div>
		<form id="insertForm" name="insertForm" method="post" enctype="multipart/form-data">
			<div class="input-group">
				<div class="img-wrapper">
					<img class="rg_i Q4LuWd" id="userImage" src="./defaultpic.png" data-atf="true" width="150" height="" onerror="this.src='images/defaultpic.png'">
				</div>
				<div class="col-12 mt-3">
					<label for="userImageAttachFile" class="btn btn-secondary btn-sm">
					    Browse <input type="file" class="form-control-file" id="userImageAttachFile" name="userImageAttachFile" hidden="hidden" onchange="setThumbnail(event);" />
					</label>
				</div>
			</div>
			<div class="input-group">
				<span class="input-group-text" id="basic-addon1">이름</span>
				<input type="text" id="memberName" name="memberName" class="form-control" placeholder="한글로 공백없이 입력해주세요." aria-describedby="basic-addon1">
			</div>
			<div class="input-group">
				<span class="input-group-text" id="basic-addon1">이메일</span>
				<input type="text" id="memberEmail" name="memberEmail" class="form-control" placeholder="이메일을 입력하세요." aria-describedby="basic-addon1">
			</div>
			<div class="input-group">
				<span class="input-group-text" id="basic-addon1">휴대전화</span>
				<input type="text" id="memberPhoneNumber" name="memberPhoneNumber" class="form-control" placeholder="휴대전화를 입력하세요." aria-describedby="basic-addon1">
			</div>
			<div class="input-group">
				<span class="input-group-text" id="basic-addon1">아이디</span>
				<input type="text" id="memberId" name="memberId" class="form-control" placeholder="아이디를 입력하세요." aria-describedby="basic-addon1">
			</div>
			<div class="input-group">
				<span class="input-group-text" id="basic-addon1">비밀번호</span>
				<input type="password" id="memberPw" name="memberPw" class="form-control" placeholder="비밀번호를 입력해 주세요." aria-describedby="basic-addon1">
			</div>
			<div class="input-group">
				<span class="input-group-text" id="basic-addon1">비밀번호 확인</span>
				<input type="password" id="memberPw2" name="memberPw2" class="form-control" placeholder="비밀번호를 한번 더 입력하세요." aria-describedby="basic-addon1">
			</div>
			<div class="input-group">
				<span class="input-group-text" id="basic-addon1">주소</span>
				<input type="text" id="memberAddress" name="memberAddress" class="form-control" placeholder="주소를 선택하세요." aria-describedby="basic-addon1" readonly="readonly">
				<span class="input-group-btn">
					<button class="btn btn-secondary" type="button" onclick="javascript:fn_openAddressPopup();">Search</button>
				</span>
			</div>
			<div class="input-group mt-0">
				<span class="input-group-text" id="basic-addon1">나머지 주소</span>
				<input type="text" id="memberAddress2" name="memberAddress2" class="form-control" placeholder="나머지 주소를 입력하세요." aria-describedby="basic-addon1">
			</div>
		</form>
	</div>

	<div style="margin-top:15px;">
		<div>
			<button type="button" class="btn btn-md btn-success pull-right" onclick="javascript:fn_submit();">저장</button>
			<button type="button" class="btn btn-md btn-warning pull-right" onclick="javascript:history.go(-1);">목록</button>
		</div>
	</div>
		
</div>

<script>
	<%-- 등록 --%>
	function fn_submit(){
		if(fn_validation()){
			return;
		}
		
		var f = document.insertForm;
		f.action = "/insertMember.do";
		f.submit();
	}

	<%-- 주소검색 팝업 호출 --%>
	function fn_openAddressPopup(){
		var url = "/fwdSearchAddressPopup.do";
		var name = "AddressPopup";
		var option = "width=650, height=500, top=100, left=200, location=no"
		window.open(url, name, option);
	}
	
	<%-- 주소검색 팝업 호출 CallBack --%>
	function callback_openAddressPopup(aParam){
		document.getElementById("memberAddress").value = aParam["roadAddr"];
	}

	<%-- 유효성 검사 --%>
	function fn_validation(){

		var emailReg = /@/gi;
		var phoneNumberReg = /^[0-9]+$/;
		
		if(!emailReg.test(document.getElementById("memberEmail").value)){
			alert("이메일 주소는 '@'가 필수로 입력되어야 합니다'");
			document.getElementById("memberEmail").focus();
			return true;
		}else if(document.getElementById("memberPw").value.length < 1 || document.getElementById("memberPw2").value.length < 1){
			alert("비밀번호 입력하세요.");
			return true;
		}else if(document.getElementById("memberPw").value != document.getElementById("memberPw2").value){
			alert("비밀번호 일치하지않습니다.");
			document.getElementById("memberPw2").focus();
			return true;
		}else if(!phoneNumberReg.test(document.getElementById("memberPhoneNumber").value)){
			alert("휴대전화는 숫자만 입력 가능합니다.");
			document.getElementById("memberPhoneNumber").focus();
			return true;
		}
		
		return false;
	}

	<%-- 이미지 업로드시 이미지 미리보기 --%>
	function setThumbnail(event) { 
		var reader = new FileReader();

		reader.onload = function(event) { 
			document.getElementById("userImage").setAttribute("src", event.target.result);
		};

		reader.readAsDataURL(event.target.files[0]); 
	}
</script>
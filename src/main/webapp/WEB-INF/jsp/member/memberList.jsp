<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	#memberSearchDiv {
		animation: ease;
	}
	.imgwrapper {
		width: 75px;
		height: 75px;
		overflow: hidden;
	}
	.imgwrapper img {
		height: 100%;
		object-fit: cover;
	}
	.tsize1{
		min-width: 45px;
	}
	.tsize2{
		min-width: 60px;
	}
	
	#custom-cards {
	  	padding-top: 3rem !important;
	}
	.card {
	  	background-size: cover;
	  	background-repeat: no-repeat;
	  	background-position: center;
	}
</style>

<main class="col-md-9 m-sm-auto col-lg-10 px-md-4">
	<div class="container-fluid">
	
		<div class="container px-4 py-5" id="custom-cards">
			<div class="row align-items-stretch g-4">
				<div>
					<div class="card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" style="background-image: url('images/carina_nebula.jpg');">
						<div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
							<h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold ms-3">COMPANY NAME</h2>
							<ul class="d-flex list-unstyled mt-auto">
								<li class="me-auto">
									<img src="images/logo9.png" alt="Logo" width="36" height="36" class="rounded-circle">
								</li>
								<li class="d-flex align-items-center me-3">
									<small class="pname">Tacky Slogan</small>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- fill something card or jumbotron idk -->
	
		<div id="memberSearchDiv" class="w-100 mb-3" style="display:none;">
			<form id="searchForm" name="searchForm" method="post" class="" role="search">
				<input type="hidden" id="page" name="page" value="" />
				<input type="hidden" id="size" name="size" value="10" />
				<div class="form-group col-6" style="display:inline-block;">
					<input type="text" id="memberName" name="memberName" class="form-control" placeholder="Search">
				</div>
				<div class="float-end">
					<button type="submit" class="btn btn-secondary" onclick="javascript:fn_searchSubmit();">Search</button>
				</div>
			</form>
		</div>
		<%--
		<div class="table-responsive">
			<table class="table table-sm table-bordered table-striped caption-top">
				<caption>List of users</caption>
				<thead class="table-dark text-center">
					<tr>
						<th>check<!-- <input type="checkbox" onclick="javascript:fn_checkboxAllCheck(this);"/> --></th>
						<th class="tsize1">순번</th>
						<th class="tsize2">이름</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>회원사진</th>
					</tr>
				</thead>
				<tbody class="text-center">
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="6" class="text-center">조회된 데이터 없음</td>
						</tr>
					</c:if>
					<c:if test="${not empty resultList}">
						<c:forEach items="${resultList}" var="result" varStatus="status">
							<tr>
								<td><input type="checkbox" name="chooseRecord"/></td>
								<td class="tsize1">${status.count}
									<input type="hidden" id="memberIdx_${status.index}" name="memberIdx" value="${result.memberIdx}" />
								</td>
								<td class="tsize2">${result.memberName}</td>
								<td>${result.memberEmail}</td>
								<td>${result.memberPhoneNumber}</td>
								<td>
									<c:set var="fullURL" value="${pageContext.request.requestURL}"></c:set>
									<c:set var="pathURI" value="${pageContext.request.requestURI}"></c:set>
									<c:set var="baseURL" value="${fn:replace(fullURL, pathURI, '')}"></c:set>
									<div class="imgwrapper">
										<img src="${baseURL}/${result.fileName}" onerror='this.src="images/defaultpic.png"'/>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		--%>
		
		<div class="list-group w-auto">
			<c:if test="${empty resultList}">
				<a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
					<div class="imgwrapper">
							<img src="images/defaultpic.png" />
						</div>
					<div class="d-flex gap-2 w-100 justify-content-between">
						<div>
							<p class="mb-0 opacity-75">조회된 데이터 없음</p>
						</div>
					</div>
				</a>
			</c:if>
			<c:if test="${not empty resultList}">
				<c:forEach items="${resultList}" var="result" varStatus="status">
					<a href="/fwdMemberUpt.do?memberIdx=${result.memberIdx}" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
						<c:set var="fullURL" value="${pageContext.request.requestURL}"></c:set>
						<c:set var="pathURI" value="${pageContext.request.requestURI}"></c:set>
						<c:set var="baseURL" value="${fn:replace(fullURL, pathURI, '')}"></c:set>
						<div class="imgwrapper">
							<img src="${baseURL}/${result.fileName}" onerror='this.src="images/defaultpic.png"'/>
						</div>
						<div class="d-flex gap-2 w-100 justify-content-between">
							<div>
								<h6 class="mb-0">${result.memberName}</h6>
								<p> Number : ${status.count}
									<input type="hidden" id="memberIdx_${status.index}" name="memberIdx" value="${result.memberIdx}" /></p>
								<p class="mb-0 opacity-75">${result.memberEmail}</p>
								<p class="mb-0 opacity-75">${result.memberPhoneNumber}</p>
							</div>
							<small class="opacity-50 text-nowrap"><input type="checkbox" name="chooseRecord"/></small>
						</div>
					</a>
				</c:forEach>
			</c:if>
		</div>
		
		
		<div class="text-center mt-2">
			<c:set var="startPage" value="${pagingVO.startPage}" />
			<c:set var="endPage" value="${pagingVO.endPage}" />
			<c:set var="totalPage" value="${pagingVO.totalPage}" />
			<nav>
				<ul class="pagination justify-content-center">
					<c:if test="${result.number > result.size}">
						<li class="page-item">
							<a href="javascript:fn_goPage('${startPage - 1}');" class="page-link" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
					   	</li>
					</c:if>
				   	<c:forEach var="i" begin="${startPage}" end="${endPage}">
				   		<c:if test="${i eq result.number}">
							<li class="page-item active">
								<a href="javascript:fn_goPage('${i}');" class="page-link">${i}</a>
							</li>
				   		</c:if>
				   		<c:if test="${i ne result.number}">
							<li class="page-item">
								<a href="javascript:fn_goPage('${i}');" class="page-link">${i}</a>
							</li>
				   		</c:if>
					</c:forEach>
					<c:if test="${endPage != totalPage}">
						<li class="page-item">
							<a href="javascript:fn_goPage('${endPage + 1}');" class="page-link" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
		
		<div class="mb-5">
			<button type="button" class="btn btn-md btn-primary pull-right" onclick="javascript:fn_reg();">등록</button>
			<button type="button" class="btn btn-md btn-info pull-right" onclick="javascript:fn_search();">검색</button>
			<button type="button" class="btn btn-md btn-danger pull-right" onclick="javascript:fn_delete();">삭제</button>
			<%--
			<button type="button" class="btn btn-md btn-warning pull-right" onclick="javascript:fn_update();">관리</button>
			--%>
		</div>
	
	</div>
</main>

<form id="detailForm" name="detailForm" method="post">
	<input type="hidden" id="memberIdxs" name="memberIdxs" value="" />
</form>
<script>

	<%-- 페이징_페이지 이동 --%>
	function fn_goPage(page){
		var f = document.searchForm;
		f.page.value = page;
		f.action = "/selectMemberList.do";
		f.submit();
	}

	<%-- 체크박스 모든선택 --%>
	function fn_checkboxAllCheck(obj){
		var chooseRecords = document.getElementsByName("chooseRecord");
		for(var i=0; i<chooseRecords.length; i++){
			chooseRecords[i].checked = obj.checked;
		}
	}

	<%-- 등록으로 이동 --%>
	function fn_reg(){
		location.href = "/fwdMemberReg.do";
	}

	<%-- 검색창 --%>
	function fn_search(){
		var memberSearchDiv = document.getElementById("memberSearchDiv");
		
		if(memberSearchDiv.style.display == "none"){
			memberSearchDiv.style.display = "inline-block";
		}else{
			memberSearchDiv.style.display = "none";
		}
		
	}

	<%-- 검색 --%>
	function fn_searchSubmit(){
		var f = document.searchForm;
		f.action = "/selectMemberList.do";
		f.submit();
	}

	
	
	<%-- 삭제 --%>
	function fn_delete(){
		var memberIdxs = [];
		var chooseRecordCount = 0;
		var chooseRecords = document.getElementsByName("chooseRecord");
		
		for(var i=0; i<chooseRecords.length; i++){
			if(chooseRecords[i].checked){
				chooseRecordCount++;
				memberIdxs.push(document.getElementsByName("memberIdx")[i].value);
			}
		}

		if(chooseRecordCount < 1){
			alert("데이터를 선택하세요.");
			return;
		}
		
		var f = document.detailForm;
		f.memberIdxs.value = memberIdxs;
		f.action = "/deleteMember.do";
		f.submit();
	}
	

	<%-- 수정페이지 이동 --%>
	function fn_update(){
		var chooseRecordCount = 0;
		var chooseRecords = document.getElementsByName("chooseRecord");
		
		for(var i=0; i<chooseRecords.length; i++){
			if(chooseRecords[i].checked){
				chooseRecordCount++;
			}
		}

		if(chooseRecordCount < 1){
			alert("데이터를 선택하세요.");
			return;
			
		}

		var memberIdx = 0;
		var memberIdxs = document.getElementsByName("memberIdx");
		if(chooseRecordCount > 1){
			alert("2개 이상 선택이기 때문에 첫번째 데이터값으로 이동합니다.");
			for(var i=0; i<chooseRecords.length; i++){
				chooseRecords[i].checked = false;
			}
			chooseRecords[0].checked = true;
			memberIdx = 0;
		}else{
			for(var i=0; i<chooseRecords.length; i++){
				if(chooseRecords[i].checked){
					memberIdx = i;
					break;
				}
			}
		}

		location.href = "/fwdMemberUpt.do?memberIdx="+memberIdxs[memberIdx].value;
	}
</script>
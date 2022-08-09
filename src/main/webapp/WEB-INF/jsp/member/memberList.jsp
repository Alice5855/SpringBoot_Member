<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container" style="margin-top:25px;">

	<div id="memberSearchDiv" class="text-center" style="display:none;float:right;">
		<form id="searchForm" name="searchForm" method="post" class="navbar-form navbar-left" role="search">
			<input type="hidden" id="page" name="page" value="" />
			<input type="hidden" id="size" name="size" value="10" />
			<div class="form-group">
				<input type="text" id="memberName" name="memberName" class="form-control" placeholder="Search">
			</div>
			<button type="submit" class="btn btn-default" onclick="javascript:fn_searchSubmit();">Search</button>
		</form>
	</div>
	
	<div class="">
		<table class="table table-bordered table-striped caption-top">
			<caption>List of users</caption>
			<thead class="table-dark">
				<tr>
					<th><input type="checkbox" onclick="javascript:fn_checkboxAllCheck(this);"/></th>
					<th>순번</th>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>회원사진</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty resultList}">
					<tr>
						<td colspan="6" class="text-center">조회된 데이터 없음</td>
					</tr>
				</c:if>
				<c:if test="${not empty resultList}">
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr>
							<td><input type="checkbox" name="chooseRecord"/></td>
							<td>${status.count}
								<input type="hidden" id="memberIdx_${status.index}" name="memberIdx" value="${result.memberIdx}" />
							</td>
							<td>${result.memberName}</td>
							<td>${result.memberEmail}</td>
							<td>${result.memberPhoneNumber}</td>
							<td>
								<c:set var="fullURL" value="${pageContext.request.requestURL}"></c:set>
								<c:set var="pathURI" value="${pageContext.request.requestURI}"></c:set>
								<c:set var="baseURL" value="${fn:replace(fullURL, pathURI, '')}"></c:set>
								<img src="${baseURL}/${result.fileName}" width="" height="150" onerror='this.src="https://lh3.googleusercontent.com/proxy/mprsbp2upgHJarhPI4371ivf-3l2Eso7-_XVQTniwrVT7MT82pF-hNY3XtQcG0xDcZkv5uh9jTC38jMUTDN5ghmroGw34xm6tB7n4vQsXN9AWgwVkvjofKYUO6KFxdsvDmiKnMGuyb9o8ve9XX9DIb6CYolVCGUuEwvLHRW-vqknWOI_ZmnSo8KFI-zNe-y6dfE"'/>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>	
	</div>
	
	<div class="text-center">
		<c:set var="startPage" value="${pagingVO.startPage}" />
		<c:set var="endPage" value="${pagingVO.endPage}" />
		<c:set var="totalPage" value="${pagingVO.totalPage}" />
		<nav>
			<ul class="pagination">
				<c:if test="${result.number > result.size}">
					<li>
						<a href="javascript:fn_goPage('${startPage - 1}');" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
				   	</li>
				</c:if>
			   	<c:forEach var="i" begin="${startPage}" end="${endPage}">
			   		<c:if test="${i eq result.number}">
						<li class="active"><a href="javascript:fn_goPage('${i}');">${i}</a></li>
			   		</c:if>
			   		<c:if test="${i ne result.number}">
						<li><a href="javascript:fn_goPage('${i}');">${i}</a></li>
			   		</c:if>
				</c:forEach>
				<c:if test="${endPage != totalPage}">
					<li>
						<a href="javascript:fn_goPage('${endPage + 1}');" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
					</li>
				</c:if>
			</ul>
		</nav>
	</div>
	
	<div>
		<button type="button" class="btn btn-md btn-primary pull-right" onclick="javascript:fn_reg();">등록</button>
		<button type="button" class="btn btn-md btn-info pull-right" onclick="javascript:fn_search();">검색</button>
		<button type="button" class="btn btn-md btn-danger pull-right" onclick="javascript:fn_delete();">삭제</button>
		<button type="button" class="btn btn-md btn-warning pull-right" onclick="javascript:fn_update();">관리</button>
	</div>

</div>

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
			memberSearchDiv.style.display = "block";
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
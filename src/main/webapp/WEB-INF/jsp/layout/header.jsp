<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var ="context"><%=request.getContextPath()%></c:set>
<!-- Bootstrap core CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">

<style>
	.bd-placeholder-img {
	  font-size: 1.125rem;
	  text-anchor: middle;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  user-select: none;
	}
	
	@media (min-width: 768px) {
	  .bd-placeholder-img-lg {
	    font-size: 3.5rem;
	  }
	}
	
	.b-example-divider {
	  height: 3rem;
	  background-color: rgba(0, 0, 0, .1);
	  border: solid rgba(0, 0, 0, .15);
	  border-width: 1px 0;
	  box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
	}
	
	.b-example-vr {
	  flex-shrink: 0;
	  width: 1.5rem;
	  height: 100vh;
	}
	
	.bi {
	  vertical-align: -.125em;
	  fill: currentColor;
	}
	
	.nav-scroller {
	  position: relative;
	  z-index: 2;
	  height: 2.75rem;
	  overflow-y: hidden;
	}
	
	.nav-scroller .nav {
	  display: flex;
	  flex-wrap: nowrap;
	  padding-bottom: 1rem;
	  margin-top: -1px;
	  overflow-x: auto;
	  text-align: center;
	  white-space: nowrap;
	  -webkit-overflow-scrolling: touch;
	}
</style>
    
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>

<header class="pt-3 pb-1 mb-3 border-bottom">
	<div class="container-fluid d-grid gap-3 align-items-center" style="grid-template-columns: 1fr 2fr;">
		<div class="dropdown">
			<a href="${context}/selectMemberList.do" class="d-flex align-items-center col-lg-4 mb-2 mb-lg-0 link-dark text-decoration-none" aria-expanded="false">
				<img src="images/logo2.png" alt="Logo" width="90" height="" class="">
			</a>
		</div>

		<div class="d-flex align-items-center justify-content-end">
			<!-- 
			<form class="w-100 me-3" role="search">
				<input type="search" class="form-control" placeholder="Search..." aria-label="Search">
	        </form>
	        -->
			<div class="flex-shrink-0">
				<button class="btn btn-secondary btn-md" onclick="location.href='${context}/'">Sign Out</button>
	        </div>
	    </div>
	</div>
</header>
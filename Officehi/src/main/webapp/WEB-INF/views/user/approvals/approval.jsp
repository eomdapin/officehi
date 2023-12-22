<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:url var="resPath" value="/resources" />
<c:url var="context" value="/" />
<c:set var="login" value="false" />
<c:if test="${loginUser.userNo != approval.userNo}">
	<c:set var="login" value="true" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결재 문서 상세</title>
<link rel="icon" type="image/x-icon" href="<c:url value='/resources/img/favicon.ico'/>" />
<link href="${resPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${resPath}/css/reset.css" rel="stylesheet">
<link href="${resPath}/css/layout.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
<style type="text/css">
form {
	font-size: 16px;
	font-weight: bold;
	line-height: 16px;
}
.aside ul span {
color: #222;
}

.aside ul span.selected {
	font-weight: 800;
	color: #345de3;
}

.table-group-divider tr td a {
	color: #222;
}

.pagination nav ul li a {
	color: #222;
}
</style>
</head>
<body>
	<%@ include file="../../header/header.jsp"%>
	<main>
		<div class="main-container">
			<div class="aside-box">
				<ul class="aside floating">
					<li>
					<span>공지사항</span>
						<ul>
							<li><a href="#"><span>공지사항 조회</span></a></li>
						</ul>
					</li>
					<li><span>전자 결재</span>
						<ul>
							<li><a href="${context}approvals"><span class="selected">결재 현황 조회</span></a></li>
							<li><a href="${context}approvals/add"><span>결재 문서 작성</span></a></li>
						</ul></li>
					<li><span>근태 관리</span>
						<ul>
							<li><a href="#"><span>출퇴근 시간 기록</span></a></li>
							<li><a href="#"><span>근무 시간 확인</span></a></li>
						</ul></li>
					<li><a href="#"><span>마이페이지</span></a></li>
				</ul>
			</div>
			<div class="main-box">
				<div class="content-box floating">
					<h2>결재 문서 상세</h2>
					<form:form modelAttribute="approval" id="approvalForm" action="${context}approvals/${approval.approvalNo}" method="post">
						<div class="row mb-3">
							<div class="col-2">
								<label class="form-label mt-2" for="category">서식</label>
							</div>
							<div class="col-3">
								<form:input path="category" cssClass="form-control" value="${approval.category}" readonly="${login}" />
							</div>
							<div class="col-2 mb-2">	
								<label class="form-label mt-2" for="checker">참조자</label>
							</div>
							<div class="col">
								<c:choose>
									<c:when test="${loginUser.userNo == approval.userNo && loginUser.admin == 0 && approval.status == 1}">
										<form:select path="checker1" class="form-select">
											<form:option value="${approval.checker1}" selected="true" />
											<form:options items="${userList}" itemValue="name" itemLabel="name"/>
										</form:select>
									</c:when>
									<c:when test="${loginUser.userNo != approval.userNo}">
										<form:input path="checker1" class="form-control" readonly="true" />
									</c:when>
								</c:choose>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-2 mt-2">
								<label class="form-label" for="title">문서 제목</label>
							</div>
							<div class="col">
								<form:input path="title" cssClass="form-control" value="${approval.title}" readonly="${login}" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-2">
								<label class="form-label mt-2" for="date">기안일</label>
							</div>
							<div class="col-3">
								<input type="date" id="date" name="date" value="${approval.date}" class="form-control" readonly />
							</div>
							<c:if test="${approval.checkDate != '9999-01-01'}">
								<div class="col-2 mb-2">	
									<label class="form-label mt-2" for="checkDate">완료일</label>
								</div>
								<div class="col">
									<input type="date" id="checkDate" name="checkDate" value="${approval.checkDate}" class="form-control" readonly />
								</div>
							</c:if>
						</div>
						<div class="row mb-3">
							<div class="">
								<label class="form-label" for="content">내용</label>
							</div>
							<div class="">
								<form:textarea path="content" cssClass="form-control w-100" style="height: 400px; resize: none;" readonly="${login}" />
							</div>
						</div>
						<div>
							<c:choose>
								<c:when test="${loginUser.userNo == approval.userNo && loginUser.admin == 0 && approval.status == 1}">
									<button class="btn btn-dark btn-small me-2" style="display: ${display};" type="submit">수정</button>
								</c:when>
								<c:when test="${loginUser.userNo != approval.userNo && loginUser.admin == 0 && approval.status == 1}">
									<a class="btn btn-dark btn-small me-2" onClick="javascript:updateApproval(${context}, ${approval.approvalNo}, 3)">승인</a>
									<a class="btn btn-dark btn-small me-2" onClick="javascript:updateApproval(${context}, ${approval.approvalNo}, 2)">반려</a>
								</c:when>
							</c:choose>
							<a class="btn btn-white btn-outline-dark btn-small" onClick="history.back()">뒤로 가기</a>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="../../footer/footer.jsp"%>
	<script src="${resPath}/js/approval.js" type="text/javascript"></script>
</body>
</html>
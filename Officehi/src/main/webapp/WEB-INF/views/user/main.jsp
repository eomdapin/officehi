<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="resPath" value="/resources" />
<c:url var="context" value="/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오피스하이 - 메인</title>
<link rel="icon" type="image/x-icon" href="<c:url value='/resources/img/favicon.ico'/>" />
<script type="text/javascript" src="${resPath}/js/time.js"></script>
<link href="${resPath}/css/reset.css" rel="stylesheet">
<link href="${resPath}/css/layout.css" rel="stylesheet">
<link href="${resPath}/css/layout-sub.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body id="main" onload="getTime()">
	<%@ include file="../header/header.jsp" %>
	<main>
		<div class="main-container">
			<div class="aside-box">
				<div class="aside floating">
					<div class="profile-box">
						<div class="profile-image-box">
							<%-- <img src="${user.profile}" alt="프로필 이미지"> --%>
							<img src="${resPath}/img/calender.svg" alt="프로필 이미지">
						</div>
						<span>영업부</span>
						<p><span>이미자</span> <span>팀장</span></p>
					</div>
				</div>
				<div class="aside floating quick-menu-bar">
					<div class="quick-menu">
						<a href="#">
							<img class="quick-menu-icon" src="${resPath}/img/mypage.svg" alt="마이페이지">
							<span>마이페이지</span>
						</a>
					</div>
					<div class="quick-menu">
						<a href="#">
							<img class="quick-menu-icon" src="${resPath}/img/approval.svg" alt="전자 결재">
							<span>전자 결재</span>
						</a>
					</div>
					<div class="quick-menu mt">
						<a href="#">
							<img class="quick-menu-icon" src="${resPath}/img/work.svg" alt="근태 관리">
							<span>근태 관리</span>
						</a>
					</div>
					<div class="quick-menu mt">
						<a href="#">
							<img class="quick-menu-icon" src="${resPath}/img/notice.svg" alt="공지사항">
							<span>공지사항</span>
						</a>
					</div>
				</div>
			</div>
			<div class="main-box">
				<div class="notice-wrapper">
					<a href="#" class="notice-box floating">공지사항</a>
					<a href="#" class="notice-title floating">편리하고 효율적인 그룹웨어 OfficeHi 모두 이용해 주세요!</a>
				</div>
				<div class="content-box-wrapper">
					<div class="content-box wrapping-2 floating">
						<h3>결재 현황</h3>
						<table>
							<tbody>
								<tr>
									<td>홍길동</td>
									<td><a href="#">2023-12-24 휴가신청 홍길동</a></td>
									<td>2023.12.14</td>
								</tr>
								<tr>
									<td>홍길동</td>
									<td><a href="#">2023-12-24 휴가신청 홍길동</a></td>
									<td>2023.12.14</td>
								</tr>
								<tr>
									<td>홍길동</td>
									<td><a href="#">2023-12-24 휴가신청 홍길동</a></td>
									<td>2023.12.14</td>
								</tr>
								<tr>
									<td>홍길동</td>
									<td><a href="#">2023-12-24 휴가신청 홍길동</a></td>
									<td>2023.12.14</td>
								</tr>
								<tr>
									<td>홍길동</td>
									<td><a href="#">2023-12-24 휴가신청 홍길동</a></td>
									<td>2023.12.14</td>
								</tr>
								<tr>
									<td>홍길동</td>
									<td><a href="#">2023-12-24 휴가신청 홍길동</a></td>
									<td>2023.12.14</td>
								</tr>
								<tr>
									<td>홍길동</td>
									<td><a href="#">2023-12-24 휴가신청 홍길동</a></td>
									<td>2023.12.14</td>
								</tr>
							</tbody>
						</table>
						<div class="link-box approvals">
							<a href="${context}approvals">
								<span>결재 문서 더보기</span>
							</a>
						</div>
					</div>
					<div class="content-box wrapping-2 floating">
						<h3>근태 관리</h3>
						<div class="time-box">
							<span id="currentTime"></span>
						</div>
						<form action="" method="post">
							<div class="work-btn-box">
								<button type="submit" class="start-btn">출근</button>
								<button type="submit" class="end-btn">퇴근</button>
							</div>
						</form>
						<div class="link-box works">
							<a href="${context}works">
								<span>근무시간 확인</span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="../footer/footer.jsp" %>
</body>
</html>
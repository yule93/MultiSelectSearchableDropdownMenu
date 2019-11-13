<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ include file="/include.jsp" %>

<head>
	<link rel="stylesheet" type="text/css" href="<c:url value="/ref/css/base.css?ver=0.123153" />" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/ref/css/jquery/immybox/immybox.css" /> " />
	<style>
		/* 20191107 만짐 */
		.selectMenu {
			bottom: 0;
		}

		.selectMenu input[type=text] {
			width: 119px;
			font-size: 12px;
			position: absolute;
			float: left;
		}
		.selectMenu .selectMenu-content {
			cursor: pointer;
			display:none;
			width: 119px;
			font-size: 12px;
			position: absolute;
			z-index: 800;
		}

		.selectMenu .selectMenu-content {

			-moz-box-shadow: 0 1px 0 #e0e0e0;
			-webkit-box-shadow: 0 1px 0 #e0e0e0;
			box-shadow: 0 2px 0 #e0e0e0;
		}

		.selectMenu input[type=checkbox] {
			padding: 10px 5px 0 5px;
		}

		.selectMenu li {
			width: 100px;
			border: 1px solid #eee;
			background-color: white;
			padding: 0;
		}
		.selectMenu label {
			display: inline-block;
			width: 150px;
			padding: 0 3px 0 3px;
			height: auto;
		}
		.selectMenu li:hover, label:hover {
			cursor: pointer;
			background-color: #e1e1e1;
		}

		.selectMenu .selectOption {
			border: 1px solid #ccc;
			width: 119px;
			max-height: 180px;
			margin-top: 20px;
			overflow:auto;
		}

		.show {
			display: block;
		}
		.hide {
			display:none;
		}
	</style>
	<script type="text/javascript">
	$(document).ready(function(){
	});
	
	// (1) 클릭 시 드롭다운박스 나타나는/사라지는 함수
	$(function() {
	    $('#selectedOption').on('click', function() {
	        $('#selectMenu-content').show(); //show textbox
	    });
	    window.onclick = function(e) {
	      if ( !e.target.matches('#selectedOption') ) {
			$('#selectMenu-content').hide();
	      }
	    }
	    document.getElementById("selectMenu-content").addEventListener('click',function(event){
	        event.stopPropagation();			// 인터넷 익스플로러에서 안 먹힘
	    });
	});
	// 여기까지 (1) 끝
	
	// (2) all 체크박스 체크 시 모든 박스 체크 or 체크 해제
	$(function() {
		$('#selectAll').click(function() {
			var ChildChkBoxes = document.getElementsByName("dropChk");
			if ($(this).is(':checked')) {
		        for (i = 0; i < ChildChkBoxes.length; i++) {
		            ChildChkBoxes[i].checked = document.forms[0].selectAll.checked;
		        }
			}
			else {
				for (i = 0; i < ChildChkBoxes.length; i++) {
					ChildChkBoxes[i].checked = false;
				}
			}
		});
	});
	// 여기까지 (2) 끝
	
	// (3) 선택한 값 텍스트 박스에 표기	
	$(function() {
		$('.dropChk').click(function(){
		    var text = "";
		    $('.dropChk:checked').each(function(){
		    	if(text.length <= 15) {
		    		text += $(this).val()+", ";
			    }
			    else {
			    	text = text.substring(0,text.length-1);
			    	text += "......";
			    }
		    });
		    text = text.substring(0,text.length-1);
		    $('#selectedOption').val(text);
		});
	});
	// 여기까지 (3) 끝
	
	// (4) 서치바에 원하는 아이템 입력 시 그 아이템만 남겨두고 출력
	function filterFunction() {
		var input, filter, ul, li, a, i;
		input = document.getElementById("searchBar");
		filter = input.value.toUpperCase();
		div = document.getElementById("selectOption");
		a = div.getElementsByTagName("li");
		
		for (i = 0; i < a.length; i++) {
			txtValue = a[i].textContent || a[i].innerText;
			if (txtValue.toUpperCase().indexOf(filter) > -1) {
			    a[i].style.display = "";
				} else {
				a[i].style.display = "none";
			}
		}
	}
	// 여기까지 (4) 끝
	
	</script>
</head>

<div class = "selectMenu">
	<table>
		<tr>
			<td>
				<input type="text" name="selectedOption" id="selectedOption" value="" style = "position:relative; background-color: #eee;" readonly >
			</td>
		</tr>
		<tr>
			<td>
				<div class="selectMenu-content" id="selectMenu-content">
					<table>
						<tr>
							<td>
								<input type = "text" name = "searchBar" id="searchBar" autocomplete="off" placeholder="검색..." onkeyup="filterFunction()" >
							</td>
						</tr>
						<tr>
							<td>
								<div class="selectOption" id="selectOption">
									<ul>
										<li class="selectList"><label class="dropChk"><input type="checkbox" id="selectAll" name="dropChk" value = "all" class="dropChk"> 전체 </label><br /></li>
										<c:forEach var="i" begin="10000" end="10020">
											 <li class="selectList" value = "${i}"><label class="dropChk"><input type ="checkbox" id="dropChk[${i}]" name="dropChk" value="${i}" class="dropChk"> <c:out value = "${i}" /> </label><br /> </li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
</div>



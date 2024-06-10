<%@page import="entity.Customer"%>
<%@ page pageEncoding="utf8" %>
<!DOCTYPE html>
<html>
	<head>
	
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>會員註冊</title>
		<link rel="stylesheet" type="text/css" href="./style/tuna.css">
		<style>	
			article{background-image: url(./images/background.jpg) opacity:0.5;}
			.errorsDiv{color:red}
			#registerForm{width: 700px;margin:0 auto;}
			body{background:#dddfd9;}
			
			.registerButton{                  /*註冊按鈕*/
				    background-color: #64beaa;
				    color: #fff;
				    border: 1px solid white;
				    font-weight: bold;
				    font-size: 1.3em;
				    cursor: pointer;
					}
			input[type],select,textarea {    /*註冊打字框變圓潤*/
				    border: 2px solid white;
				    border-radius: 10px; 
				    padding: 5px; 
				   } 
				   
			    
		</style>
		<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
		      	crossorigin="anonymous">
		</script>
	
		<script>
		function displayPassword(theCheckbox){
			//alert("displayPassword" + theCheckbox.checked);
			if(theCheckbox.checked){
				password.type="";	
			}else{
				password.type ="password";
			}
		}
		function refreshCaptcha(){
			var now = new Date();
			//alert("refresh Captcha"+now);
			captchaImg.src="images/captcha_login.png?attr=" + now;
			
		}
		$(init);
		function init(){
			<% if("POST".equals(request.getMethod())) {%>
				repopulateForm();
			<% }%>
		}
		function repopulateForm(){
			alert("註冊會員失敗，請修正錯誤再重新註冊");
			$("input[name=id]").val('${param.id}');
			$("input[name=email]").val('${param.email}');
			$("input[name=phone]").val('${param.phone}');
			$("input[name=name]").val('${param.name}');
			$("input[name=birthday]").val('${param.birthday}');
			$("select[name=gender]").val('${param.gender}');
			$("textarea[name=address]").val('${param.address}');
			$("input[name=subscribed]").prop("checked",${parm.subscribed!=null});
			
		}
		</script>
		</head>
	<body>
		<jsp:include page="subviews/header.jsp">
			<jsp:param name ="subheader" value="會員註冊"/>
		</jsp:include>
		<%@ include file="subviews/nav.jsp" %>
		<hr>
		<article>
			<div class ="errorsDiv" >
			${errors}
			</div>
			
			<form id=registerForm action="register.do" method="POST">
			<p>
			<label class="inputLabel" >帳號:</label>
			<input type='text' required  name="id" placeholder="請輸入roc id"	
				pattern = "[A-Z][1289][0-9]{8}">	
			</p>	
			
			<p>
			<label class="inputLabel" >email:</label>
			<input type='email' required  name="email" placeholder="請輸入email">	
			</p>	
			
			<p>
			<label class="inputLabel" >手機:</label>
			<input type='tel' required  name="phone" placeholder="請輸入手機號碼">	
			</p>
			
			<p>
			<label class="inputLabel" >姓名:</label>
			<input type='text' required  name="name" placeholder="請輸入姓名"
			         minlength="2" maxlength="20">	
			</p>
			
			<p>
			<label class="inputLabel">	密碼:</label>
			<input type="password" id="password" name="password" required placeholder="請輸入密碼" 
					minlength="6" maxlength="20">		
			<input type = "checkbox" onchange="displayPassword(this)"><label>顯示密碼</label>
			</p>
			
			<p>
			<label class="inputLabel">	生日:</label>	
			<input type='date'  name="birthday"required max="2012-04-22">
			</p>
				
			<p>
			<label class="inputLabel">性別:</label>	
			<select name="gender" required>
				<option value="">請選擇...</option>
				<option value="M">男</option>
				<option value="F">女</option>
				<option value="O">其它</option>					
			</select>
			</p>	
			
			<p>
			<label class="inputLabel">地址:</label>	
			<textarea row="3" cols="20" name="address">	</textarea>
			</p>
			
			<p>
			<input type = "checkbox" name="subscribed" ><label>是否訂閱電子報</label>
			</p>
					
			<p>
			<label class="inputLabel">驗證碼:</label>
			<input type="text" name="captcha" required placeholder="請輸入驗證碼">
			<img id="captchaImg"alt="驗證碼圖片" src="images/captcha_login.png" 
						title="點選圖片即可更新" onclick="refreshCaptcha()">				
			</p>	
				
			<input class="registerButton" type="submit" value="註冊新會員">
	   </form>
		</article>
		<%@ include file="subviews/footer.jsp" %>
	</body>
</html>
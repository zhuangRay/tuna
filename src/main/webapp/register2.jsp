<%@page import="entity.Customer"%>
<%@ page pageEncoding="utf8" %>
<!DOCTYPE html>
<html>
	<head>
	
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>會員註冊</title>
		<style>
			body{font-family:  Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", 
			"LiHei Pro", "微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;}
			article{min-height:70vh }
			.errorsDiv{color:red}
			.show {
					margin-left: 50px;
				  }
			label {
				float: left;
				width: 80px;
				background: #fc9b03;
				text-align: right;
				padding-right: 10px;
			      }
		</style>
		
		<script type="text/javascript" src="../jquery.js"></script>
  		<script type="text/javascript">
		$(document).ready(init);
		function init(){
			//$(":input").addClass("show");
			//$("input,select,textarea").addClass("show");
			
			//$("input[type='text']").addClass("show");
 			$(":text").addClass("show");
// 			$(":password").addClass("show");
// 			$(":radio").addClass("show");
// 			$(":checkbox").addClass("show");
// 			$("select").addClass("show");//use tagname
// 			$("textarea").addClass("show");//use tagname
// 			$(":file").addClass("show");
// 			$(":image").addClass("show");
// 			$(":submit").addClass("show");
// 			$(":reset").addClass("show");
			
			
			
		}
		
		
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
		</script>
		</head>
	<body>
		<header>
		<h1><a href="./">鮪魚鮮生</a><sub> 會員註冊 </sub></h1>
		<hr>
		</header>
		<nav>
		<a href="login.jsp">會員登入</a>
		<a href="">會員註冊</a>
		<hr>
		</nav>
		<article>
			<div id="demo">
			<div class ="errorsDiv" >
			${errors}
			</div>
			   <form action="register.do" method="POST">
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
				
			<input type="submit" value="註冊新會員">
	   </form>
		</article>
		</div>
		<footer>
			<hr>
			鮪魚鮮生&copy;2024-04~
		</footer>
	</body>
</html>
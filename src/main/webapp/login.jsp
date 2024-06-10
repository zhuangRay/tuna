<!-- <%@ page pageEncoding="utf8" %> -->
<!DOCTYPE html>
<html>
<head>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>會員登入</title>
	<link rel="stylesheet" type="text/css" href="./style/tuna.css">
	<style>
		 .loginForm{margin-top:50px;margin-left:20px;color:#227bbb;font-weight:bold;}
		 .loginButton{                      /*登入按鈕*/
				    background-color: #64beaa;
				    color: #fff;
				    border: 1px solid white;
				    font-weight: bold;
				    font-size: 1.3em;
				    cursor: pointer;
					}
		.loginH1{border-bottom: 2px solid #64beaa;padding: 0 0 .5em ;width:200px;}/*歡迎再次造訪*/
		 #captchaImg{vertical-align:bottom; cursor: pointer;}
		 .inputLabel{width:3.5em;display:inline-block;}/*帳、密、驗證碼文字*/
		 .divHr{height:2px;background-color:#64BEAA;margin: 5px 0px;}/*假的hr*/
		 .h1A{      background-color: #64beaa;  /*標題的鮪魚鮮生*/
				    color: #fff;
				    font-weight: bold;
				    font-size: 1.3em;
				    cursor: pointer;
				    width:170px;
				    text-decoration: none;}
		.h1A:hover{text-decoration: underline;} /*標題的鮪魚鮮生*/
			input[type]{    /*打字框變圓潤*/
				    border: 2px solid white;
				    border-radius: 10px; 
				    padding: 5px; 
				   } 
				   
		/*翻轉食物css start*/
		#container{
		height:200px;
		width:800px;
		margin:150px auto;
		position: relative; top: -150px; left: 30px;
					}
		#container img{
			position:absolute;
			transform-origin:center center;
			transition:all 0.5s;
			opacity:0.8;
						}
		#container img:hover{
			opacity:1;
							}	
		.pFoodIcon{width:150px;height:150px;}						   
			
	    #arrowOuter{margin-left: 950px;margin-bottom: 50px; }  
		/*翻轉食物css end*/
	</style>
	<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
	crossorigin="anonymous"></script>
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
	
	//輪轉食物
	
	var picAr=[];
	var picNum=4;
	var index=0;
	$(document).ready(init);
	function init(){
		for (var i=0;i<=picNum; i++){
			picAr[i]=[];//0:translateX 1:scale 2:zIndex
			picAr[i][0]=i*120+100;
			picAr[i][1]=0.8+(1-Math.abs(i-picNum/2)*0.3);
			picAr[i][2]=picNum*0.5-Math.abs(picNum*0.5-i);
		}
		rotate(index);
		$("#next").click(nextHandler);
		$("#prev").click(prevHandler);
		$("#container img").click(clickHandler);
	}	
	function clickHandler(){
		index=$(this).index()-picNum*0.5;
		console.log("this.index="+$(this).index()+" / index="+index);
		rotate(index);//-4 ~ 0 ~ +4
	}
	function nextHandler(e){
		rotate(--index);
	}
	function prevHandler(e){
		rotate(++index);
	}
	function rotate(input){
		for (var i=0;i<=picNum; i++){
			var count=(input+i)%picAr.length;
			console.log("input="+input+" / count="+count+" / i="+i);
			$("#container img:eq("+count+")").css({"transform":"translate("+picAr[i][0]+"px,0px) scale("+picAr[i][1]+") ","zIndex":picAr[i][2]});
		}
	}
	
	
	
	
	
	
	
	
	
	</script>
</head>
<body>
	<header>
		<h1><a class="h1A" href="./">鮪魚鮮生</a><sub> 會員登入 </sub></h1>
	    <div class="divHr"></div>
	</header>
	<nav>
	 	<a href="">會員登入</a>
	    <a href="register.jsp">會員註冊</a>
	    <div class="divHr"></div>	
	</nav>
	<article>
	<div style='color:red'>
		${errors}	
	</div>

		<h1 class="loginH1">歡迎再次造訪~</h1>
		
	   <form class="loginForm" action="login.do" method="POST">
			<p>
			<label class="inputLabel" for="id">帳號:</label>
			<input type='text' required id="id" name="id" placeholder="請輸入id/email/手機號碼">	
			</p>	
			
			<p>
			<label class="inputLabel">	密碼:</label>
			<input type="password" id="password" name="password" required placeholder="請輸入密碼" >		
			<input type = "checkbox" onchange="displayPassword(this)"><label>顯示密碼</label>
			</p>
					
			<p>
			<label class="inputLabel">驗證碼:</label>
			<input type="text" name="captcha" required placeholder="請輸入驗證碼">
			<img id="captchaImg"alt="驗證碼圖片" src="images/captcha_login.png" 
						title="點選圖片即可更新" onclick="refreshCaptcha()">
						
			</p>	
				
			<input class="loginButton" type="submit" value="我要登入">
	   </form>
		
		<div id="container">
			<img class="pFoodIcon" src="images/vegetable_icon.png">
			<img class="pFoodIcon" src="images/seafood_icon.png">
			<img class="pFoodIcon" src="images/noodles_icon.png">
			<img class="pFoodIcon" src="images/meat_icon.png">
			<img class="pFoodIcon" src="images/fruit_icon.png">

    </div>
		</article>
			<div id="arrowOuter">
		    <button id="prev" style="width: 30px; height: 25px;border:0px;">
		    <img src="images/left_arrow.png"  style="width: 100%; height: 100%;border:0px;"></button>
		    
		    <button id="next" style="width: 30px; height: 25px;border:0px;">
		    <img src="images/right_arrow.png"  style="width: 100%; height: 100%;border:0px;"></button> 
		    
	
    </div>
    
    
    

		
		
		
		
		
		
   <%@ include file="subviews/footer.jsp" %>
</body>
</html>
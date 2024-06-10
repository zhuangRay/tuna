package entity;

import java.time.LocalDate;


import exception.TUNADataInvalidException;

public class Customer {// 類別
	//以下屬性(attribute,property)宣告  //屬性盡量都宣告private,不要public
	private String id; //ROC ID,必要欄位,pKey欄位;越不常改的適合當pKey
	private String email;//符合email格式,必要欄位,unique欄位
	private String phone;//10~20個字元,必要欄位,unique欄位
	private String password;//必要欄位,6~20個字元
	private String name;//必要欄位,2~20個字元
	
	private LocalDate birthday;//必要欄位,年滿12歲
	private char gender;// 必要欄位,M:MALE,F:FEMALE,O:ITHERS
	
	private String address="";// 非必要欄位
	private boolean subscribed;// 非必要欄位
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		if(checkId(id)==true) {
		this.id = id;
	}else {
		//TODO: 以下錯誤訊息處理方式要在mod13後改成 throw new XxxException("......")
		//System.err.printf("資料不正確:%s,不符合身分證號規則\n",id);
		String errMsg = String.format("資料不正確:%s,不符合身分證號規則\n", id);
		throw new TUNADataInvalidException(errMsg);
	   }
	}
	public static final String ID_PATTERN ="[A-Z][1289][0-9]{8}";//[0-9]前後端設定一致,也可以代換\d(\在JAVA為控制字元要變\\d)但相容性不高 
	public boolean checkId(String id) {
		
		if(id!=null && id.matches(ID_PATTERN)) {
			int sum =0;
			//1.將第1碼的字元 轉成對應的數字
			char firstChar =id.charAt(0); // (0)代表第一個
			int firstNum;
			
			if(firstChar>='A'&& firstChar<='H') {
				firstNum=firstChar-'A'+10;
			}else if (firstChar>='J'&& firstChar<='N') {
				firstNum=firstChar-'N'+18;
			}else if(firstChar>='P' && firstChar<='V') {
				firstNum=firstChar-'P'+23;
			}else {
//				if(firstChar=='I')firstNum=34;
//				else if(firstChar=='O')firstNum=35;
//				else if(firstChar=='W')firstNum=32;		
//				else if(firstChar=='X')firstNum=30;	
//				else if(firstChar=='Y')firstNum=31;
//				else firstNum =33;
				
				switch(firstChar) {
				case'I':firstNum=34; break;
				case'O':firstNum=35; break;
				case'W':firstNum=32; break;
				case'X':firstNum=30; break;
				case'Y':firstNum=31; break;
				default:firstNum=33; break; //Z
				
				
				}
			}
				
			//將第一個整數的十位數*1+個位數*9並指派給sum
			sum = firstNum/10*1+firstNum%10*9;
			//2.將第1~9碼的字元依公式加總
			for(int i=1;i<10;i++) {
			
			sum = sum+(id.charAt(i)-'0')*(9-i==0?1:9-i); 			
			}
			
			
//			sum = sum+(id.charAt(2)-'0')*7;//複合指定運算子
//			sum = sum+(id.charAt(3)-'0')*6;
//			sum = sum+(id.charAt(4)-'0')*5;
//			sum = sum+(id.charAt(5)-'0')*4;
//			sum = sum+(id.charAt(6)-'0')*3;
//			sum = sum+(id.charAt(7)-'0')*2;
//			sum = sum+(id.charAt(8)-'0')*1;
//			sum = sum+(id.charAt(9)-'0')*1;
			//3.sum為10被數時,即為正確的 ROC ID
			return sum%10==0;
		}
		return false;
	}
	public String getEmail() {
		return email;
	}
	public static final String EMAIL_PATTERN ="^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"; //請至regexp lib 查詢
	public void setEmail(String email) {//^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,4}$
		if(email!=null & email.matches(EMAIL_PATTERN)) {	
		this.email = email;
	}else {
		//TODO: 以下錯誤訊息處理方式要在mod13後改成 throw new XxxException("......")
		//System.err.printf("email格式不正確: %s\n", email);
		String errMsg = String.format("資料不正確:%s,不符合EMAIL規則\n", email);
		throw new TUNADataInvalidException(errMsg);
	}
   }
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		int minLength=10, maxLength=20;
		if(phone!=null && phone.length()>=minLength && phone.length()<=maxLength) {
			this.phone = phone;
			return;
	}
	//TODO: 以下錯誤訊息處理方式要在mod13後改成 throw new XxxException("......")
	//System.err.printf("資料不正確: %s, 手機/連絡電話必須%d~%d個數字字元\n", 
			//phone, minLength, maxLength);
		String errMsg = String.format("資料不正確: %s, 手機/連絡電話必須%d~%d個數字字元\\n", phone);
		throw new TUNADataInvalidException(errMsg);
			}
	
	
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		if (gender=='M'||gender=='F'||gender=='O') {
		this.gender = gender;
	}else {
		System.err.printf("資料不正確:%s,客戶性別必須是男:%s,女:%s,其他%s",gender,'M','F','O');}
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public boolean isSubscribed() {
		return subscribed;
	}
	public void setSubscribed(boolean subscribed) {
		this.subscribed = subscribed;
	}
	public static final int NAME_MIN_LENGTH=2,NAME_MAX_LENGTH=20;
	public void setName(String n) {
		
		if(n.length()>=NAME_MIN_LENGTH && n.length()<=NAME_MAX_LENGTH) {
			this.name=n;
			//System.out.printf("資料正確:%s\n",n);
		}else {
			//TODO:以下錯誤訊息處理方式要在mod13後改成 throw new XxxException("....") 給前端使用者看的
			//System.err.printf("資料不正確:%s,客戶姓名必須是%d~%d個字元\n"
				//	,n,NAME_MIN_LENGTH,NAME_MAX_LENGTH);//只有後端管理員看的到
			String errMsg = String.format("資料不正確:%s,客戶姓名必須是%d~%d個字元\\n",n,NAME_MIN_LENGTH,NAME_MAX_LENGTH);
			throw new TUNADataInvalidException(errMsg);
			
		   }
		}
		public String getName() {
		return name;		
	}
	
	public void setPassword(String password) {
		int MINLENGTH=6,maxength=20;
		if(password!=null&&password.length()>=MINLENGTH && password.length()<=maxength ) {
			this.password =password;
		}else {
		//TODO: 以下錯誤訊息處理方式要在mod13後改成 throw new XxxException("......")
			//System.err.printf("資料不正確:%s,密碼必須是%d~%d個字元\n"
				//	,password,MINLENGTH,maxength);
			String errMsg = String.format("資料不正確:%s,密碼必須是%d~%d個字元\\n",password,MINLENGTH,maxength);
			throw new TUNADataInvalidException(errMsg);}
		}
	
		public String getPassword() {
			return password;	
	}
	
	/**
	 * 將參數dateString"轉換"為LocalDate物件
	 * 再呼叫setBirthday(theDate)方式做"指派"
	 * @param dateString 客戶生日的日期字串,須符合ISO-8601
	 */
		public void setBirthday(String dateString) {//小月曆
			LocalDate theDate = LocalDate.parse(dateString);//把字串改成LocalDate類別的物件
			this.setBirthday (theDate);//把變成LocalDate的theDate,設置為對象的生日屬性
			
			}
	
		
		/**
		 * 將三個int參數 year month day,"轉換"為LocalDate物件,
		 * 再呼叫setBirthday(theDate)方式做"指派"
		 * @param year int客戶生日的西元年
		 * @param month int客戶生日的月份
		 * @param day int客戶生日的日期
		 */
		public void setBirthday(int year,int month,int day) {//三個選單的月曆
			LocalDate theDate = LocalDate.of(year,month,day);
			this.setBirthday (theDate);		
		}
		
		/**
		 * 提供birthday屬性封裝(encapsulate)後,所需要的setter
		 * 檢查參數的出生日期是否符合客戶年齡
		 * 檢查參數的出生日期是否符合客戶年齡規則(年滿12歲),再指派給birthday屬性
		 * @param birthday
		 */
		
		public void setBirthday(LocalDate birthday) {
			if(birthday!=null && getAge(birthday)>=12) {
			this.birthday=birthday;	
			
		}else {
			//TODO: 以下錯誤訊息處理方式要在mod13後改成 throw new XxxException("......")
			//System.err.printf("生日資料不正確:%s,客戶必須年滿%d歲\n"
				//	,birthday,12);//只有後端管理員看的到 for developer, admin, tester
			String errMsg = String.format("生日資料不正確:%s,客戶必須年滿%d歲\\n",birthday,12);
			throw new TUNADataInvalidException(errMsg);
		}	
		}
		public LocalDate getBirthday() {
			return birthday;
		}
		/**計算customer年齡:今年-customer.birthday年
		 *  @return int 客戶年齡
		 */
		public  Integer getAge() {
			
		 return getAge(this.birthday);	
		}
		
		/**計算customer年齡:今年-參數birthday指定出生日期的年
		 *  @return int 客戶年齡
		 */
		public static Integer getAge(LocalDate birthday) {
			int age;
			if (birthday!=null) {
			 int thisYear = LocalDate.now().getYear();	
			 
		     int birthYear=birthday.getYear();
		     age = thisYear-birthYear;
		
		     return age;
		   }
		 return null;
		//TODO(可不做): 以下錯誤訊息處理方式要在mod13後改成 throw new XxxException("......")				
		}
		
		//要產生有參數建構事後
		//再加無參數建構式(不然他就不送你)  
		public Customer(String id, String password, String name) {
			super();
			this.setId(id);
			this.setPassword(password);
			this.setName(name);
		}
		public Customer() {
			super();
		}
		
@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((id == null) ? 0 : id.hashCode());
			return result;
		}

		/**
		 * obj是多型的參數宣告
		 */
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (!(obj instanceof Customer))
				return false;
			Customer other = (Customer) obj;
			if (id == null) {
				if (other.id != null)
					return false;
			} else if (!id.equals(other.id))
				return false;
			return true;
		}
		@Override
		public String toString() {
			return this.getClass().getName() +
					" [身分證號=" + id + ", email=" + email + 
					", phone=" + phone + ", 密碼=" + password +
					", 姓名="+ name + ", 生日=" + birthday + ", 性別=" + gender + ", 地址=" + address + ", 訂閱電子報="
					+ subscribed + "]";
		}
	
		
		
	

}

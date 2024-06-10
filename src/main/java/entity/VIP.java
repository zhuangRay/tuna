package entity;

public class VIP extends Customer {
	private int discount=5;//1~90% off(99折~1折)

	public VIP() {
		super();	
	}

	public VIP(String id, String password, String name) {
		super(id, password, name);	
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		if(discount>0 && discount<=90) {
		this.discount = discount;
		}else {
			System.out.printf("資料不正確:%s,discount應為1~90% off\n",discount);		
		}
	}

	public String getDiscountString() {
		int discount = 100-this.discount;
		if(discount%10==0) {
			discount = discount/10;
					}
		return discount+"折";
		
		
	}
	
	
	
}

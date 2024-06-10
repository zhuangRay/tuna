package entity;

public class SpecialOffer extends Product {
	private int discount;

	
	
	public SpecialOffer() {
		super();
		
	}

	public SpecialOffer(int id, String name, double unitPrice) {
		super(id, name, unitPrice);
		}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		if(discount>0 && discount<=90) {
			this.discount = discount;
			}else {
				System.err.printf("資料不正確:%s,discount應為1~90% off\n",discount);		
			}
		
	} 
	public String getDiscountString() {
		int discount = 100-this.discount;
		if(discount%10==0) {
			discount = discount/10;
					}
		return discount+"折";

 }
	/**
	 * 查詢折扣後售價
	 * @return double 型態的定/售價
	 */
	@Override
	public double getUnitPrice() {
		double price = super.getUnitPrice();//從父類別查詢定價
		
		price *= ((100D-this.discount)/100);
		return price;
	  }
	/**
	 *查詢定價
	 * @return
	 */
	public double getListPrice() {
		 return super.getUnitPrice();////從父類別查詢定價
		 
		 
	}

	@Override
	public String toString() {
		return super.toString()+
				"折扣=" + discount 
				+ ",% off,即為"+this.getDiscountString()
				+ ",售價=" + getUnitPrice()+"元";
	}
	
}
	

 
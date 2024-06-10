package entity;

public class CartItem {
	private Product product;//PKey
	private Flavor theFlavor;//PKey(有口味才為必要)
	private Spec theSpec;//PKey(有規格才為必要)
	
	//private int quantity;  //****放在ShoppingCart類別中的Map中****
	
//	private boolean checkOutFlag = true; //是否要在這一次結帳
//	
//	public boolean isCheckOutFlag() {
//		return checkOutFlag;
//	}
//	public void setCheckOutFlag(boolean checkOutFlag) {
//		this.checkOutFlag = checkOutFlag;
//	}
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Flavor getTheFlavor() {
		return theFlavor;
	}
	public void setTheFlavor(Flavor theFlavor) {
		this.theFlavor = theFlavor;
	}
	public Spec getTheSpec() {
		return theSpec;
	}
	public void setTheSpec(Spec theSpec) {
		this.theSpec = theSpec;
	}
	
	public int getProductId() {
		return product.getId();	
	}
	public String getPhotoUrl() {
//		if(theSpec!=null && theSpec.getPhotoUrl()!=null) {
//			return theFlavor.getFlavorName(); 
//		}else
		
		if(theFlavor!=null && theFlavor.getPhotoUrl()!=null) {
			return theFlavor.getPhotoUrl(); 
		}else {
			return product.getPhotoUrl();
		}	
	}
	public String getProductName() {
		return product.getName();
	}
	public String getFlavorName() {
		if(theFlavor!=null) {
			return theFlavor.getFlavorName();	
		}else return "";	
	}
	
	public String getSpecName() {
		if(theSpec!=null) {
			return theSpec.getSpecName();	
		}else return "";	
	}
	
	public double getListPrice() {
		if(theSpec!=null && theSpec.getListPrice()>0) {
			return theSpec.getListPrice();	
		}else {
			if(product instanceof SpecialOffer) {
				return ((SpecialOffer)product).getListPrice();
			}else {
				return product.getUnitPrice();
			}
		}
		
	}
	public String getDiscountString() {
		if(product instanceof SpecialOffer) {
			return ((SpecialOffer)product).getDiscountString();
		}else {
			return "";
		}
	}
	
	public double getUnitPrice(){
		if(theSpec!=null && theSpec.getPrice()>0) {
			return theSpec.getPrice();	
		}else {
				return product.getUnitPrice();
			}
		}
		
	public int getStock() {
		if(theSpec!=null) {
			return theSpec.getStock(); 
		}else if(theFlavor!=null) {
			return theFlavor.getStock(); 
		}else {
			return product.getStock();
		}
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((theFlavor == null) ? 0 : theFlavor.hashCode());
		result = prime * result + ((theSpec == null) ? 0 : theSpec.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CartItem other = (CartItem) obj;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (theFlavor == null) {
			if (other.theFlavor != null)
				return false;
		} else if (!theFlavor.equals(other.theFlavor))
			return false;
		if (theSpec == null) {
			if (other.theSpec != null)
				return false;
		} else if (!theSpec.equals(other.theSpec))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "CartItem [編號=" + getProductId() + ",\n 圖片網址=" + getPhotoUrl()
		          + ",\n 名稱=" + getProductName() 
		          + ", 購買口味=" + getFlavorName() + ", 購買規格=" + getSpecName()
			+ ",\n 定價=" + getListPrice() + ", 折扣=" + getDiscountString()
			+ ", 售價=" + getUnitPrice() + ", 庫存=" + getStock() + "]";
	}
	
}

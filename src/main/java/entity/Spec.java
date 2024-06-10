package entity;

public class Spec {
	private int productId; //PKey
	private String flavorName;//PKey
	private String specName;//PKey
	private int stock;
	private double listPrice;
	private double price;
	//private String photoUrl;
	
	
//	public String getPhotoUrl() {
//		return photoUrl;
//	}
//	public void setPhotoUrl(String photoUrl) {
//		this.photoUrl = photoUrl;
//	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getFlavorName() {
		return flavorName;
	}
	public void setFlavorName(String flavorName) {
		this.flavorName = flavorName;
	}
	public String getSpecName() {
		return specName;
	}
	public void setSpecName(String specName) {
		this.specName = specName;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public double getListPrice() {
		return listPrice;
	}
	public void setListPrice(double listPrice) {
		this.listPrice = listPrice;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((flavorName == null) ? 0 : flavorName.hashCode());
		result = prime * result + productId;
		result = prime * result + ((specName == null) ? 0 : specName.hashCode());
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
		Spec other = (Spec) obj;
		if (flavorName == null) {
			if (other.flavorName != null)
				return false;
		} else if (!flavorName.equals(other.flavorName))
			return false;
		if (productId != other.productId)
			return false;
		if (specName == null) {
			if (other.specName != null)
				return false;
		} else if (!specName.equals(other.specName))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return this.getClass().getSimpleName()+
				"[product編號=" + productId + ", 口味Name=" + flavorName + ", 規格Name=" + specName 
				+ ", 庫存="+ stock 
				+ ", 定價=" + listPrice + ", 售價=" + price + "]";
	}
	
	
}

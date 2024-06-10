package entity;

public class Flavor {
	private String flavorName;
	private int stock;//PKey
	private String iconUrl;//必要
	private String photoUrl;//非必要
	private double unitPrice;
	public String getFlavorName() {
		return flavorName;
	}
	public void setFlavorName(String flavorName) {
		this.flavorName = flavorName;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getIconUrl() {
		if(iconUrl!=null) {
		return iconUrl;
	 }else {
		 return photoUrl;
	 }
	}
	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((flavorName == null) ? 0 : flavorName.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Flavor))
			return false;
		Flavor other = (Flavor) obj;
		if (flavorName == null) {
			if (other.flavorName != null)
				return false;
		} else if (!flavorName.equals(other.flavorName))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return this.getClass().getSimpleName()+"[口味=" + flavorName + ", 口味庫存=" + stock 
				+ ",\n 小圖示=" + iconUrl 
				+ ",\n photo="+ photoUrl 
				+ ", \n 定價=" + unitPrice + "]";
	}

}
package entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import exception.TUNADataInvalidException;

public class Product {
	
	private int id;//PKey, AUTO-INCREMENT
	private String name;//必要 ,1~60個字元 RW
	private String category;//必要, RW, 冷凍白蝦/魚刺/干貝/龍蝦/
	private String photoUrl;//非必要, RW
	private double unitPrice;//必要, RW, >0, 售價即為定價
	private int stock;//必要, RW
	private String description;//非必要, RW
	private LocalDate releaseDate ;//必要, RW
	
	private int specCount;
	public int getSpecCount() {
		return specCount;
	}

	public void setSpecCount(int specCount) {
		this.specCount = specCount;
	}

	private List<Flavor>flavorsList = new ArrayList<>();

	
    //集合屬性的getter必須回傳副本
	public List<Flavor> getFlavorsList() {
		return new ArrayList<>(flavorsList);//回傳副本
	}
	
//集合屬性不可直接提供setter
//	public void setFlavorsName(List<Flavor> flavorsName) {
//		this.flavorsName = flavorsName;
//	}
	
	
	public void add(Flavor flavor) {
		flavorsList.add(flavor);
	}
	 public Flavor findFlavor(String flavorName) {
		 if(flavorsList!=null && flavorsList.size()>0) {
			 for(int i=0;i<flavorsList.size();i++) {
				 Flavor flavor = flavorsList.get(i);
				 if(flavor.getFlavorName().equals(flavorName)){
					 return flavor;
				 }
			 }
			 
		 }
		 return null;
	 }
	//要產生有參數建構式後
	//再加無參數建構式(因為有自己產生建構式後 他就不送了)  
	public Product() {}
	
	public Product(int id, String name, double unitPrice) {
		super();
//		this.id = id;
//		this.name = name;
//		this.unitPrice = unitPrice;
		this.setId(id);
		this.setName(name);
		this.setUnitPrice(unitPrice);	
	}
	
	
	/**
	 * 
	 * @param id 產品代號
	 * @param name 產品名撐
	 * @param unitPrice 定價
	 * @param stock 庫存
	 */
	
	public Product(int id, String name, double unitPrice, int stock) {
		super();
		this.setId(id);
	//	this.id = id;
		this.setName(name);
	//	this.name = name;
	    this.setUnitPrice(unitPrice);
	//this.unitPrice = unitPrice;
	    this.setStock(stock);
	//this.stock = stock;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		if(id>0) {
		this.id = id;
		}else {
			//System.err.printf("產品編號不得小於1: %s\n",id);
			String errMsg = String.format("產品編號不得小1:\n", id);
			throw new TUNADataInvalidException(errMsg);
		}
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	/**
	 * 查詢定價(即為售價)
	 * @return double 型態的定/售價
	 */
	public double getUnitPrice() {
		return unitPrice;
	}
	
	/**
	 * 設定定價(即為售價)
	 * @param unitPrice
	 */
	public void setUnitPrice(double unitPrice) {
		//TODO: 必須>0
		if(unitPrice>0) { 
			this.unitPrice = unitPrice;
		}else {
			//System.err.printf("產品定價必須>0: %s\n", unitPrice);
			String errMsg = String.format("產品定價必須>0: %s\\n", unitPrice);
			throw new TUNADataInvalidException(errMsg);
		}
	}
	
	public int getStock() {
		if(flavorsList!=null && flavorsList.size()>0) {
			int sum=0;
			for(int i=0;i<flavorsList.size();i++) {
				sum = sum + flavorsList.get(i).getStock();
			}
			return sum;
		}
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public LocalDate getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(LocalDate releaseDate) {
		this.releaseDate = releaseDate;
	}
	/**
	 * 
	 */
	public void setReleaseDate(String releaseDate) {
		LocalDate theDate =LocalDate.parse(releaseDate);
		this.setReleaseDate(theDate);
		}
	
	@Override
	public String toString() {
		return getClass().getName()
				+"[id=" + id + ", 名稱=" + name + ", category=" + category 
				+ "\n, 圖片網址=" + photoUrl
				+ "\n, 定價=" + unitPrice + ", 庫存=" + stock 
				+ "\n, 口味清單=" +flavorsList
				+ "\n,說明=" + description 
				+ "\n,上架日期 ="+ releaseDate + "]";
	}
	

	
	//複製老師的
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (this.getClass() != obj.getClass())
			return false;
		Product other = (Product) obj;
		if (id != other.id)
			return false;
		return true;
	}

	
	
}

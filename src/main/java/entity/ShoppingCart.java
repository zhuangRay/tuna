package entity;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import exception.TUNADataInvalidException;

public class ShoppingCart {
	private Customer member;
	private Map<CartItem,Integer> cart = new HashMap<>();
	
	public Customer getMember() {
		return member;
	}
	public void setMember(Customer member) {
		this.member = member;
	}
	
	//取代cart屬性的setter(s):add , update , remove
	public void add(Product p, String flavorName, Spec spec, int quantity) {
		if(p==null) throw new IllegalArgumentException("加入購物車的產品不得為null");
		
		CartItem item = new CartItem();
		item.setProduct(p);
		
		//將flavorName 找出對應的Flavor物件
		Flavor theFlavor = null;
		if(p.getFlavorsList().size()>0 && flavorName!=null && flavorName.length()>0) {
			theFlavor = p.findFlavor(flavorName);
			if(theFlavor==null) { 
				String errorMsg = String.format("有口味的商品，口味錯誤[%s-%s]",
													p.getId(),flavorName);
				throw new TUNADataInvalidException(errorMsg);
			}
		}else if(p.getFlavorsList().size()>0 && (flavorName==null || flavorName.length()==0)) {
			    String errorMsg = String.format("有口味的商品，必須選擇口味[%s-%s]",
			    		p.getId(),flavorName);
			    throw new TUNADataInvalidException(errorMsg);
		}
		
		item.setTheFlavor(theFlavor);
		
		//檢查是否有Spec
		if(p.getSpecCount()>0 && spec!=null) {
		  item.setTheSpec(spec);
		}else if(p.getSpecCount()>0 && spec==null) {
			String errorMsg = String.format("有規格的商品，規格物件不得為null[%s-%s]",
					p.getId(),spec);
			throw new TUNADataInvalidException(errorMsg);	
		}
				
		//查出同一個item的上次購買數量
		Integer lastQty = cart.get(item);
		if(lastQty!=null) {
			quantity = quantity +lastQty;
		}
		cart.put(item,quantity);	
	}
	
	public void update(CartItem item, int quantity) {
		//查出上次購買的同一個item
		Integer lastQty = cart.get(item);
		if(lastQty!=null) {
			cart.put(item,quantity);
		}
	}
	
	
	public void remove(CartItem key) {
		cart.remove(key);
	}
	// 取代CART屬性的getter(s)
	public int size() {
		return cart.size();
	}
	
	public boolean isEmpty() {
		return cart.isEmpty();
	}
	/**
	*查詢該購物明細的購買數量
	*@param item 該購物明細
	*@return int 購買數量
	*/
	public int getQuantity(CartItem item) {
		Integer qty = cart.get(item);
		return qty==null?0:cart.get(item);
	}
	/**
	*查詢 小記金額
	*@param item 該購物明細
	*@return int 該購物明細的售價 * 購買數量
	*/
	public double getAmount(CartItem item) {
		return item.getUnitPrice() * this.getQuantity(item);
	}
	
	public Set<CartItem> getCartItemSet(){
		//return cart.keySet(); //(x)，不得回傳正本
		return new HashSet<>(cart.keySet()); //應回傳複本
	}
	
	public int getTotalQuantity() {
		int sum = 0;
		Collection<Integer> qtyValues = cart.values();
//		Iterator<Integer> qtyIterator = qtyValues.iterator();
//		while(qtyIterator.hasNext()) {
//			Integer qty = qtyIterator.next();
//			sum = sum + qty; //商業邏輯計算
//		}
		
		for(Integer qty:qtyValues) {
			sum = sum + qty;//商業邏輯計算
	  }
		return sum;
  }	
	public double getTotalAmount() {
		double sum = 0;
		Set<CartItem> cartItemSet = cart.keySet();
		for(CartItem item:cartItemSet) {
			sum = sum + this.getAmount(item);
		}
	    return sum;
	}
	
	@Override
	public String toString() {
		String cartString = "";
		Set<CartItem> cartItemSet = this.cart.keySet();
		for(CartItem item:cartItemSet) {
			String data = item.toString() +
					"購買數量:" + this.getQuantity(item)+
					"小計" + this.getAmount(item);
			cartString = cartString + data +"\n";
		}
		
		return "ShoppingCart [訂購人=" + member 
				+ ",\n 購物車內容=\n" +cartString + "]"
				+"共" + size() +"項，" + getTotalQuantity() + "件\n"
				+"總金額為:" + getTotalAmount() + "元";
	}
	
}

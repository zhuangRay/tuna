package service;

import java.util.List;

import dao.ProductsDAO;
import entity.Product;
import entity.Spec;
import exception.TUNAException;

public class ProductService {
	private ProductsDAO dao = new ProductsDAO();
	public List<Product> getAllProducts() throws TUNAException{
		return dao.selectAllProduct();
	}
	public List<Product>getProductsByCategory (String category) throws TUNAException{
		if(category==null || category.length()==0) {		
			throw new IllegalArgumentException("依分類查詢產品，category必須有值");
		}
		
		return dao.selectProductsByCategory(category);
	}
	
	public List<Product> getProductsByKeyword (String keyword) throws TUNAException {
		if(keyword==null || keyword.length()==0) {
			throw new IllegalArgumentException("依關鍵字查詢產品，keyword必須有值");
		}
		
		return dao.selectProductsByKeyword(keyword);
	}
	
	public List<Product> getNewestProducts() throws TUNAException{
		return dao.selectNewestProducts();
}
	public Product getProductById(String id) throws TUNAException{
		//在dao類別加上 selectProductById(String id)
		return dao.selectProductById(id);
	}
	public List<Spec> getSpecList(String productId,String flavorName) throws TUNAException{
		return dao.selectSpecList(productId,flavorName);
	}
		
	public Spec getSpecByKey(String productId, String flavorName, String specName) throws TUNAException{
		List<Spec> specList = dao.selectSpecList(productId,flavorName);
		if(specList!=null && specList.size()>0) {	
			for(int i=0;i<specList.size();i++) {
				Spec theSpec = specList.get(i);
				if(theSpec.getSpecName().equals(specName)) {
					return theSpec;	
				}
			}
		}
		return null;
	}
}
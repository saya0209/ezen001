package org.zerock.cart.service;

import java.util.List;
import org.zerock.cart.vo.CartItemVO;

public interface CartService {
    List<CartItemVO> cartList(String id);

    Integer updateCartItem(String id, Long goods_no, int quantity);
	
	void updateGoodsTotalPrice(Long goodsNo, int quantity);

	Long calculateTotalAmount(List<CartItemVO> cartItems);

	void updateSelection(Long goodsNo, int selected, String id);

	void removeSelectedItems(String id);
	
}

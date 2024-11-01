package org.zerock.cart.service;

import java.util.List;
import org.zerock.cart.vo.CartItemVO;

public interface CartService {
    List<CartItemVO> cartList(Long id);

    Integer updateCartItem(Long id, Long goods_no, int quantity);
	
	void updateGoodsTotalPrice(Long goodsNo, int quantity);

	Long calculateTotalAmount(List<CartItemVO> cartItems);

}

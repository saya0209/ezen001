package org.zerock.cart.service;

import java.util.List;

import org.zerock.buy.vo.BuyItemVO;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.cart.vo.PaymentDetailVO;
import org.zerock.cart.vo.PaymentItemVO;

public interface CartService {
    List<CartItemVO> cartList(String id);
    
    List<BuyItemVO> buyList(String id);

    // 바로구매 데이터 초기화
    void clearBuyItem(String id);
    
    Integer updateCartItem(String id, Long goods_no, int quantity);
	
	void updateGoodsTotalPrice(Long goodsNo, int quantity);

	Long calculateTotalAmount(List<CartItemVO> cartItems);

	void updateSelection(Long goodsNo, int selected, String id);

	void removeSelectedItems(String id);
	
	void savePaymentHistory(HistoryVO history, List<PaymentDetailVO> paymentDetails);
	
    List<HistoryVO> getPaymentHistory(String id);
    
    List<PaymentDetailVO> getPaymentDetails(String orderNumber);

	HistoryVO getHistoryByOrderNumber(String orderNumber);

	void addCartItem(CartItemVO cartItem) throws Exception;
	
	void addBuyItem(BuyItemVO cartItem) throws Exception;

	void removeCartItem(String id, Long cart_no);
}

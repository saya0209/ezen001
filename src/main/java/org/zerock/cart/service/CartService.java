package org.zerock.cart.service;

import java.util.List;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.cart.vo.PaymentDetailVO;

public interface CartService {
    List<CartItemVO> cartList(String id);

    Integer updateCartItem(String id, Long goods_no, int quantity);
	
	void updateGoodsTotalPrice(Long goodsNo, int quantity);

	Long calculateTotalAmount(List<CartItemVO> cartItems);

	void updateSelection(Long goodsNo, int selected, String id);

	void removeSelectedItems(String id);
	
	void savePaymentHistory(HistoryVO history, List<PaymentDetailVO> paymentDetails);
	
    List<HistoryVO> getPaymentHistory(String id);
    
    List<PaymentDetailVO> getPaymentDetails(String orderNumber);

	HistoryVO getHistoryByOrderNumber(String orderNumber);
}

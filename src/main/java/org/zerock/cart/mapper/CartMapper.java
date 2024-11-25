package org.zerock.cart.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.buy.vo.BuyItemVO;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.cart.vo.PaymentDetailVO;
import org.zerock.cart.vo.PaymentItemVO;

@Repository
public interface CartMapper {

    // 장바구니 목록 조회
    List<CartItemVO> cartList(String id); // id를 Long 타입으로 변경
    
    List<BuyItemVO> buyList(String id); // id를 Long 타입으로 변경

    void deleteByUserId(String id);
    
    // 장바구니 상품 수량 및 가격 업데이트
    CartItemVO getCartItem(@Param("goods_no") Long goods_no, @Param("id") String id);
    Integer updateCartItem(Map<String, Object> params);

    // 특정 상품의 총 가격 업데이트
    void updateGoodsTotalPrice(CartItemVO item);

    // 상품 번호로 장바구니 아이템 조회
    CartItemVO getCartItemByGoodsNo(Long goods_no);

    void updateSelection(Map<String, Object> params);

	void deleteSelectedItems(String id);

	void insertHistory(HistoryVO historyVO);
	
    List<HistoryVO> selectHistoryByUserId(String id);
    
    void insertPaymentDetail(PaymentDetailVO detail);
    
    List<PaymentDetailVO> selectPaymentDetailsByOrderNumber(String orderNumber);

	HistoryVO getHistoryByOrderNumber(String orderNumber);

    void insertCartItem(CartItemVO cartItem);
    
    void insertBuyItem(BuyItemVO cartItem);

}

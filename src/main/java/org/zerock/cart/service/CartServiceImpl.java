package org.zerock.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.buy.vo.BuyItemVO;
import org.zerock.cart.mapper.CartMapper;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.cart.vo.PaymentDetailVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("CartServiceImpl")
public class CartServiceImpl implements CartService {

    @Inject
    private CartMapper mapper;

	@Override
	public List<CartItemVO> cartList(String id) {
		log.info("list() 실행 =====");
		
		// TODO Auto-generated method stub
		return mapper.cartList(id);
	}
	
	@Override
	public List<BuyItemVO> buyList(String id) {
		log.info("list() 실행 =====");
		
		// TODO Auto-generated method stub
		return mapper.buyList(id);
	}

	// 바로구매 데이터 초기화 (BuyItem 테이블에서 데이터 삭제)
    @Override
    public void clearBuyItem(String id) {
        mapper.deleteByUserId(id);  // 해당 id로 BuyItem 삭제
    }
	
	@Override
	public Integer updateCartItem(String id, Long goods_no, int quantity) {
	    log.info("updateCartItem() 실행 =====");
	    
	    // 상품 정보를 가져옵니다.
	    CartItemVO item = mapper.getCartItem(goods_no, id); // 해당 상품 정보를 가져오는 메서드
	    log.info("mapper.getCartItem 실행 =====");
	    
	    if (item != null) {
	        // 새로운 총 가격 계산
	        Long goods_total_price = (item.getPrice()-item.getDiscount()) * quantity + item.getDelivery_charge(); // 총 가격 계산
	        
	        // 수량 업데이트
	        item.setQuantity(quantity);
	        item.setGoods_total_price(goods_total_price); // 총 가격 설정

	        // DB에 업데이트
	        Map<String, Object> params = new HashMap<>();
	        params.put("id", id);
	        params.put("goods_no", goods_no);
	        params.put("goods_total_price", goods_total_price);
	        params.put("quantity", quantity);

	        return mapper.updateCartItem(params);
	    }

	    return 0; // 상품이 없으면 0 반환
	}


	@Override
	public Long calculateTotalAmount(List<CartItemVO> cartItems) {
        Long totalAmount = 0L;
        for (CartItemVO item : cartItems) {
            totalAmount += item.getGoods_total_price(); // 각 상품의 총 가격을 더함
        }
        return totalAmount;
    }
	
	public void updateSelection(Long goodsNo, int selected, String id) {
		Map<String, Object> params = new HashMap<>();
	    params.put("goodsNo", goodsNo);
	    params.put("selected", selected); // 'selected'가 맞는지 확인
	    params.put("id", id);
		
		mapper.updateSelection(params);
	}

	@Override
    public void updateGoodsTotalPrice(Long goods_no, int quantity) {
        // 상품 조회
        CartItemVO item = mapper.getCartItemByGoodsNo(goods_no); // CartMapper를 통해 상품 정보 조회
        

        // 총 가격 계산
        Long goods_Tprice = (item.getPrice()-item.getDiscount()) * quantity + item.getDelivery_charge();

        // 총 가격 업데이트
        item.setGoods_total_price(goods_Tprice); // 총 가격을 CartItemVO에 업데이트
        mapper.updateGoodsTotalPrice(item); // DB에 총 가격 업데이트
    }

	@Override
	public void removeSelectedItems(String id) {
		// TODO Auto-generated method stub
		mapper.deleteSelectedItems(id);
	}

	@Override
    public void savePaymentHistory(HistoryVO history, List<PaymentDetailVO> details) {
        // 결제 내역 저장
        mapper.insertHistory(history);
        
        // 결제 상세 정보 저장
        for (PaymentDetailVO detail : details) {
            mapper.insertPaymentDetail(detail);
        }
    }

	public List<HistoryVO> getPaymentHistory(String id) {
        return mapper.selectHistoryByUserId(id);
    }

    public List<PaymentDetailVO> getPaymentDetails(String orderNumber) {
        return mapper.selectPaymentDetailsByOrderNumber(orderNumber);
    }
    
    @Override
    public HistoryVO getHistoryByOrderNumber(String orderNumber) {
        return mapper.getHistoryByOrderNumber(orderNumber);
    }


    @Override
    public void addCartItem(CartItemVO cartItem) throws Exception {
        mapper.insertCartItem(cartItem);
    }
    
    @Override
    public void addBuyItem(BuyItemVO buyItem) throws Exception {
    	mapper.insertBuyItem(buyItem);
    }


}

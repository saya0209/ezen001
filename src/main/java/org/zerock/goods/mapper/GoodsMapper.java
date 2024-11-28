package org.zerock.goods.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.goods.vo.Cpu;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.goods.vo.Graphic_Card;
import org.zerock.goods.vo.Memory;
import org.zerock.util.page.PageObject;

@Repository
public interface GoodsMapper {

	// 상품 조회 후 없으면 생성
	
	// 동일한 구성의 상품을 조회
    public GoodsVO GoodsCheck(@Param("cpu_id") int cpu_id, 
                                    @Param("memory_id") int memory_id, 
                                    @Param("graphic_Card_id") int graphic_Card_id);
    
    // CPU 리스트 조회
    public List<Cpu> getCpuList();

    // Memory 리스트 조회
    public List<Memory> getMemoryList();

    // Graphic Card 리스트 조회
    public List<Graphic_Card> getGraphic_CardList();
    
    // 새로운 상품을 삽입
    public void insertGoods(GoodsVO goods);
    
    public Integer insertGoods1(GoodsVO goods);

    // 부품별 가격 가져오기
    public Integer getcpu_price(@Param("cpu_id") int cpu_id);
    public Integer getmemory_price(@Param("memory_id") int memory_id);
    public Integer getgraphic_Card_price(@Param("graphic_Card_id") int graphic_Card_id);
    
    // 각 부품 이름 가져오기
    public String getcpu_name(int cpu_id); // CPU 이름 조회
    public String getmemory_name(int memory_id); // 메모리 이름 조회
    public String getgraphic_Card_name(int graphic_Card_id); // 그래픽카드 이름 조회

	
    // 상품 리스트 조회
	public List<GoodsVO> list(
			@Param("pageObject") PageObject pageObject);
	
	// 조회수 증가
	public Integer increase(Long goods_no);
	
	
    // 상품 상세 조회
    public GoodsVO view(@Param("goods_no") Long goods_no);
    
    // 상품 등록
    public Integer write(GoodsVO goodsVO);
    
    public Integer cpuwrite(GoodsVO goodsVO);
    

    // 상품 수정
    public Integer update(Long goods_no);
    
    
 // 상품 이미지 리스트
 	public List<GoodsImageVO> image_name(@Param("goods_no") Long goods_no);


    // 이미지 삭제
    public Long delete(Long goods_no);

    // 상품 총 개수 (페이징용)
    int getTotalCount(PageObject pageObject);

	public List<Cpu> getcpu_id();
	
	public List<Memory> getmemory_id();
	
	public List<Graphic_Card> getgraphic_Card_id();
	
	
	// 상품 수정
    public Integer update(GoodsVO goods_no);

	public Graphic_Card getGraphic_CardById(int graphic_CardId);

	public Memory getMemoryById(int memoryId);

	public Cpu getCpuById(int cpuId);

	public List<GoodsVO> selectGoodsCategory(@Param("category") String category, @Param("pageObject") PageObject pageObject);

	List<GoodsVO> getGoodsList(@Param("pageObject") PageObject pageObject, @Param("sort") String sort, @Param("category") String category);
	
	List<GoodsVO> getGoodsListSortedByHit(@Param("pageObject") PageObject pageObject, @Param("category") String category);
	List<GoodsVO> getGoodsListSortedHit(@Param("pageObject") PageObject pageObject, @Param("category") String category);
    List<GoodsVO> getGoodsListSortedByPriceAsc(@Param("pageObject") PageObject pageObject, @Param("category") String category);
    List<GoodsVO> getGoodsListSortedPriceAsc(@Param("pageObject") PageObject pageObject, @Param("category") String category);
    List<GoodsVO> getGoodsListSortedByPriceDesc(@Param("pageObject") PageObject pageObject, @Param("category") String category);
    List<GoodsVO> getGoodsListSortedPriceDesc(@Param("pageObject") PageObject pageObject, @Param("category") String category);
}
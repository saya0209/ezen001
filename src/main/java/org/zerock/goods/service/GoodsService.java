package org.zerock.goods.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.zerock.goods.vo.Cpu;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.goods.vo.Graphic_Card;
import org.zerock.goods.vo.Memory;
import org.zerock.util.page.PageObject;

public interface GoodsService {

	// 상품 조회 후 없으면 생성
	
	public GoodsVO GoodsCheck(int cpu_id, int memory_id, int graphic_Card_id);  // 동일 구성 조회
	public GoodsVO insertGoods(int cpu_id, int memory_id, int graphic_Card_id); // 새 구성 생성
	
	// CPU 리스트
    public List<Cpu> getCpuList();

    // Memory 리스트
    public List<Memory> getMemoryList();

    // Graphic Card 리스트
    public List<Graphic_Card> getGraphic_CardList();

    // 상품 등록
    public void registerGoods(GoodsVO goods);

    // 이미지 업로드 (대표 이미지)
    public String uploadImage(MultipartFile file, HttpServletRequest request);

    // 추가 이미지 업로드
    public String[] uploadImages(MultipartFile[] files);
	
	
    // 상품 리스트 조회
    public List<GoodsVO> list(PageObject pageObject);

    // 상품 상세 조회
    public GoodsVO view(Long goods_no);
    

    // 상품 등록
    public Integer write(GoodsVO goodsvo);

    
    // 상품 이미지 리스트
 	public List<GoodsImageVO> image_main(Long goods_no);

    // 상품 삭제
    public Long delete(Long goods_no);
    
	public List<Cpu> getcpu_id();
	
	public List<Memory> getmemory_id();
	
	public List<Graphic_Card> getgraphic_Card_id();
	
	public Integer update(GoodsVO goods);
	
	public Cpu getcpu_id(int cpu_id);
	
	public Memory getmemory_id(int memory_id);
	
	public Graphic_Card getgraphic_Card_id(int graphic_Card_id);

    
}
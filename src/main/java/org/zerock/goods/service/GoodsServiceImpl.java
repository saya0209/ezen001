package org.zerock.goods.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.goods.mapper.GoodsMapper;
import org.zerock.goods.vo.Cpu;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.goods.vo.Graphic_Card;
import org.zerock.goods.vo.Memory;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Qualifier("goodsServiceImpl")
@Log4j
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    // 기존데이터 조회 후, 없으면 생성
    
    @Override
    public GoodsVO GoodsCheck(int cpu_id, int memory_id, int graphic_card_id) {
        return goodsMapper.GoodsCheck(cpu_id, memory_id, graphic_card_id);
    }

    @Override
    public GoodsVO insertGoods(int cpu_id, int memory_id, int graphic_card_id) {
        
        String cpuName = goodsMapper.getcpu_name(cpu_id);
        String memoryName = goodsMapper.getmemory_name(memory_id);
        String graphic_CardName = goodsMapper.getgraphic_Card_name(graphic_card_id);

        

        // 새 GoodsVO 객체 생성 및 설정
        GoodsVO goodsVO = new GoodsVO();

        // CPU, Memory, Graphic_Card 객체 생성 및 설정
        Cpu cpu = new Cpu();
        cpu.setCpu_id(cpu_id);
        cpu.setCpu_name(cpuName);

        Memory memory = new Memory();
        memory.setMemory_id(memory_id);
        memory.setMemory_name(memoryName); // 메모리 이름 설정

        Graphic_Card graphic_Card = new Graphic_Card();
        graphic_Card.setGraphic_Card_id(graphic_card_id);
        graphic_Card.setGraphic_Card_name(graphic_CardName); // 그래픽카드 이름 설정

        // GoodsVO 필드 설정
        goodsVO.setCpu_id(cpu_id);
        goodsVO.setMemory_id(memory_id);
        goodsVO.setGraphic_Card_id(graphic_card_id);
        goodsVO.setCpu_name(cpuName);  // CPU 이름 설정
        goodsVO.setMemory_name(memoryName);  // 메모리 이름 설정
        goodsVO.setGraphic_Card_name(graphic_CardName);  // 그래픽카드 이름 설정

        // goods 테이블에 삽입
        goodsMapper.insertGoods(goodsVO);
        return goodsVO;
    }
    

    
    
    public interface GoodsService {
        List<GoodsVO> getCpuOptions();
    }
    
    // 상품 수정 처리
    @Override
    public Integer update(GoodsVO goodsVO) {
        return goodsMapper.update(goodsVO);
    }
    
    @Override
    public List<Cpu> getCpuList() {
        return goodsMapper.getCpuList();
    }

    @Override
    public List<Memory> getMemoryList() {
        return goodsMapper.getMemoryList();
    }

    @Override
    public List<Graphic_Card> getGraphic_CardList() {
        return goodsMapper.getGraphic_CardList();
    }

    @Override
    public void registerGoods(GoodsVO goods) {
        goodsMapper.insertGoods(goods);
    }

    
    
    // 상품 리스트 조회
    @Override
    public List<GoodsVO> list(PageObject pageObject) {
        // 페이징 처리를 위해 시작 행과 끝 행을 계산하여 Mapper에 전달
        pageObject.setTotalRow(goodsMapper.getTotalCount(pageObject));  // 전체 상품 개수
        return goodsMapper.list(pageObject);
    }

    // 상품 상세 조회
    @Override
    public GoodsVO view(Long goods_no) {
        return goodsMapper.view(goods_no);
    }

    // 상품 등록
    @Override
    public Integer write(GoodsVO goodsVO) {
        return goodsMapper.write(goodsVO);
    }

    
    // 상품 이미지 리스트
 	@Override
 	public List<GoodsImageVO> image_name(Long goods_no) {
 		// TODO Auto-generated method stub
 		return goodsMapper.image_name(goods_no);
 	}
 	
 // 이미지 업로드 기본 경로 (프로퍼티로 관리 가능)
    @Value("C:\\Users\\EZEN\\git\\ex00\\src\\main\\webapp\\images")
    private String uploadDir;

    
    // 대표 이미지 업로드 처리
    @Override
    public String uploadImage(MultipartFile image, HttpServletRequest request) {
        // 파일 이름에 중복 방지용 UUID 추가
        String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();

        String realSavePath
		= request.getServletContext().getRealPath("/images");
        // 업로드할 파일 경로
        //Path path = Path.of(uploadDir, fileName);

        log.info("realSavePath : " + realSavePath);
        // 디렉토리가 없으면 생성
        //File dir = path.getParent().toFile();
        File dir = new File(realSavePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        File saveFile = new File(realSavePath + "/" +  fileName);
        log.info("dir" + dir);
        // 파일 복사
        try {
        	image.transferTo(saveFile);
            //Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        // 저장된 경로 반환
        return "/images/" + fileName;
    }

    // 추가 이미지 업로드 처리
    @Override
    public String[] uploadImages(MultipartFile[] images) {
        List<String> imagePaths = new ArrayList<>();

        for (MultipartFile image : images) {
            // 파일 이름에 UUID 추가
            String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();

            // 업로드할 파일 경로
            Path path = Path.of(uploadDir, fileName);

            // 디렉토리 생성
            File dir = path.getParent().toFile();
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 파일 복사
            try {
                Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                imagePaths.add(path.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 파일 경로 배열 반환
        return imagePaths.toArray(new String[0]);
    }


    // 이미지 삭제
    @Override
    public Long delete(Long goods_no) {
        return goodsMapper.delete(goods_no);
    }

    @Override
    public List<Cpu> getcpu_id() {
        return goodsMapper.getcpu_id();
    }
    
    @Override
    public List<Memory> getmemory_id() {
    	return goodsMapper.getmemory_id();
    }
    
    @Override
    public List<Graphic_Card> getgraphic_Card_id() {
    	return goodsMapper.getgraphic_Card_id();
    }

	@Override
	public Cpu getcpu_id(int cpu_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Memory getmemory_id(int memory_idd) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Graphic_Card getgraphic_Card_id(int graphic_Card_id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<GoodsVO> listCategory(String category, PageObject pageObject) {
        return goodsMapper.selectGoodsCategory(category, pageObject);  // 카테고리로 상품 조회
    }
}
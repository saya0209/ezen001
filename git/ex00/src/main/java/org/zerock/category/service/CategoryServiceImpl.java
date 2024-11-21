package org.zerock.category.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.category.mapper.CategoryMapper;
import org.zerock.category.vo.CategoryVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("categoryServiceImpl")
public class CategoryServiceImpl implements CategoryService {
    
    @Setter(onMethod_ = @Autowired)
    private CategoryMapper mapper;

    // 1. 카테고리 리스트
//    @Override
//    public List<CategoryVO> list(Integer cate_code1) {
//        return mapper.list(cate_code1);
//    }
//    @Override
//    public List<CategoryVO> list(Integer cate_code1, Integer cate_code2) {
//        return mapper.list(cate_code1, cate_code2); // 추가된 메서드에서 Mapper를 호출
//    }
    @Override
    public List<CategoryVO> list(Integer cate_code1, Integer cate_code2, Integer cate_code3) {
        return mapper.list(cate_code1, cate_code2, cate_code3); 
    }

    // 2. 카테고리 등록
    @Override
    public Integer write(CategoryVO vo) {
        if (vo.getCate_code2() == null && vo.getCate_code3() == null) {
            return mapper.writeBig(vo); // 대분류 등록
        } else if (vo.getCate_code3() == null) {
            // 중분류 이름 설정
            vo.setCate_name("중분류 이름"); // 적절한 중분류 이름으로 변경
            return mapper.writeMid(vo); // 중분류 등록
        } else {
            // 소분류 이름 설정
            vo.setCate_name("소분류 이름"); // 적절한 소분류 이름으로 변경
            return mapper.writeSmall(vo); // 소분류 등록
        }
    }

    // 3. 카테고리 수정
    @Override
    public Integer update(CategoryVO vo) {
        return mapper.update(vo);
    }

    // 4. 카테고리 삭제
    @Override
    public Integer delete(CategoryVO vo) {
        return mapper.delete(vo);
    }

	@Override
	public List<CategoryVO> list(Integer cate_code1) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CategoryVO> list(Integer cate_code1, Integer cate_code2) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer writeBig(CategoryVO vo) {
		// TODO Auto-generated method stub
		return mapper.writeBig(vo);
	}

	@Override
	public Integer writeMid(CategoryVO vo) {
		// TODO Auto-generated method stub
		return mapper.writeMid(vo);
	}

	@Override
	public Integer writeSmall(CategoryVO vo) {
		// TODO Auto-generated method stub
		return mapper.writeSmall(vo);
	}
}
package org.zerock.category.service;

import java.util.List;

import org.zerock.category.vo.CategoryVO;

public interface CategoryService {

    // 1. 카테고리 리스트
    public List<CategoryVO> list(Integer cate_code1);
    public List<CategoryVO> list(Integer cate_code1, Integer cate_code2);
    public List<CategoryVO> list(Integer cate_code1, Integer cate_code2, Integer cate_code3);

    // 2. 카테고리 등록
    public Integer write(CategoryVO vo);
    public Integer writeBig(CategoryVO vo); // 대분류 등록
    public Integer writeMid(CategoryVO vo); // 중분류 등록
    public Integer writeSmall(CategoryVO vo); // 소분류 등록

    // 3. 카테고리 수정
    public Integer update(CategoryVO vo);

    // 4. 카테고리 삭제
    public Integer delete(CategoryVO vo);

}
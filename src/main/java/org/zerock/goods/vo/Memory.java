package org.zerock.goods.vo;

import lombok.Data;

// Memory VO
@Data
public class Memory {
    private int memory_id;      // 메모리 고유 번호
    private String memory_name;  // 메모리 크기 (예: '4GB', '8GB', '12GB')
    private int memory_price;      // 메모리 가격
}
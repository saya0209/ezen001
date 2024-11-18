package org.zerock.memberAjax.vo;

import java.util.Date;

public class MemberAjaxVO {
	//order
	
	//cartItem
    private Long goods_no;            // 상품 번호
    private String goods_name;         // 상품 이름
    private String image_name;         // 상품 이미지 파일명
    private Long price;                // 상품 가격
    private Integer quantity;          // 상품 수량
    private Long goods_total_price;         // 상품 총 가격 (price * quantity + delivery_charge)
    private Long selected_goods_price; // 선택된 상품 총 가격 (체크된 상품의 총 합계)
    private Long delivery_charge;       // 배송비
    private Long cart_no;              // 장바구니 번호
    private Long discount;              // 개별 상품의 할인액
    private Long total_discount;        // 전체 할인가
    private Integer selected;           // 선택 여부 (1: 선택, 0: 미선택)
    private Long totalAmount;           // 최종 가격 (장바구니에 담긴 모든 상품의 총 합계)
    private Date purchase_date;         // 구매 날짜
    private String category;            // 상품 카테고리

    
    
	
	//member
	   private String status;
	   private String id;
	   private String pw;
	   private String nicname;
	   private String tel;
	   private String email;
	   private String address;
	   private Date regDate;
	   private Date conDate;
	   //grade table
	   private Integer gradeNo;
	   private String gradeName;
	   private String grade_image;
	   
	//getter and setter 
	   
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getNicname() {
		return nicname;
	}
	public void setNicname(String nicname) {
		this.nicname = nicname;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getConDate() {
		return conDate;
	}
	public void setConDate(Date conDate) {
		this.conDate = conDate;
	}
	public Integer getGradeNo() {
		return gradeNo;
	}
	public void setGradeNo(Integer gradeNo) {
		this.gradeNo = gradeNo;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getGrade_image() {
		return grade_image;
	}
	public void setGrade_image(String grade_image) {
		this.grade_image = grade_image;
	}
	
}

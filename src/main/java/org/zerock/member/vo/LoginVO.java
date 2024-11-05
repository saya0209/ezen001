package org.zerock.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class LoginVO {

	   private Integer status;
	   private String id;
	   private String pw;
	   private String nicname;
	   private Integer tel;
	   private String email;
	   private String address;
	   private Date regDate;
	   private Date conDate;
	   //grade table
	   private Integer gradeNo;
	   private String gradeName;
	   private String grade_image;
	   
	
	
}

package data.dto;

import java.sql.Timestamp;

public class LoginDto {
	//필드
	private String num;
	private String pw;
	private String email;
	private String name;
	private String postcode;
	private String addr1;
	private String addr2;
	private String mobile1;
	private String mobile2;
	private String mobile3;
	private Timestamp registerDay;

	//생성자
	public LoginDto(){}
	
	public LoginDto(String pw, String email, String name) {
		super();
		this.pw = pw;
		this.email = email;
		this.name = name;
	}
	
	
	
	public LoginDto(String pw, String email, String name, String postcode, String addr1, String addr2,
			String mobile1, String mobile2, String mobile3) {
		super();
		this.pw = pw;
		this.email = email;
		this.name = name;
		this.postcode = postcode;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.mobile1 = mobile1;
		this.mobile2 = mobile2;
		this.mobile3 = mobile3;
	}
	
	

	public LoginDto(String num, String pw, String email, String name, String postcode, String addr1, String addr2,
			String mobile1, String mobile2, String mobile3, Timestamp registerDay) {
		super();
		this.num = num;
		this.pw = pw;
		this.email = email;
		this.name = name;
		this.postcode = postcode;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.mobile1 = mobile1;
		this.mobile2 = mobile2;
		this.mobile3 = mobile3;
		this.registerDay = registerDay;
	}

	//getter setter
	
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getMobile1() {
		return mobile1;
	}

	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}

	public String getMobile2() {
		return mobile2;
	}

	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}

	public String getMobile3() {
		return mobile3;
	}

	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}

	public Timestamp getRegisterDay() {
		return registerDay;
	}

	public void setRegisterDay(Timestamp registerDay) {
		this.registerDay = registerDay;
	}



}

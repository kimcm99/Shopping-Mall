package boss.model;

import java.sql.Date;

public class Orders {

	private int oid; // pk 시퀀스
	private String memail; // fk 멤버이름
	private String oname; // 수령인 이름
	private String ophone; // 수령인 휴대폰번호
	private String opost; // 수령인 우편번호
	private String oaddress; // 수령인 주소
	private int ototalprice; // 총 가격
	private int odelivery; // 배송비
	private String omessage; // 배송 메세지
	private Date oreg; // 주문날짜
	
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	public String getOphone() {
		return ophone;
	}
	public void setOphone(String ophone) {
		this.ophone = ophone;
	}
	public String getOpost() {
		return opost;
	}
	public void setOpost(String opost) {
		this.opost = opost;
	}
	public String getOaddress() {
		return oaddress;
	}
	public void setOaddress(String oaddress) {
		this.oaddress = oaddress;
	}
	public int getOtotalprice() {
		return ototalprice;
	}
	public void setOtotalprice(int ototalprice) {
		this.ototalprice = ototalprice;
	}
	public int getOdelivery() {
		return odelivery;
	}
	public void setOdelivery(int odelivery) {
		this.odelivery = odelivery;
	}
	public String getOmessage() {
		return omessage;
	}
	public void setOmessage(String omessage) {
		this.omessage = omessage;
	}
	public Date getOreg() {
		return oreg;
	}
	public void setOreg(Date oreg) {
		this.oreg = oreg;
	}
	 
	
	

}

    
   

package boss.model;

import java.util.Date;

public class Product {

	private int pid; // 상품 고유코드(시퀀스)
	private String cid; // 카테고리 고유ID 
	private String pname; // 상품명
	private String pcontent; // 상품 설명
	private String pimage; // 상품 이미지
	private int pprice; // 상품 가격
	private Date preg; // 상품 등록일
	private String pcolor; // 상품 색상
	private String psize; // 상품 사이즈
	private int preadcount; // 상품 조회수
	private String pdrop; // 삭제 여부(Y/N) 
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public int getPprice() {
		return pprice;
	}
	public void setPprice(int pprice) {
		this.pprice = pprice;
	}
	public Date getPreg() {
		return preg;
	}
	public void setPreg(Date preg) {
		this.preg = preg;
	}
	public String getPcolor() {
		return pcolor;
	}
	public void setPcolor(String pcolor) {
		this.pcolor = pcolor;
	}
	public String getPsize() {
		return psize;
	}
	public void setPsize(String psize) {
		this.psize = psize;
	}
	public int getPreadcount() {
		return preadcount;
	}
	public void setPreadcount(int preadcount) {
		this.preadcount = preadcount;
	}
	public String getPdrop() {
		return pdrop;
	}
	public void setPdrop(String pdrop) {
		this.pdrop = pdrop;
	}

	// by hyesun start
	// 상품 정보를 문자열로 변환하는 코드
	public String toString() {
		String res = "";
		res += "이름: " + pname;
		res += ", 분류: " + cid;
		res += ", 설명: " + pcontent;
		res += ", 가격: " + pprice;
		res += ", 색깔: " + pcolor;
		res += ", 사이즈: " + psize;
		res += ", 인기도: " + preadcount;

		return res;
	}
	// by hyesun end
}

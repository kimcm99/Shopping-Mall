package boss.model;

public class OrderDetail {

	private int odid; // pk 주문상세번호 (시퀀스)
	private int oid; // fk 주문번호 (odid의 기준점.)
	private int pid; // fk 상품번호 (개별값이 들어감.)
	private String cid; // fk 카테고리번호
	private String odname; // 상품이름
	private String odcontent; // 상품설명
	private String odimage; // 상품이미지
	private int odcount; // 구매수량 (재고 - 해당번호 => 최신화)
	private String odcolor; // 상품 색상
	private String odsize; // 상품 사이즈
	private int odprice; // 상품 가격
	private int odstatus; // 주문상태를 나타냄 (defalut : 0 ( 배송대기 ) 1 : ( 배송완료 ) 2 : ( 환불처리중 ) 3 : ( 환불완료 )
	public int getOdid() {
		return odid;
	}
	public void setOdid(int odid) {
		this.odid = odid;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
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
	public String getOdname() {
		return odname;
	}
	public void setOdname(String odname) {
		this.odname = odname;
	}
	public String getOdcontent() {
		return odcontent;
	}
	public void setOdcontent(String odcontent) {
		this.odcontent = odcontent;
	}
	public String getOdimage() {
		return odimage;
	}
	public void setOdimage(String odimage) {
		this.odimage = odimage;
	}
	public int getOdcount() {
		return odcount;
	}
	public void setOdcount(int odcount) {
		this.odcount = odcount;
	}
	public String getOdcolor() {
		return odcolor;
	}
	public void setOdcolor(String odcolor) {
		this.odcolor = odcolor;
	}
	public String getOdsize() {
		return odsize;
	}
	public void setOdsize(String odsize) {
		this.odsize = odsize;
	}
	public int getOdprice() {
		return odprice;
	}
	public void setOdprice(int odprice) {
		this.odprice = odprice;
	}
	public int getOdstatus() {
		return odstatus;
	}
	public void setOdstatus(int odstatus) {
		this.odstatus = odstatus;
	}
	
	

}

   
   



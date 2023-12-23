package boss.model;

import java.sql.Date;

public class Review {

	private int rid; // pk(시퀀스) 리뷰번호
	private String memail; // fk 회원번호
	private int oid; // fk 주문번호
	private int pid; // fk 상품번호
	private String rwriter; // 작성자
	private String rtitle; // 제목
	private String rimage; // 이미지번호
	private Date rreg; // 작성일
	private int rreadcount; // 리뷰 조회수
	private String rdrop; // 삭제여부
	private String rcontent; // 글내용

	public String getRcontent() {
		return rcontent;
	}

	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public String getMemail() {
		return memail;
	}

	public void setMemail(String memail) {
		this.memail = memail;
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

	public String getRwriter() {
		return rwriter;
	}

	public void setRwriter(String rwriter) {
		this.rwriter = rwriter;
	}

	public String getRtitle() {
		return rtitle;
	}

	public void setRtitle(String rtitle) {
		this.rtitle = rtitle;
	}

	public String getRimage() {
		return rimage;
	}

	public void setRimage(String rimage) {
		this.rimage = rimage;
	}

	public Date getRreg() {
		return rreg;
	}

	public void setRreg(Date rreg) {
		this.rreg = rreg;
	}

	public int getRreadcount() {
		return rreadcount;
	}

	public void setRreadcount(int rreadcount) {
		this.rreadcount = rreadcount;
	}

	public String getRdrop() {
		return rdrop;
	}

	public void setRdrop(String rdrop) {
		this.rdrop = rdrop;
	}

}

package boss.model;

import java.util.Date;

public class AskBoard {

	
	private int askid; // pk(시퀀스) 상품문의 번호 
	private String memail;	// fk 회원번호
	private int pid;		// fk 상품번호
	private String askcontent;	// 상품문의내용
	private Date askreg;		// 작성일
	private String askdrop;		// 삭제여부 'N' ,'Y'
	
	
	public int getAskid() {
		return askid;
	}
	public void setAskid(int askid) {
		this.askid = askid;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getAskcontent() {
		return askcontent;
	}
	public void setAskcontent(String askcontent) {
		this.askcontent = askcontent;
	}
	public Date getAskreg() {
		return askreg;
	}
	public void setAskreg(Date askreg) {
		this.askreg = askreg;
	}
	public String getAskdrop() {
		return askdrop;
	}
	public void setAskdrop(String askdrop) {
		this.askdrop = askdrop;
	}
}

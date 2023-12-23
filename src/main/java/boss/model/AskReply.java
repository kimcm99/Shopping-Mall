package boss.model;

import java.util.Date;

public class AskReply {

	private int arid;	// pk 상품문의 댓글 번호 
	private int askid;	// fk 상품문의 번호 
	private String memail;	// fk 회원번호
	private String arcontent;	// 댓글내용
	private Date arreg;			// 댓글 작성일
	private String ardrop;		// 댓글 삭제여부 'N','Y'
	
	
	public int getArid() {
		return arid;
	}
	public void setArid(int arid) {
		this.arid = arid;
	}
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
	public String getArcontent() {
		return arcontent;
	}
	public void setArcontent(String arcontent) {
		this.arcontent = arcontent;
	}
	public Date getArreg() {
		return arreg;
	}
	public void setArreg(Date arreg) {
		this.arreg = arreg;
	}
	public String getArdrop() {
		return ardrop;
	}
	public void setArdrop(String ardrop) {
		this.ardrop = ardrop;
	}
}

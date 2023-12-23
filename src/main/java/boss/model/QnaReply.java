package boss.model;

import java.util.Date;

import boss.common.RowNum;

public class QnaReply extends RowNum {

	private int qrid;
	private String memail;
	private int qid;
	private String qrcontent;
	private Date qrreg;
	private String qrdrop;
	
	public int getQrid() {
		return qrid;
	}
	public void setQrid(int qrid) {
		this.qrid = qrid;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public String getQrcontent() {
		return qrcontent;
	}
	public void setQrcontent(String qrcontent) {
		this.qrcontent = qrcontent;
	}
	public Date getQrreg() {
		return qrreg;
	}
	public void setQrreg(Date qrreg) {
		this.qrreg = qrreg;
	}
	public String getQrdrop() {
		return qrdrop;
	}
	public void setQrdrop(String qrdrop) {
		this.qrdrop = qrdrop;
	}
	
	
}





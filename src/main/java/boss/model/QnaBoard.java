package boss.model;

import java.util.Date;

public class QnaBoard extends QnaReply {

	private int qid;
	private String memail;
	private String qnatitle;
	private String qnacontent;
	private String qnaorifile;
	private Date qnareg;
	private String qnadrop;
	private String qnayn;	// 답변 여부 (Y/N)
	
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public String getQnatitle() {
		return qnatitle;
	}
	public void setQnatitle(String qnatitle) {
		this.qnatitle = qnatitle;
	}
	public String getQnacontent() {
		return qnacontent;
	}
	public void setQnacontent(String qnacontent) {
		this.qnacontent = qnacontent;
	}
	public String getQnaorifile() {
		return qnaorifile;
	}
	public void setQnaorifile(String qnaorifile) {
		this.qnaorifile = qnaorifile;
	}
	public Date getQnareg() {
		return qnareg;
	}
	public void setQnareg(Date qnareg) {
		this.qnareg = qnareg;
	}
	public String getQnadrop() {
		return qnadrop;
	}
	public void setQnadrop(String qnadrop) {
		this.qnadrop = qnadrop;
	}
	public String getQnayn() {
		return qnayn;
	}
	public void setQnayn(String qnayn) {
		this.qnayn = qnayn;
	}
	
	
	
}


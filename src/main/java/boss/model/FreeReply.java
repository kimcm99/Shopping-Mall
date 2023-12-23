package boss.model;

import java.util.Date;

public class FreeReply {
	private int frId; 			/* 댓글 Id */
	private String mEmail; 		/* 이메일 */
	private int fId; 			/* 자유 게시글 번호 */
	private String frContent; 	/* 댓글 내용 */
	private Date frReg; 		/* 댓글 작성일 */
	private String frDrop; 		/* 댓글 삭제여부 */

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	public int getfId() {
		return fId;
	}

	public void setfId(int fId) {
		this.fId = fId;
	}

	public String getFrContent() {
		return frContent;
	}

	public void setFrContent(String frContent) {
		this.frContent = frContent;
	}

	public Date getFrReg() {
		return frReg;
	}

	public void setFrReg(Date frReg) {
		this.frReg = frReg;
	}

	public String getFrDrop() {
		return frDrop;
	}

	public void setFrDrop(String frDrop) {
		this.frDrop = frDrop;
	}

}

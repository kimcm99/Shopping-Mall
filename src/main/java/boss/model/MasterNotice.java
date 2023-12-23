package boss.model;

import java.util.Date;

import boss.common.RowNum;

public class MasterNotice extends RowNum {

	private int mnId;
	private String mnTitle;
	private String mnContent;
	private Date mnReg;
	private String mnOriFile;
	private int mnReadCount;
	private int cntPage = 10; // 페이지 블럭

	public int getmnId() {
		return mnId;
	}

	public void setmnId(int mnid) {
		this.mnId = mnid;
	}

	public String getMnTitle() {
		return mnTitle;
	}

	public void setMnTitle(String mnTitle) {
		this.mnTitle = mnTitle;
	}

	public String getMnContent() {
		return mnContent;
	}

	public void setMnContent(String mnContent) {
		this.mnContent = mnContent;
	}

	public Date getMnReg() {
		return mnReg;
	}

	public void setMnReg(Date mnReg) {
		this.mnReg = mnReg;
	}

	public String getMnOriFile() {
		return mnOriFile;
	}

	public void setMnOriFile(String mnOriFile) {
		this.mnOriFile = mnOriFile;
	}

	public int getMnReadCount() {
		return mnReadCount;
	}

	public void setMnReadCount(int mnReadCount) {
		this.mnReadCount = mnReadCount;
	}

	public int getCntPage() {
		return cntPage;
	}

	public void setCntPage(int cntPage) {
		this.cntPage = cntPage;
	}
}

package boss.model;

import java.sql.Date;

public class Report {

	private int reportid; // PK 신고번호
	private String memail; // FK 신고자 ID
	private String reportname; // 신고당한 ID
	private String reporttitle; // 신고 제목
	private String reportcontent; // 신고 내용
	private String reportimage; // 신고 이미지
	private Date reportreg; // 신고 날짜
	private String reporttype; // 신고타입
	private int reportnum; // 해당글 번호
	private String reportreply; // 신고 답변
	private Date reportreplyreg; // 답변일
	private String reportanswer; // 답변여부
	private String reportdrop; // 삭제여부

	public int getReportid() {
		return reportid;
	}

	public void setReportid(int reportid) {
		this.reportid = reportid;
	}

	public String getMemail() {
		return memail;
	}

	public void setMemail(String memail) {
		this.memail = memail;
	}

	public String getReporttitle() {
		return reporttitle;
	}

	public void setReporttitle(String reporttitle) {
		this.reporttitle = reporttitle;
	}

	public String getReportcontent() {
		return reportcontent;
	}

	public void setReportcontent(String reportcontent) {
		this.reportcontent = reportcontent;
	}

	public String getReportimage() {
		return reportimage;
	}

	public void setReportimage(String reportimage) {
		this.reportimage = reportimage;
	}

	public Date getReportreg() {
		return reportreg;
	}

	public void setReportreg(Date reportreg) {
		this.reportreg = reportreg;
	}

	public String getReporttype() {
		return reporttype;
	}

	public void setReporttype(String reporttype) {
		this.reporttype = reporttype;
	}

	public int getReportnum() {
		return reportnum;
	}

	public void setReportnum(int reportnum) {
		this.reportnum = reportnum;
	}

	public String getReportname() {
		return reportname;
	}

	public void setReportname(String reportname) {
		this.reportname = reportname;
	}

	public String getReportreply() {
		return reportreply;
	}

	public void setReportreply(String reportreply) {
		this.reportreply = reportreply;
	}

	public Date getReportreplyreg() {
		return reportreplyreg;
	}

	public void setReportreplyreg(Date reportreplyreg) {
		this.reportreplyreg = reportreplyreg;
	}

	public String getReportanswer() {
		return reportanswer;
	}

	public void setReportanswer(String reportanswer) {
		this.reportanswer = reportanswer;
	}

	public String getReportdrop() {
		return reportdrop;
	}

	public void setReportdrop(String reportdrop) {
		this.reportdrop = reportdrop;
	}

}

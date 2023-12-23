package boss.model;

import java.util.Date;

public class FreeBoard {
	private int fId;			 /* 자유 게시글 번호 */
	private String mEmail; 		/* 이메일 */
	private String fTitle;		 /* 자유게시판 제목 */
	private String fContent; 	/* 내용 */
	private int fReadCount; 	/* 조회수 */
	private int fLike; 			/* 좋아요 */
	private Date fReg; 			/* 작성일 */
	private String fDrop; 		/* free 삭제 여부 */
	private String fImage;      /*첨부파일*/

	// page
	private int startRow;
	private int endRow;
	
	// 검색
	private String search;
	private String keyword;

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getfId() {
		return fId;
	}

	public void setfId(int fId) {
		this.fId = fId;
	}

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	public String getfTitle() {
		return fTitle;
	}

	public void setfTitle(String fTitle) {
		this.fTitle = fTitle;
	}

	public String getfContent() {
		return fContent;
	}

	public void setfContent(String fContent) {
		this.fContent = fContent;
	}

	public int getfReadCount() {
		return fReadCount;
	}

	public void setfReadCount(int fReadCount) {
		this.fReadCount = fReadCount;
	}

	public int getfLike() {
		return fLike;
	}

	public void setfLike(int fLike) {
		this.fLike = fLike;
	}

	public Date getfReg() {
		return fReg;
	}

	public void setfReg(Date fReg) {
		this.fReg = fReg;
	}

	public String getfDrop() {
		return fDrop;
	}

	public void setfDrop(String fDrop) {
		this.fDrop = fDrop;
	}

	
	public String getfImage() {
		return fImage;
	}

	public void setfImage(String fImage) {
		this.fImage = fImage;
	}

}

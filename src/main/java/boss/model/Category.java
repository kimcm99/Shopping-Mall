package boss.model;

import boss.common.Search;

public class Category extends Search {

	private int newStartRow; // SQL쿼리에 쓸 start, end
	private int newEndRow;  //SQL쿼리에 쓸 end
	private String newCid; // 카테고리 고유ID 
	private int cntPage = 10; // 페이지 블럭
 
	

	public String getNewCid() {
		return newCid;
	}

	public void setNewCid(String newCid) {
		this.newCid = newCid;
	}

	public int getNewStartRow() {
		return newStartRow;
	}

	public void setNewStartRow(int newStartRow) {
		this.newStartRow = newStartRow;
	}

	public int getNewEndRow() {
		return newEndRow;
	}

	public void setNewEndRow(int newEndRow) {
		this.newEndRow = newEndRow;
	}

	public int getCntPage() {
		return cntPage;
	}

	public void setCntPage(int cntPage) {
		this.cntPage = cntPage;
	}

	
}

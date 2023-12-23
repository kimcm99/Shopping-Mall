package boss.common;

import boss.controller.MasterMemberController;

public class Search extends MasterMemberController {
	private String searchtype = "";
	private String keyword = "";
	
	public String getSearchtype() {
		return searchtype;
	}
	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	

}

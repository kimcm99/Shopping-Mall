package boss.model;

import java.sql.Date;

public class Member {

	private String mEmail; // 이메일 (Primary Key)
	private String mPwd; // 비밀번호
	private String mName; // 회원실명
	private String mPhone; // 전화번호
	private String mPost; // 우편번호
	private String mAddress; // 주소
	private String mGrade; // 회원등급
	private Date mReg; // 날짜
	private String mDrop; // 삭제여부

	public String getmEmail() {  
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	public String getmPwd() {
		return mPwd;
	}

	public void setmPwd(String mPwd) {
		this.mPwd = mPwd;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getmPhone() {
		return mPhone;
	}

	public void setmPhone(String mPhone) {
		this.mPhone = mPhone;
	}

	public String getmPost() {
		return mPost;
	}

	public void setmPost(String mPost) {
		this.mPost = mPost;
	}

	public String getmAddress() {
		return mAddress;
	}

	public void setmAddress(String mAddress) {
		this.mAddress = mAddress;
	}

	public String getmGrade() {
		return mGrade;
	}

	public void setmGrade(String mGrade) {
		this.mGrade = mGrade;
	}

	public Date getmReg() {
		return mReg;
	}

	public void setmReg(Date mReg) {
		this.mReg = mReg;
	}

	public String getmDrop() {
		return mDrop;
	}

	public void setmDrop(String mDrop) {
		this.mDrop = mDrop;
	}
	
//	public int getStartRow() {
//		return StartRow;
//	}
//	public void setStartRow(int startRow) {
//		StartRow = startRow;
//	}
//	public int getEndRow() {
//		return EndRow;
//	}
//	public void setEndRow(int endRow) {
//		EndRow = endRow;
//	}

}
package boss.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boss.model.Member;

@Mapper
public interface MemberDao {
	
	// 회원가입
	public int insertMember(Member member);
	
	// 1명의 정보 가져오기
	public Member selectOne(String mEmail);
	
	// 네이버 회원 가입
	public int insertNMember(Map<String, Object> map);
	
	// 회원 정보 수정
	public int updateMember(Member member);
	
	// 회원 탈퇴
	public int deleteMember(String mEmail);
	
	// 카카오 회원 가입
	public int insertKMember(Map<String, Object> map);  
	
}

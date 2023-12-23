package boss.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.LikeDao;
import boss.model.Likes;

@Service
public class LikeService {
	
	@Autowired
	private LikeDao ldao;
	
	public int countLike(int fId) {
		// 2개의 parameter를 보내기 위해 Map 선언 및 Map에 데이터 삽입
		return ldao.countLike(fId);
	}

	
	public Likes findLike(int fId, String mEmail) {
		// 2개의 parameter를 보내기 위해 Map 선언 및 Map에 데이터 삽입
		Map<String, Object> number = new HashMap<String, Object>();
		number.put("fId", fId);
		number.put("mEmail", mEmail);
		return ldao.findLike(number);
	}

	public String toggleLike(int fId, String mEmail, String likeDrop) {
		// 좋아요가 DB에 저장이 되는것이 없으면 0이 그대로 리턴으로 넘어감	
		// 좋아요가 이미 있는지 확인하는 코드
		Map<String, Object> number = new HashMap<String, Object>();
		number.put("fId", fId);
		number.put("mEmail", mEmail);
		Likes likeFound = ldao.findLike(number);
		System.out.println("likeFound:"+likeFound+", fId:"+fId+", mEmail:"+mEmail);
		//likeFound : db에 저장된 like
		// find가 null이면 좋아요가 없는 상태이므로 정보 저장
		// find가 null이 아니면 좋아요가 있는 상태이므로 정보 삭제
		Likes like = new Likes();
		like.setfId(fId);
		like.setmEmail(mEmail);
		if(likeFound==null) {
			// insert의 리턴값은 DB에 성공적으로 insert된 갯수를 보내므로 result가 1이 됨
			ldao.insertLike(like);
			System.out.println("likeFound(insert):"+ldao.findLike(number).getLikeDrop());
		} else {
			System.out.println("likeDrop(input):"+likeDrop);
			if(likeDrop.equals("Y"))
				like.setLikeDrop("N");
			else if(likeDrop.equals("N"))
				like.setLikeDrop("Y");
			
			System.out.println("likeDrop:"+like.getLikeDrop());
			System.out.println("likeDrop(DB before):"+ldao.findLike(number).getLikeDrop());
			ldao.updateLike(like);
			System.out.println("likeDrop(DB after):"+ldao.findLike(number).getLikeDrop());
		}
		
	    	// 0 or 1이 담겨져서 @Controller에 보냄.
		return ldao.findLike(number).getLikeDrop();
	}

	public Likes getEmail(int fId) {
		// TODO Auto-generated method stub
		return ldao.getEmail(fId);
	}
}

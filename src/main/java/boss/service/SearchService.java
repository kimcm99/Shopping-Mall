package boss.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.common.PagePgm;
import boss.common.Search;
import boss.dao.SearchDao;
import boss.model.Product;

@Service
public class SearchService {
	@Autowired
	SearchDao dao;

	public List<Product> allSearch(PagePgm pp) {

		return dao.allSearch(pp);
	}

	public int searchCount(String keyword) {

		return dao.searchCount(keyword);
	}

}

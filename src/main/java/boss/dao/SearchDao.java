package boss.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.Product;

@Mapper
public interface SearchDao {

	List<Product> allSearch(PagePgm pp);

	int searchCount(String keyword);

}

package mypage.dao;

public class MypageDao {

	private static MypageDao instance;
	
	private MypageDao() {
	}
	
	if(instance == null) {
		instance = new MypageDao();
	}
	
	return instance;
}

}
}
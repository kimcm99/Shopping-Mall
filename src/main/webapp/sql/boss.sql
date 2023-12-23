-- 테이블 만든거 쿼리문 ( db 사진 올려줬으니까 그거 보고 수정할게 있으면 알아서 수정하고 주석도 잘 남겨주세요 )--

/* 회원 */
CREATE TABLE Member (
   mEmail VARCHAR2(50) NOT NULL, /* 이메일 */
   mPwd VARCHAR2(20), /* 비밀번호 */
   mName VARCHAR2(20) NOT NULL, /* 이름 */
   mPhone VARCHAR2(20) NOT NULL, /* 핸드폰 */
   mPost VARCHAR2(20), /* 우편번호 */
   mAddress VARCHAR2(150), /* 주소 */
   mGrade VARCHAR2(20) DEFAULT 'WhiteStar' NOT NULL, /* 회원등급 */
   mReg DATE NOT NULL, /* 회원가입 날짜 */
   mDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 탈퇴여부 */
);

COMMENT ON TABLE Member IS '회원';

COMMENT ON COLUMN Member.mEmail IS '이메일';

COMMENT ON COLUMN Member.mPwd IS '비밀번호';

COMMENT ON COLUMN Member.mName IS '이름';

COMMENT ON COLUMN Member.mPhone IS '-처리 해야함';

COMMENT ON COLUMN Member.mPost IS '우편번호';

COMMENT ON COLUMN Member.mAddress IS '주소';

COMMENT ON COLUMN Member.mGrade IS 'default : WhiteStar';

COMMENT ON COLUMN Member.mReg IS 'sysdate';

COMMENT ON COLUMN Member.mDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_Member
   ON Member (
      mEmail ASC
   );

ALTER TABLE Member
   ADD
      CONSTRAINT PK_Member
      PRIMARY KEY (
         mEmail
      );

/* 상품 */
CREATE TABLE Product (
   pId NUMBER NOT NULL, /* 상품 고유코드 */
   cId VARCHAR2(50) NOT NULL, /* 카테고리 고유ID */
   pName VARCHAR2(1000) NOT NULL, /* 상품명 */
   pContent VARCHAR2(1000) NOT NULL, /* 상품 설명 */
   pImage VARCHAR2(600) NOT NULL, /* 상품 이미지 */
   pPrice NUMBER NOT NULL, /* 상품 가격 */
   pReg DATE NOT NULL, /* 상품 등록일 */
   pColor VARCHAR2(50) NOT NULL, /* 상품 색상 */
   pSize VARCHAR2(50) NOT NULL, /* 상품 사이즈 */
   pReadCount NUMBER NOT NULL, /* 상품 조회수 */
   pDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 삭제 여부 */
);

COMMENT ON TABLE Product IS '상품';

COMMENT ON COLUMN Product.pId IS '상품 고유코드(시퀀스)';

COMMENT ON COLUMN Product.cId IS '카테고리 고유ID';

COMMENT ON COLUMN Product.pName IS '상품명';

COMMENT ON COLUMN Product.pContent IS '상품 설명';

COMMENT ON COLUMN Product.pImage IS '상품 이미지';

COMMENT ON COLUMN Product.pPrice IS '상품 가격';

COMMENT ON COLUMN Product.pReg IS '상품 등록일';

COMMENT ON COLUMN Product.pColor IS '상품 색상';

COMMENT ON COLUMN Product.pSize IS '상품 사이즈';

COMMENT ON COLUMN Product.pReadCount IS '상품 조회수';

COMMENT ON COLUMN Product.pDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_Product
   ON Product (
      pId ASC
   );

ALTER TABLE Product
   ADD
      CONSTRAINT PK_Product
      PRIMARY KEY (
         pId
      );

/* 카테고리 */
CREATE TABLE Category (
   cId VARCHAR2(50) NOT NULL, /* 카테고리 고유ID */
   cName VARCHAR2(50) NOT NULL /* 상의 , 하의 */
);

COMMENT ON TABLE Category IS '카테고리';

COMMENT ON COLUMN Category.cId IS '카테고리 고유ID';

COMMENT ON COLUMN Category.cName IS '상의 , 하의 ~~';

CREATE UNIQUE INDEX PK_Category
   ON Category (
      cId ASC
   );

ALTER TABLE Category
   ADD
      CONSTRAINT PK_Category
      PRIMARY KEY (
         cId
      );

/* 장바구니 */
CREATE TABLE Bucket (
   bId NUMBER NOT NULL, /* 장바구니 고유번호 */
   mEmail VARCHAR2(50) NOT NULL, /* 이메일 */
   pId NUMBER NOT NULL, /* 상품 고유코드 */
   bName VARCHAR2(1000) NOT NULL, /* 상품명 */
   bImage VARCHAR2(600) NOT NULL, /* 상품 이미지 */
   bCount NUMBER NOT NULL, /* 상품 수량 */
   bSize VARCHAR2(20) NOT NULL, /* 상품 사이즈 */
   bColor VARCHAR2(20) NOT NULL, /* 상품 색상 */
   bPrice NUMBER NOT NULL, /* 상품 가격 */
   bDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 상품 삭제여부 */
);

COMMENT ON TABLE Bucket IS '장바구니';

COMMENT ON COLUMN Bucket.bId IS '시퀀스';

COMMENT ON COLUMN Bucket.mEmail IS '이메일';

COMMENT ON COLUMN Bucket.pId IS '상품 고유코드';

COMMENT ON COLUMN Bucket.bName IS '상품 테이블의 상품명';

COMMENT ON COLUMN Bucket.bImage IS '상품 테이블의 이미지';

COMMENT ON COLUMN Bucket.bCount IS '내가 사려고 정한 갯수';

COMMENT ON COLUMN Bucket.bSize IS '내가 사려고 한 사이즈';

COMMENT ON COLUMN Bucket.bColor IS '내가 사려고 한 색상';

COMMENT ON COLUMN Bucket.bPrice IS '상품 테이블의 가격';

COMMENT ON COLUMN Bucket.bDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_Bucket
   ON Bucket (
      bId ASC
   );

ALTER TABLE Bucket
   ADD
      CONSTRAINT PK_Bucket
      PRIMARY KEY (
         bId
      );

/* 주문 */
CREATE TABLE Orders (
   oId NUMBER NOT NULL, /* 주문 고유번호 */
   mEmail VARCHAR2(50), /* 이메일 */
   pId NUMBER NOT NULL, /* 상품 고유코드 */
   oProductName VARCHAR2(1000) NOT NULL, /* 주문 상품명 */
   oImage VARCHAR2(600) NOT NULL, /* 주문 상품 이미지 */
   oPrice NUMBER NOT NULL, /* 주문 상품 가격 */
   oCount NUMBER NOT NULL, /* 주문 상품 수량 */
   oName VARCHAR2(20) NOT NULL, /* 수령인 */
   oPhone VARCHAR2(20) NOT NULL, /* 수령인 핸드폰 번호 */
   oPost VARCHAR2(20) NOT NULL, /* 수령인 우편번호 */
   oAddress VARCHAR2(150) NOT NULL, /* 수령인 주소 */
   oTotalPrice NUMBER NOT NULL, /* 총주문가격 */
   oDelivery NUMBER NOT NULL, /* 배송비 */
   oMessage VARCHAR2(500), /* 배송 메세지 */
   oReg DATE NOT NULL /* 주문 날짜 */
);

COMMENT ON TABLE Orders IS '주문';

COMMENT ON COLUMN Orders.oId IS '시퀀스 ( 주문 고유 번호)';

COMMENT ON COLUMN Orders.mEmail IS '이메일';

COMMENT ON COLUMN Orders.pId IS '상품 고유코드';

COMMENT ON COLUMN Orders.oProductName IS '상품 테이블의 상품명 값 받아서 쓰면 됨';

COMMENT ON COLUMN Orders.oImage IS '상품 테이블의 이미지';

COMMENT ON COLUMN Orders.oPrice IS '상품 테이블의 상품 가격';

COMMENT ON COLUMN Orders.oCount IS '재고랑 다름 ( 내가 산 갯수 주문 하면 재고에서 빼줘야함 )';

COMMENT ON COLUMN Orders.oName IS '수령인';

COMMENT ON COLUMN Orders.oPhone IS '수령인 핸드폰 번호';

COMMENT ON COLUMN Orders.oPost IS '수령인 우편번호';

COMMENT ON COLUMN Orders.oAddress IS '수령인 주소';

COMMENT ON COLUMN Orders.oTotalPrice IS '총주문가격';

COMMENT ON COLUMN Orders.oDelivery IS '배송비';

COMMENT ON COLUMN Orders.oMessage IS '배송 메세지';

COMMENT ON COLUMN Orders.oReg IS '주문 날짜';

CREATE UNIQUE INDEX PK_Orders
   ON Orders (
      oId ASC
   );

ALTER TABLE Orders
   ADD
      CONSTRAINT PK_Orders
      PRIMARY KEY (
         oId
      );

/* 공지사항 */
CREATE TABLE MasterNotice (
   mnId NUMBER NOT NULL, /* 공지 번호 */
   mnTitle VARCHAR2(200) NOT NULL, /* 공지 이름 */
   mnContent VARCHAR2(1000) NOT NULL, /* 공지 내용 */
   mnReg DATE NOT NULL, /* 공지 등록일 */
   mnOriFile VARCHAR2(600), /* 공지 첨부파일 */
   mnReadCount NUMBER NOT NULL /* 공지 조회수 */
);

COMMENT ON TABLE MasterNotice IS '공지사항';

COMMENT ON COLUMN MasterNotice.mnId IS '시퀀스';

COMMENT ON COLUMN MasterNotice.mnTitle IS '공지 이름';

COMMENT ON COLUMN MasterNotice.mnContent IS '공지 내용';

COMMENT ON COLUMN MasterNotice.mnReg IS '공지 등록일';

COMMENT ON COLUMN MasterNotice.mnOriFile IS '공지 첨부파일';

COMMENT ON COLUMN MasterNotice.mnReadCount IS '공지 조회수';

CREATE UNIQUE INDEX PK_MasterNotice
   ON MasterNotice (
      mnId ASC
   );

ALTER TABLE MasterNotice
   ADD
      CONSTRAINT PK_MasterNotice
      PRIMARY KEY (
         mnId
      );

/* 1대1 문의 */
CREATE TABLE QnABoard (
   qId NUMBER NOT NULL, /* QnA게시글 번호 */
   mEmail VARCHAR2(50), /* 이메일 */
   qnaTitle VARCHAR2(100) NOT NULL, /* qna제목 */
   qnaContent VARCHAR2(1000) NOT NULL, /* 내용 */
   qnaOriFile VARCHAR2(600), /* 첨부파일 */
   qnaReg DATE NOT NULL, /* qna 쓴 날짜 */
   qnaDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* qna 삭제 여부 */
);

COMMENT ON TABLE QnABoard IS '1대1 문의';

COMMENT ON COLUMN QnABoard.qId IS '시퀀스';

COMMENT ON COLUMN QnABoard.mEmail IS '이메일';

COMMENT ON COLUMN QnABoard.qnaTitle IS 'qna제목';

COMMENT ON COLUMN QnABoard.qnaContent IS '내용';

COMMENT ON COLUMN QnABoard.qnaOriFile IS '첨부파일';

COMMENT ON COLUMN QnABoard.qnaReg IS 'qna 쓴 날짜';

COMMENT ON COLUMN QnABoard.qnaDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_QnABoard
   ON QnABoard (
      qId ASC
   );

ALTER TABLE QnABoard
   ADD
      CONSTRAINT PK_QnABoard
      PRIMARY KEY (
         qId
      );

/* 관리자 */
CREATE TABLE Master (
   masterId VARCHAR2(50) NOT NULL, /* 관리자 ID */
   masterPwd VARCHAR2(20) NOT NULL, /* 관리자 PW */
   masterName VARCHAR2(20) NOT NULL, /* 관리자 이름 */
   masterReg DATE NOT NULL /* 관리자 등록일 */
);

COMMENT ON TABLE Master IS '관리자';

COMMENT ON COLUMN Master.masterId IS '관리자 ID';

COMMENT ON COLUMN Master.masterPwd IS '관리자 PW';

COMMENT ON COLUMN Master.masterName IS '관리자 이름';

COMMENT ON COLUMN Master.masterReg IS '관리자 등록일';

CREATE UNIQUE INDEX PK_Master
   ON Master (
      masterId ASC
   );

ALTER TABLE Master
   ADD
      CONSTRAINT PK_Master
      PRIMARY KEY (
         masterId
      );

/* 별점 */
CREATE TABLE StarPoint (
   sTotal NUMBER, /* 별점합계 */
   sCount NUMBER, /* 별점매긴인원 카운트 */
   mEmail VARCHAR2(50), /* 이메일 */
   pId NUMBER NOT NULL /* 상품 고유코드 */
);

COMMENT ON TABLE StarPoint IS '별점';

COMMENT ON COLUMN StarPoint.sTotal IS '별점합계';

COMMENT ON COLUMN StarPoint.sCount IS '별점매긴인원 카운트';

COMMENT ON COLUMN StarPoint.mEmail IS '유효성검사';

COMMENT ON COLUMN StarPoint.pId IS '상품 고유코드';

/* 리뷰 */
CREATE TABLE Review (
   rId NUMBER NOT NULL, /* 게시글 번호 */
   mEmail VARCHAR2(50), /* 이메일 */
   oId NUMBER NOT NULL, /* 주문 고유번호 */
   pId NUMBER NOT NULL, /* 상품 고유코드 */
   rWriter VARCHAR2(20) NOT NULL, /* 리뷰 작성자 */
   rTitle VARCHAR2(50) NOT NULL, /* 리뷰 제목 */
   rImage VARCHAR2(600), /* 리뷰 이미지 */
   rReg DATE NOT NULL, /* 리뷰 작성일 */
   rReadCount NUMBER NOT NULL, /* 리뷰 조회수 */
   rDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 리뷰 삭제 여부 */
);

COMMENT ON TABLE Review IS '리뷰';

COMMENT ON COLUMN Review.rId IS '게시글 번호';

COMMENT ON COLUMN Review.mEmail IS '쇼핑몰 Email( readonly or 유효성검사)';

COMMENT ON COLUMN Review.oId IS '주문 아이디';

COMMENT ON COLUMN Review.pId IS '상품 고유코드';

COMMENT ON COLUMN Review.rWriter IS '리뷰 작성자';

COMMENT ON COLUMN Review.rTitle IS '리뷰 제목';

COMMENT ON COLUMN Review.rImage IS '리뷰 쓸때 이미지가 필수는 아님';

COMMENT ON COLUMN Review.rReg IS '리뷰 작성일';

COMMENT ON COLUMN Review.rReadCount IS '리뷰 조회수';

COMMENT ON COLUMN Review.rDrop IS '리뷰 삭제 여부';

CREATE UNIQUE INDEX PK_Review
   ON Review (
      rId ASC
   );

ALTER TABLE Review
   ADD
      CONSTRAINT PK_Review
      PRIMARY KEY (
         rId
      );

/* 자유게시판 */
CREATE TABLE FreeBoard (
   fId NUMBER NOT NULL, /* 자유 게시글 번호 */
   mEmail VARCHAR2(50), /* 이메일 */
   fTitle VARCHAR2(100) NOT NULL, /* 자유게시판 제목 */
   fContent VARCHAR2(1000) NOT NULL, /* 내용 */
   fReadCount NUMBER NOT NULL, /* 조회수 */
   fLike NUMBER NOT NULL, /* 좋아요 */
   fReg DATE NOT NULL, /* 작성일 */
   fDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* free 삭제 여부 */
);

COMMENT ON TABLE FreeBoard IS '자유게시판';

COMMENT ON COLUMN FreeBoard.fId IS '시퀀스';

COMMENT ON COLUMN FreeBoard.mEmail IS '이메일';

COMMENT ON COLUMN FreeBoard.fTitle IS '자유게시판 제목';

COMMENT ON COLUMN FreeBoard.fContent IS '내용';

COMMENT ON COLUMN FreeBoard.fReadCount IS '조회수';

COMMENT ON COLUMN FreeBoard.fLike IS '처음에 0으로 고정';

COMMENT ON COLUMN FreeBoard.fReg IS '작성일';

COMMENT ON COLUMN FreeBoard.fDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_FreeBoard
   ON FreeBoard (
      fId ASC
   );

ALTER TABLE FreeBoard
   ADD
      CONSTRAINT PK_FreeBoard
      PRIMARY KEY (
         fId
      );

/* 좋아요 */
CREATE TABLE Likes (
   likeId NUMBER NOT NULL, /* 좋아요 Id */
   fId NUMBER, /* 자유 게시글 번호 */
   mEmail VARCHAR2(50), /* 이메일 */
   likeDrop VARCHAR(20) DEFAULT 'N' /* 좋아요 여부 */
);

COMMENT ON TABLE Likes IS '좋아요';

COMMENT ON COLUMN Likes.likeId IS '시퀀스';

COMMENT ON COLUMN Likes.fId IS '자유 게시글 번호';

COMMENT ON COLUMN Likes.mEmail IS '중복여부 체킹';

COMMENT ON COLUMN Likes.likeDrop IS 'default : N / 좋아요 누른게 : Y';

CREATE UNIQUE INDEX PK_Likes
   ON Likes (
      likeId ASC
   );

ALTER TABLE Likes
   ADD
      CONSTRAINT PK_Likes
      PRIMARY KEY (
         likeId
      );

/* 재고 테이블 */
CREATE TABLE Amount (
   aId NUMBER NOT NULL, /* 재고 Id */
   pId NUMBER NOT NULL, /* 상품 고유코드 */
   aName VARCHAR2(1000) NOT NULL, /* 상품명 */
   aCount NUMBER NOT NULL /* 상품 갯수 */
);

COMMENT ON TABLE Amount IS '재고 테이블';

COMMENT ON COLUMN Amount.aId IS '시퀀스';

COMMENT ON COLUMN Amount.pId IS '상품 고유코드';

COMMENT ON COLUMN Amount.aName IS '상품명';

COMMENT ON COLUMN Amount.aCount IS '상품 갯수 ( 재고 갯수)';

CREATE UNIQUE INDEX PK_Amount
   ON Amount (
      aId ASC
   );

ALTER TABLE Amount
   ADD
      CONSTRAINT PK_Amount
      PRIMARY KEY (
         aId
      );

/* 주문 상세 */
CREATE TABLE OrderDetail (
   odId NUMBER NOT NULL, /* 주문 상세 고유번호 */
   oId NUMBER NOT NULL, /* 주문 고유번호 */
   pId NUMBER, /* 상품 고유코드 */
   odStatus NUMBER DEFAULT 0 NOT NULL /* 주문 상태 */
);

COMMENT ON TABLE OrderDetail IS '주문 상세';

COMMENT ON COLUMN OrderDetail.odId IS '시퀀스';

COMMENT ON COLUMN OrderDetail.oId IS '주문 고유번호 ( 시퀀스 ) ';

COMMENT ON COLUMN OrderDetail.pId IS '상품 코드 ( 시퀀스 )';

COMMENT ON COLUMN OrderDetail.odStatus IS 'defalut : 0 ( 배송대기 ) 1 : ( 배송완료 ) 2 : ( 환불처리중 ) 3 : ( 환불완료 ) ';

CREATE UNIQUE INDEX PK_OrderDetail
   ON OrderDetail (
      odId ASC
   );

ALTER TABLE OrderDetail
   ADD
      CONSTRAINT PK_OrderDetail
      PRIMARY KEY (
         odId
      );

/*  Free댓글 */
CREATE TABLE FreeReply (
   frId NUMBER NOT NULL, /* 댓글 Id */
   mEmail VARCHAR2(50) NOT NULL, /* 이메일 */
   fId NUMBER NOT NULL, /* 자유 게시글 번호 */
   frContent VARCHAR2(500) NOT NULL, /* 댓글 내용 */
   frReg DATE NOT NULL, /* 댓글 작성일 */
   frDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 댓글 삭제여부 */
);

COMMENT ON TABLE FreeReply IS ' Free댓글';

COMMENT ON COLUMN FreeReply.frId IS '시퀀스';

COMMENT ON COLUMN FreeReply.mEmail IS '이메일';

COMMENT ON COLUMN FreeReply.fId IS '자유 게시글 번호';

COMMENT ON COLUMN FreeReply.frContent IS '댓글 내용';

COMMENT ON COLUMN FreeReply.frReg IS '댓글 작성일';

COMMENT ON COLUMN FreeReply.frDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_FreeReply
   ON FreeReply (
      frId ASC
   );

ALTER TABLE FreeReply
   ADD
      CONSTRAINT PK_FreeReply
      PRIMARY KEY (
         frId
      );

/* QnA댓글 */
CREATE TABLE QnaReply (
   qrId NUMBER NOT NULL, /* 댓글 Id */
   mEmail VARCHAR2(50) NOT NULL, /* 이메일 */
   qId NUMBER NOT NULL, /* QnA게시글 번호 */
   qrContent VARCHAR2(500) NOT NULL, /* 댓글 내용 */
   qrReg DATE NOT NULL, /* 댓글 작성일 */
   qrDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 댓글 삭제여부 */
);

COMMENT ON TABLE QnaReply IS 'QnA댓글';

COMMENT ON COLUMN QnaReply.qrId IS '시퀀스';

COMMENT ON COLUMN QnaReply.mEmail IS '이메일';

COMMENT ON COLUMN QnaReply.qId IS 'QnA게시글 번호';

COMMENT ON COLUMN QnaReply.qrContent IS '댓글 내용';

COMMENT ON COLUMN QnaReply.qrReg IS '댓글 작성일';

COMMENT ON COLUMN QnaReply.qrDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_QnaReply
   ON QnaReply (
      qrId ASC
   );

ALTER TABLE QnaReply
   ADD
      CONSTRAINT PK_QnaReply
      PRIMARY KEY (
         qrId
      );

/* 상품문의 */
CREATE TABLE AskBoard (
   askId NUMBER NOT NULL, /* 상품문의 반호 */
   mEmail VARCHAR2(50) NOT NULL, /* 이메일 */
   pId NUMBER NOT NULL, /* 상품 고유코드 */
   askContent VARCHAR2(500) NOT NULL, /* 상품문의 내용 */
   askReg DATE NOT NULL, /* 상품문의 날짜 */
   askDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 상품문의 삭제여부 */
);

COMMENT ON TABLE AskBoard IS '상품문의';

COMMENT ON COLUMN AskBoard.askId IS '시퀀스';

COMMENT ON COLUMN AskBoard.mEmail IS '이메일';

COMMENT ON COLUMN AskBoard.pId IS '상품 고유코드';

COMMENT ON COLUMN AskBoard.askContent IS '상품문의 내용';

COMMENT ON COLUMN AskBoard.askReg IS '상품문의 날짜';

COMMENT ON COLUMN AskBoard.askDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_AskBoard
   ON AskBoard (
      askId ASC
   );

ALTER TABLE AskBoard
   ADD
      CONSTRAINT PK_AskBoard
      PRIMARY KEY (
         askId
      );

/* 상품문의 댓글 */
CREATE TABLE AskReply (
   arId NUMBER NOT NULL, /* 상품문의 댓글 번호 */
   askId NUMBER NOT NULL, /* 상품문의 반호 */
   mEmail VARCHAR2(50) NOT NULL, /* 이메일 */
   arContent VARCHAR2(500) NOT NULL, /* 댓글 내용 */
   arReg DATE NOT NULL, /* 댓글 작성일 */
   arDrop VARCHAR2(20) DEFAULT 'N' NOT NULL /* 댓글 삭제여부 */
);

COMMENT ON TABLE AskReply IS '상품문의 댓글';

COMMENT ON COLUMN AskReply.arId IS '시퀀스';

COMMENT ON COLUMN AskReply.askId IS '상품문의 반호';

COMMENT ON COLUMN AskReply.mEmail IS '이메일';

COMMENT ON COLUMN AskReply.arContent IS '댓글 내용';

COMMENT ON COLUMN AskReply.arReg IS '댓글 작성일';

COMMENT ON COLUMN AskReply.arDrop IS 'default : N / Drop : Y';

CREATE UNIQUE INDEX PK_AskReply
   ON AskReply (
      arId ASC
   );

ALTER TABLE AskReply
   ADD
      CONSTRAINT PK_AskReply
      PRIMARY KEY (
         arId
      );

/* Youtube */
CREATE TABLE Youtube (
   yId NUMBER NOT NULL, /* 유튜브 id */
   yUrl VARCHAR2(100) /* 유튜브 주소 */
);

COMMENT ON TABLE Youtube IS 'Youtube';

COMMENT ON COLUMN Youtube.yId IS '시퀀스';

COMMENT ON COLUMN Youtube.yUrl IS '유튜브 주소';

CREATE UNIQUE INDEX PK_Youtube
   ON Youtube (
      yId ASC
   );

ALTER TABLE Youtube
   ADD
      CONSTRAINT PK_Youtube
      PRIMARY KEY (
         yId
      );

ALTER TABLE Product
   ADD
      CONSTRAINT FK_Category_TO_Product
      FOREIGN KEY (
         cId
      )
      REFERENCES Category (
         cId
      );

ALTER TABLE Bucket
   ADD
      CONSTRAINT FK_Member_TO_Bucket
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE Bucket
   ADD
      CONSTRAINT FK_Product_TO_Bucket
      FOREIGN KEY (
         pId
      )
      REFERENCES Product (
         pId
      );

ALTER TABLE Orders
   ADD
      CONSTRAINT FK_Member_TO_Orders
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE Orders
   ADD
      CONSTRAINT FK_Product_TO_Orders
      FOREIGN KEY (
         pId
      )
      REFERENCES Product (
         pId
      );

ALTER TABLE QnABoard
   ADD
      CONSTRAINT FK_Member_TO_QnABoard
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE StarPoint
   ADD
      CONSTRAINT FK_Member_TO_StarPoint
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE StarPoint
   ADD
      CONSTRAINT FK_Product_TO_StarPoint
      FOREIGN KEY (
         pId
      )
      REFERENCES Product (
         pId
      );

ALTER TABLE Review
   ADD
      CONSTRAINT FK_Orders_TO_Review
      FOREIGN KEY (
         oId
      )
      REFERENCES Orders (
         oId
      );

ALTER TABLE Review
   ADD
      CONSTRAINT FK_Member_TO_Review
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE Review
   ADD
      CONSTRAINT FK_Product_TO_Review
      FOREIGN KEY (
         pId
      )
      REFERENCES Product (
         pId
      );

ALTER TABLE FreeBoard
   ADD
      CONSTRAINT FK_Member_TO_FreeBoard
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE Likes
   ADD
      CONSTRAINT FK_FreeBoard_TO_Likes
      FOREIGN KEY (
         fId
      )
      REFERENCES FreeBoard (
         fId
      );

ALTER TABLE Likes
   ADD
      CONSTRAINT FK_Member_TO_Likes
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE Amount
   ADD
      CONSTRAINT FK_Product_TO_Amount
      FOREIGN KEY (
         pId
      )
      REFERENCES Product (
         pId
      );

ALTER TABLE OrderDetail
   ADD
      CONSTRAINT FK_Orders_TO_OrderDetail
      FOREIGN KEY (
         oId
      )
      REFERENCES Orders (
         oId
      );

ALTER TABLE OrderDetail
   ADD
      CONSTRAINT FK_Product_TO_OrderDetail
      FOREIGN KEY (
         pId
      )
      REFERENCES Product (
         pId
      );

ALTER TABLE FreeReply
   ADD
      CONSTRAINT FK_FreeBoard_TO_FreeReply
      FOREIGN KEY (
         fId
      )
      REFERENCES FreeBoard (
         fId
      );

ALTER TABLE FreeReply
   ADD
      CONSTRAINT FK_Member_TO_FreeReply
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE QnaReply
   ADD
      CONSTRAINT FK_QnABoard_TO_QnaReply
      FOREIGN KEY (
         qId
      )
      REFERENCES QnABoard (
         qId
      );

ALTER TABLE QnaReply
   ADD
      CONSTRAINT FK_Member_TO_QnaReply
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE AskBoard
   ADD
      CONSTRAINT FK_Product_TO_AskBoard
      FOREIGN KEY (
         pId
      )
      REFERENCES Product (
         pId
      );

ALTER TABLE AskBoard
   ADD
      CONSTRAINT FK_Member_TO_AskBoard
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE AskReply
   ADD
      CONSTRAINT FK_Member_TO_AskReply
      FOREIGN KEY (
         mEmail
      )
      REFERENCES Member (
         mEmail
      );

ALTER TABLE AskReply
   ADD
      CONSTRAINT FK_AskBoard_TO_AskReply
      FOREIGN KEY (
         askId
      )
      REFERENCES AskBoard (
         askId
      );

----------시퀀스---------------------

create sequence amount_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence orderdetail_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence orderdetail_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence reaview_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence product_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence orders_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence bucket_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence likes_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence masternotice_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence freeboard_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence qna_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence freereply_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence qnareply_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence askboard_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence askreply_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

create sequence youtube_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;

-- 테이블명 조회하기 -- 
select * from tab;


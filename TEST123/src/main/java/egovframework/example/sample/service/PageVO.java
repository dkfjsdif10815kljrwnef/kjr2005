package egovframework.example.sample.service;

import org.springframework.stereotype.Component;

@Component
public class PageVO {

	private int listSize = 3;                //초기값으로 목록개수
	private int rangeSize = 5;            //초기값으로 페이지범위
	private int page;
	private int range;
	private int listCnt;
	private int pageCnt;
	private int startPage;
	private int startList;
	private int endPage;
	private boolean prev;
	private boolean next;

	

	public int getRangeSize() {
		return rangeSize;
	}



	public int getPage() {
		return page;
	}



	public void setPage(int page) {
		this.page = page;
	}



	public int getRange() {
		return range;
	}



	public void setRange(int range) {
		this.range = range;
	}



	public int getStartPage() {
		return startPage;
	}



	public void setStartPage(int startPage) {
		this.startPage = startPage;

	}



	public int getEndPage() {
		return endPage;

	}



	public void setEndPage(int endPage) {
		this.endPage = endPage;

	}



	public boolean isPrev() {
		return prev;

	}



	public void setPrev(boolean prev) {
		this.prev = prev;

	}



	public boolean isNext() {
		return next;

	}



	public void setNext(boolean next) {
		this.next = next;

	}



	public int getListSize() {
		return listSize;

	}



	public void setListSize(int listSize) {
		this.listSize = listSize;

	}

	

	public int getListCnt() {
		return listCnt;

	}



	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;

	}

	

	public int getStartList() {
		return startList;

	}



	public void pageInfo(int page, int range, int listCnt) {
		this.page = page;		//현재 페이지 정보	
		this.range = range;		//현제 페이지 범위 정보
		this.listCnt = listCnt; //게시물 총 갯수 

		

		//전체 페이지수 (밑에 버튼나오는거)
		//(전체페이지수/한페이지당목록개수)
		System.out.println("전체페이지 수 계산");
		this.pageCnt=(int)Math.ceil(listCnt/(double)listSize);
		

		//시작 페이지
		this.startPage = (range - 1) * rangeSize + 1 ;

		

		//끝 페이지
		this.endPage = range * rangeSize;

				

		//게시판 시작번호
		//(페이지번호 - 1)x 페이지사이즈  >> row=0이 1번째 페이지, row=10 11번째 페이지 이므로..
		this.startList = (page - 1) * listSize;

		

		//이전 버튼 상태
		this.prev = range == 1 ? false : true;

		

		//다음 버튼 상태
		//마지막페이지값이 더 크면 endPage는 cnt의 값을 가지고, next false가 됨. 
		this.next = endPage > pageCnt ? false : true;
		System.out.println(endPage+"체크체크체크체크체크"+pageCnt);
		if (this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		}

	}
	
}

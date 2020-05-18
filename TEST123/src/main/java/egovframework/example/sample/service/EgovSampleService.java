/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

/**
 * @Class Name : EgovSampleService.java
 * @Description : EgovSampleService Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public interface EgovSampleService {
	//필요한 서비스들의 목록 
	
	/**
	 * 아이디 중복을 확인한다.
	 * @param Boolean타입 
	 * @return 중복 결과
	 * @exception Exception
	 */
	int userChk(String id) throws Exception;
	
	/**
	 * 사용자 리스트 조회한다.
	 * @param list - 전체 사용자 리스트 정보를 담은 UserVO의 list
	 * @return 조회한 글
	 * @exception Exception
	 */
	List<UserVO> userAll(PageVO pagination) throws Exception;
	
	/**
	 * 사용자를 조회한다.
	 * @return 조회한 글
	 * @exception Exception
	 */
	UserVO userSelect(String id) throws Exception;
	
	/**
	 * 사용자를 등록한다.
	 * @param Boolean타입 
	 * @return 등록 여부
	 * @exception Exception
	 */
	int userInsert(UserVO vo) throws Exception;
	
	/**
	 * 사용자 정보를 수정한다.
	 * @param Boolean타입 
	 * @return 수정 여부
	 * @exception Exception
	 */
	int userUpdate(UserVO vo) throws Exception;
	
	/**
	 * 사용자 리스트 조회한다.
	 * @param list - 전체 사용자 리스트 정보를 담은 UserVO의 list
	 * @return 조회한 글
	 * @exception Exception
	 */
	ArrayList<TaskVO> taskAll(PageVO pagination) throws Exception;
	
	/**
	 * 사용자를 등록한다.
	 * @param Boolean타입 
	 * @return 등록 여부
	 * @exception Exception
	 */
	int taskInsert(TaskVO vo) throws Exception;
	
	/**
	 * 사용자 정보를 수정한다.
	 * @param Boolean타입 
	 * @return 수정 여부
	 * @exception Exception
	 */
	int taskUpdate(TaskVO vo) throws Exception;
	
	int ListCnt(String tb) throws Exception ;
	
	int taskSelectNum(TaskVO vo) throws Exception;
	
	
	TaskVO taskSelect(String num)throws Exception;

	List<UserVO> listSelect(String num)throws Exception;
	
	List<UserVO>listAll(Map map);
	
	int listInsert(Map map);
	int listDelete(Map map);
	int nameChk(Map map) throws Exception;
}

/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
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
package egovframework.example.sample.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.example.sample.service.PageVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.example.sample.service.TaskVO;
import egovframework.example.sample.service.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * sample에 관한 데이터처리 매퍼 클래스
 *
 * @author  표준프레임워크센터
 * @since 2014.01.24
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2014.01.24        표준프레임워크센터          최초 생성
 *
 * </pre>
 */
@Mapper("sampleMapper")
public interface SampleMapper {

	/**
	 * 아이디 중복을 확인한다.
	 * @param Boolean타입 
	 * @return 중복 결과
	 * @exception Exception
	 */
	int userChk(String id);
	
	/**
	 * 사용자를 조회한다.
	 * @return 조회한 글
	 * @exception Exception
	 */
	UserVO userSelect(String id) throws Exception;
	
	/**
	 * 사용자 리스트 조회한다.
	 * @param list - 전체 사용자 리스트 정보를 담은 UserVO의 list
	 * @return 조회한 글
	 * @exception Exception
	 */
	ArrayList<UserVO> userAll(PageVO vo) throws Exception;
	
	/**
	 * 사용자를 등록한다.
	 * @param int타입 
	 * @return 등록 여부
	 * @exception Exception
	 */
	int userInsert(UserVO vo) throws Exception;
	
	/**
	 * 사용자 정보를 수정한다.
	 * @param int타입 
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
	 * @param int타입 
	 * @return 등록 여부
	 * @exception Exception
	 */
	int taskInsert(TaskVO vo) throws Exception;
	
	/**
	 * 사용자 정보를 수정한다.
	 * @param int타입 
	 * @return 수정 여부
	 * @exception Exception
	 */
	int taskUpdate(TaskVO vo) throws Exception;
	
	/**
	 * 페이지번호를 수정한다.
	 * 
	 */
	int ListCnt(String table) throws Exception;
	/**
	 * 과제 번호를 검색한다.
	 * 
	 */
	int taskSelectNum(TaskVO vo) throws Exception;
	int nameChk(Map map) throws Exception;
	TaskVO taskSelect(String num)throws Exception;
	List<UserVO> listSelect(String num)throws Exception;
	List<UserVO>listAll(Map map);
	int listInsert(Map map);
	int listDelete(Map map);
	int nameChk02(Map map) throws Exception;
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	

}

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
package egovframework.example.sample.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.PageVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.example.sample.service.TaskVO;
import egovframework.example.sample.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Class Name : EgovSampleServiceImpl.java
 * @Description : Sample Business Implement Class
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

@Service("serviceBean")
public class EgovSampleServiceImpl extends EgovAbstractServiceImpl implements EgovSampleService {
	//서비스목록의 구현. 해당서비스에맞는 데이터를 불러오기위한 DAO호출 및 리턴값이 나옴.
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSampleServiceImpl.class);

	/** ID Generation */

	// TODO mybatis 사용
	@Resource(name="sampleMapper")
	private SampleMapper DAO;

	// SqlSessionTemplate DI
    @Autowired
    protected SqlSessionTemplate sqlSession;

    // Mapper XML의 namespace와 일치해야 한다.
    private static String namespace = "egovframework.example.sample.service.impl.SampleMapper.";

	
	@Override //db에 등록된 유저인지  확인. 등록되어있으면 1 아니면 0 
	public int userChk(String id) throws Exception {
		return DAO.userChk(id);
	}

	@Override //id의 사용자를 확인. 사용자정보 userVO저장 
	public UserVO userSelect(String id) throws Exception {
		return  DAO.userSelect(id);
	}
	
	@Override //전체 사용자리스트 확인. 사용자정보 userVO를 List에 저장.
	public  ArrayList<UserVO> userAll(PageVO pagination) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 userAll~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("startList : "+pagination.getStartList());
		List<UserVO> list = sqlSession.selectList(namespace+"userAll",pagination);
		return  (ArrayList<UserVO>)list;
	}

	@Override
	public int userInsert(UserVO vo) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 Insert~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("id : "+vo.getId()+"/ 이름:"+vo.getName());
		
		int result = sqlSession.insert(namespace+"userInsert", vo);
		return result;
	}

	@Override
	public int userUpdate(UserVO vo) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 Update~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("id : "+vo.getId()+"/ 이름:"+vo.getName());
		int result = sqlSession.update(namespace+"userUpdate", vo);
		
		return result;
	}

	@Override
	public ArrayList<TaskVO> taskAll(PageVO pagination) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 userAll~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("startList : "+pagination.getStartList());
		List<TaskVO> list = sqlSession.selectList(namespace+"taskAll",pagination);
		return  (ArrayList<TaskVO>)list;
	}

	@Override
	public int taskInsert(TaskVO vo) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 taskInsert~~~~~~~~~~~~~~~~~~~~~~~");
		int result = sqlSession.insert(namespace+"taskInsert", vo);
		return result;
	}

	@Override
	public int taskUpdate(TaskVO vo) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 taskUpdate~~~~~~~~~~~~~~~~~~~~~~~");
		int num = sqlSession.update(namespace+"taskUpdate",vo);
		System.out.println(num);
		return num;
	}
	
	@Override
	public int ListCnt(String tb) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 ListCnt~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("name"+tb);
		int result = sqlSession.selectOne(namespace+"ListCnt", tb); //mabatis parametertype에서 String을 쓰면 ${value} 로 사용시 getter의 역할을 한다고 합니다. 
		System.out.println(result);
		return result;
	}
	
	@Override
	public int taskSelectNum(TaskVO vo) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 taskSelectNum~~~~~~~~~~~~~~~~~~~~~~~");
		int num = sqlSession.selectOne(namespace+"taskSelectNum",vo);
		return num;
	}
	
	@Override
	public int nameChk(Map map) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 nameChk~~~~~~~~~~~~~~~~~~~~~~~");
		int num = sqlSession.selectOne(namespace+"nameChk",map);
		return num;
	}

	@Override
	public TaskVO taskSelect(String num) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 taskSelect~~~~~~~~~~~~~~~~~~~~~~~");
		TaskVO vo = sqlSession.selectOne(namespace+"taskSelect",num);
		return vo;
	}

	@Override //전체 사용자리스트 확인. 사용자정보 userVO를 List에 저장.
	public  ArrayList<UserVO> listSelect (String num) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 userAll~~~~~~~~~~~~~~~~~~~~~~~");
		List<UserVO> list = sqlSession.selectList(namespace+"listSelect",num);
		return  (ArrayList<UserVO>)list;
	}
	
	@Override
	public ArrayList<UserVO> listAll(Map map) {
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~serviceImpl의 listAll~~~~~~~~~~~~~~~~~~~~~~~");
		List<UserVO> list = sqlSession.selectList(namespace+"listAll",map);
		return  (ArrayList<UserVO>)list;
	}
	
	@Override
	public int listInsert(Map map) {
		int result = sqlSession.insert(namespace+"listInsert", map);
		return result;
	}
	@Override
	public int listDelete(Map map) {
		int result = sqlSession.delete(namespace+"listDelete", map);
		return result;
	}
	
	

}

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
package egovframework.example.sample.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import egovframework.example.sample.service.ListVO;
import egovframework.example.sample.service.PageVO;
import egovframework.example.sample.service.TaskVO;
import egovframework.example.sample.service.UserVO;
import egovframework.example.sample.service.impl.EgovSampleServiceImpl;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.SocketUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;


/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
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

@Controller
@SessionAttributes("loginID") //loginID는 세션에 저장됨
public class EgovSampleController {


		@Autowired
		private EgovSampleServiceImpl service;
		
		@Autowired
		private UserVO user;
		
		@Autowired
		private TaskVO task;
		
		@Autowired
		private ListVO listVo;
	
		
	/**
	 * 로그인 화면으로 이동한다. 
	 * @return "sample/login"
	 */

	@RequestMapping("/login.do")
	public ModelAndView login() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("sample/login");
		return mv;
	}
	
	
	/**
	 * 등록된 id인지 체크한다 
	 *
	 */
	@ResponseBody
	@RequestMapping(value="/idchkDB.do", method = RequestMethod.POST)
	public HashMap<String, String> idchkDB(@RequestBody HashMap<String, String> map,final HttpSession session) {
		String ID = map.get("loginID");
		String cnt ="0";
		try {
			//등록된 아이디가 있는지 없는지의 값을 넣음(db연결)
			cnt = Integer.toString(service.userChk(ID));
			session.setAttribute("loginId", ID);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			map.put("cnt", cnt);
		return map;
	}

	
	
	@RequestMapping("/taskInfo.do")
	public ModelAndView taskInfo(@RequestParam String num, ModelAndView mv) {
		System.out.println("????taskInfo동작중~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~??? ");
	try {
			
			if (num!=null) {
				task = service.taskSelect(num);
				mv.addObject("name",task.getName());
				mv.addObject("startDay",task.getStartDay());
				mv.addObject("endDay",task.getEndDay());
				ArrayList<UserVO> list = service.listSelect(num) ;
				mv.addObject("list",list);
			}
		} catch (Exception e) {
		}
			mv.addObject("num", num);
			mv.setViewName("sample/taskInfo");
			return mv;
	}


	@ResponseBody 
	@RequestMapping(value="/taskUpdateDB.do", method=RequestMethod.POST)
	public HashMap<String, String> taskUpdateDB(@RequestBody HashMap<String, String> map) {
		System.out.println("cccccccccccc / taskUpdateDB확인  /cccccccccccccccccccccccccc");
		
		
		//중복이 없을경우
		
		task.setNm(map.get("num"));
		task.setName(map.get("name"));
		task.setStartDay(map.get("startDay"));
		task.setEndDay(map.get("endDay"));
		
		try {
				int chk = service.taskUpdate(task);
				map.put("chk","1");
			} catch (Exception e) {
				e.printStackTrace();
			}
		return map;
	}



	/**
	 * 과제등록 이동한다.
	 *
	 */
	@RequestMapping("/taskInsert.do")
	public ModelAndView taskInsert(ModelAndView mv) {
		mv.addObject("taskData", task);	//빈객체보내기...
		mv.setViewName("sample/taskInsert");
		return mv;
	}

	/**
	 * 과제정보 등록DB처리한다 (ajax)
	 *
	 */
	@ResponseBody 
	@RequestMapping(value="/taskInsertDB.do", method=RequestMethod.POST)
	public HashMap<String, String> taskInsertDB(@RequestBody HashMap<String, String> map, HttpSession session) {
		System.out.println("cccccccccccc / insertDB확인  /cccccccccccccccccccccccccc");
		task.setId((String)session.getAttribute("loginId"));
		task.setName(map.get("name"));
		task.setStartDay(map.get("startDay"));
		task.setEndDay(map.get("endDay"));
		System.out.println(task.getId());
		System.out.println(task.getName());
		System.out.println(task.getStartDay());
		try {
			int chk = 0;
			chk = service.nameChk(map);
			if(chk>0) {
				//중복된 이름이 있을경우 -1로 리턴 
				map.put("chk","-1");
				return map;
			}
			
			//insert작업
			chk = service.taskInsert(task);
			String num = Integer.toString(service.taskSelectNum(task));
				//결과에대한 return
				if(chk>0) { 
					//성공 -> 과제정보;
					map.put("num",num);
					map.put("chk","1");
				}else {
					//실패(0) -> 과제입력;
					map.put("chk","0");
				}
				
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 과제리스트 조회한다 
	 *
	 */
	@RequestMapping("/taskList.do")
	public ModelAndView taskList(@RequestParam(required=false,defaultValue="1")int page,@RequestParam(required = false, defaultValue="1") int range) throws Exception{
		String tb = "task"; //테이블명 
		int listCnt = service.ListCnt(tb);//전체 게시글 개수
		System.out.println("page : / "+page+" range : / "+range+" listCnt: "+listCnt);
		
	//Pagination 객체생성
		PageVO pagination = new PageVO();
	    pagination.pageInfo(page, range, listCnt);
	    
	    ArrayList<TaskVO> list = service.taskAll(pagination);
	    System.out.println("taskAll종료");

	ModelAndView mv = new ModelAndView();
	mv.addObject("pagination",pagination);
	mv.addObject("list",list);//select값 넣기..
	mv.setViewName("sample/taskList");
	
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 사용자를 수정한다.(DB에  USER테이블에 update작업)
	 * @param userVO - 조회할 정보가 담긴 userListVO
	 * @param ID
	 * @param NAME
	 */
	@ResponseBody 
	@RequestMapping(value="/userUpdateDB.do", method = RequestMethod.POST)
	public HashMap<String, String> userUpdateDB(@RequestBody HashMap<String, String> map) {
		user.setId( map.get("ID"));
		user.setName(map.get("NAME"));
		int chk;
		try {
			chk = service.userChk(user.getId());
			if(chk>0) { //일치하는 아이디여부 확인
				//일치할경우 update작업
			chk = service.userUpdate(user);
				//update결과에대한 return
				if(chk>0) { 
					//성공 -> 리스트 ;
					map.put("chk","1");
				}else {
					//실패(0) -> 사용자정보;
					map.put("chk","0");
				}

			}else{
				map.put("chk","-1");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	
		return map;
	}
		
	@RequestMapping("/userInfo.do")
	public ModelAndView userInfo(@RequestParam String ID,@RequestParam String NAME, ModelAndView mv) {
		mv.addObject("ID", ID);
		mv.addObject("NAME", NAME);
		mv.setViewName("sample/userInfo");
		return mv;
	}
	@RequestMapping("/userInsert.do")
	public String userInsert() {
		return "sample/userInsert";
	}
	
	/**
	 * 사용자를 입력한다.(DB에  USER테이블에 INSERT작업)
	 * @param userVO - 조회할 정보가 담긴 userListVO
	 * @param ID
	 * @param NAME
	 */
	@ResponseBody 
	@RequestMapping(value="/userInsertDB.do", method = RequestMethod.POST)
	public HashMap<String, String> userInsertDB(@RequestBody HashMap<String, String> map) {
		user.setId( map.get("ID"));
		user.setName(map.get("NAME"));
		
		
		try {
			int chk = service.userChk(user.getId());
			
			if(chk==0) { //중복된 아이디 개수
				//중복된 아이디가 없으면 insert작업
				chk = service.userInsert(user);
				if(chk>0) { 
					//isnert 성공 -> 리스트 ;
					map.put("chk","1");
				}else {
					//실패(0) -> 사용자등록;
					map.put("chk","0");
				}
				
			}else {
				//실패(1이상=중복있음) -> 사용자등록;
				map.put("chk","-1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	/**
	 * 사용자 목록을 조회한다. (pageing)
	 * @param userVO - 조회할 정보가 담긴 userListVO
	 * @param ID
	 * @return "sample/userList"
	 * @exception Exception
	 */
	@RequestMapping("/userList.do")
	public ModelAndView userList(@RequestParam(required=false,defaultValue="1")int page,@RequestParam(required = false, defaultValue="1") int range) throws Exception{
			String tb = "user"; //테이블명 
			int listCnt = service.ListCnt(tb);//전체 게시글 개수
			System.out.println("page : / "+page+" range : / "+range+" listCnt: "+listCnt);
			
		//Pagination 객체생성
			PageVO pagination = new PageVO();
		    pagination.pageInfo(page, range, listCnt);
		    
		    ArrayList<UserVO> list = service.userAll(pagination);
		    System.out.println("userAll종료");

		ModelAndView mv = new ModelAndView();
		mv.addObject("pagination",pagination);
		mv.addObject("list",list);//select값 넣기..
		mv.setViewName("sample/userList");
		
			return mv;
	}
	@ResponseBody 
	@RequestMapping(value="/listInsertDB.do", method = RequestMethod.POST)
	public HashMap<String, String> listInsertDB(@RequestBody HashMap<String, String> map) {
		
		
		try {
			
			int	chk = service.listInsert(map);
				if(chk>0) { 
					//isnert 성공 -> 리스트 ;
					map.put("chk","1");
				}else {
					//실패(0) -> 사용자등록;
					map.put("chk","0");
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	@RequestMapping("/openInfo.do")
	public ModelAndView openInfo(@RequestParam(required=false,defaultValue="1")int page,@RequestParam(required = false, defaultValue="1") int range, String num) throws Exception{
			System.out.println("userList!!!!!!!!!!!!!!!!!"+num);
			String tb = "user"; //테이블명 
			int listCnt = service.ListCnt(tb);//전체 게시글 개수
			System.out.println("page : / "+page+" range : / "+range+" listCnt: "+listCnt);
			
		//Pagination 객체생성
			PageVO pagination = new PageVO();
			pagination.setListSize(10);
		    pagination.pageInfo(page, range, listCnt);
		    
		    Map<String,Object> map = new HashMap<String, Object>();
		    
		    map.put("num",num);
		    map.put("startList",pagination.getStartList());
		    map.put("listSize",pagination.getListSize());
		    
		    ArrayList<UserVO> list = service.listAll(map);
		    
		    System.out.println("openInfo종료"+num);
		ModelAndView mv = new ModelAndView();
		mv.addObject("num",num);
		mv.addObject("pagination",pagination);
		mv.addObject("list",list);//select값 넣기..
		mv.setViewName("sample/openInfo");
		
			return mv;
	}
	@ResponseBody 
	@RequestMapping(value="/listDeleteDB.do", method = RequestMethod.POST)
	public HashMap<String, String> listDeleteDB(@RequestBody HashMap<String, String> map) {
		
		
		try {
			
			int	chk = service.listDelete(map);
				if(chk>0) { 
					//isnert 성공 -> 리스트 ;
					map.put("chk","1");
				}else {
					//실패(0) -> 사용자등록;
					map.put("chk","0");
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
}

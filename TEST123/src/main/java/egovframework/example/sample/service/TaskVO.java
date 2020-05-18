package egovframework.example.sample.service;


import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class TaskVO  extends KjrVO {
	private int num;
	private String nm;
	private String id;
	private String name;
	private String startDay;
	private String endDay;
	
	public TaskVO() {
		super();
	}
	public TaskVO(String id, String name, String startDay, String endDay) {
		super();
		this.id = id;
		this.name = name;
		this.startDay = startDay;
		this.endDay = endDay;
	}
	
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm =nm;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStartDay() {
		return startDay;
	}
	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}
	public String getEndDay() {
		return endDay;
	}
	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}
	@Override
	public String toString() {
		return "TaskVO [num=" + num + ", id=" + id + ", name=" + name + ", startDay=" + startDay + ", endDay=" + endDay
				+ "]";
	}
	
	
}

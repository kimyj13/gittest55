package Board;

import java.sql.Date;

public class BoardBean {
	private int num;
	private String name;
	private String pass;
	private String subject;
	private String content;
	private int readcount;
	private Date date;
	private String file;
	private String comment;
	private int conum;
	private Date co_cate;
	
	
	public Date getCo_cate() {
		return co_cate;
	}
	public void setCo_cate(Date co_cate) {
		this.co_cate = co_cate;
	}
	public int getConum() {
		return conum;
	}
	public void setConum(int conum) {
		this.conum = conum;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
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
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}



}

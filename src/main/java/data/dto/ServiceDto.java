package data.dto;

import java.sql.Timestamp;

public class ServiceDto {
	//filed
	private String num;
	private String category;
	private String writer;
	private String open;
	private String mobile;
	private String email;
	private String subject;
	private String contents;
	private int views;
	private String file;
	private String status;
	private Timestamp writeday;
	private String id;
	
	//추가
	private String jaid;

	//변경
	private int pos;            
	private int ref;  
	private int depth;   
	
	
	public String getJaid() {
		return jaid;
	}
	
	public void setJaid(String jaid) {
		this.jaid = jaid;
	}
	public int getPos() {
		return pos;
	}

	public void setPos(int pos) {
		this.pos = pos;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}
	/////
	//생성자
	public ServiceDto() {}

	public ServiceDto(String category, String writer, String open, String mobile, String email, String subject,
			String contents, String file, String id) {
		super();
		this.category = category;
		this.writer = writer;
		this.open = open;
		this.mobile = mobile;
		this.email = email;
		this.subject = subject;
		this.contents = contents;
		this.file = file;
		this.id = id;
	}
	
	
	//for reply
	public ServiceDto(String category, String writer, String open, String subject, String contents,
			String file, Timestamp writeday, String id, int pos, int depth, int ref) {
		super();
		this.category = category;
		this.writer = writer;
		this.open = open;
		this.subject = subject;
		this.contents = contents;
		this.file = file;
		this.writeday = writeday;
		this.id = id;
		this.pos = pos;
		this.depth = depth;
		this.ref = ref;
	}

	public ServiceDto(String num, String category, String writer, String open, String mobile, String email, String subject,
			String contents, int views, String file, String status, Timestamp writeday, String id) {
		super();
		this.num = num;
		this.category = category;
		this.writer = writer;
		this.open = open;
		this.mobile = mobile;
		this.email = email;
		this.subject = subject;
		this.contents = contents;
		this.views = views;
		this.file = file;
		this.status = status;
		this.writeday = writeday;
		this.id = id;
	}
	//getmethod
	public ServiceDto(String num, String category, String writer, String open, String mobile, String email,
			String subject, String contents, int views, String file, String status, Timestamp writeday, String id,
			int pos, int ref, int depth) {
		super();
		this.num = num;
		this.category = category;
		this.writer = writer;
		this.open = open;
		this.mobile = mobile;
		this.email = email;
		this.subject = subject;
		this.contents = contents;
		this.views = views;
		this.file = file;
		this.status = status;
		this.writeday = writeday;
		this.id = id;
		this.pos = pos;
		this.ref = ref;
		this.depth = depth;
	}
	

	//setter getter
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getWriteday() {
		return writeday;
	}

	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
	
	
}

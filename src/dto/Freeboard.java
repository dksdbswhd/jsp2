package dto;


import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Freeboard {
	private int idx;
	private String name;
	private String password;
	private String subject;
	private String content;
	private int readCount;
	private Timestamp wdate;	// Date 타입은 날짜만 가져오고 시간을 못 가져옵니다.
	private String ip;
	private short commentCount;
}
package mail;

import javax.mail.Authenticator;	//인증자
import javax.mail.PasswordAuthentication;	// 비밀번호 인증

public class MailAuth extends Authenticator{
	
	PasswordAuthentication pa;
	
	
	public MailAuth(){		// 생성자.
		
		String mail_id = "forprojectjsp@gmail.com";
		String mail_pass ="projectjsp";
		
		pa = new PasswordAuthentication(mail_id, mail_pass);
	}

	public PasswordAuthentication getPasswordAuthentication(){
		
		return pa;
	}


}
package SendEmail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail{
	public String getConfirmNum() {
		String num = "";
		for(int i=0; i<7; i++) {
			num += (int) (Math.random()*9+1) + "";	
			System.out.println(num);
		}
		return num;
	}
	public void sendEmailToUser(String userEmailAddr, String subject, String text) {
		String host = "smtp.naver.com";
		String user = "Naver-email";
		String password = "pass";

		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", true);

		Session session = Session.getDefaultInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmailAddr));
			//쨍횧�횕횁짝쨍챰
			message.setSubject(subject);
			//쨍횧�횕쨀쨩쩔챘
			message.setText(text);
			//send the message
			Transport.send(message);
			System.out.println("성공");

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}

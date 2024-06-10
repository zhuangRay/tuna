package exception;

public class LoginFailedException extends TUNAException {

	public LoginFailedException() {
		super();
	
	}

	public LoginFailedException(String message, Throwable cause) {
		super(message, cause);
		
	}

	public LoginFailedException(String message) {
		super(message);
		
	}

}

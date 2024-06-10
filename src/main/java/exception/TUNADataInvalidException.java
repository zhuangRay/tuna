package exception;

public class TUNADataInvalidException extends RuntimeException {

	public TUNADataInvalidException() {
		super();
		
	}

	public TUNADataInvalidException(String message, Throwable cause) {
		super(message, cause);
		
	}

	public TUNADataInvalidException(String message) {
		super(message);
		
	}

}

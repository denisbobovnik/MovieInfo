package si.um.feri.kis.sax;

public class Rating {
	private String source, value;
	
	public Rating() {
		
	}
	public Rating(String source, String value) {
		this.source = source;
		this.value = value;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
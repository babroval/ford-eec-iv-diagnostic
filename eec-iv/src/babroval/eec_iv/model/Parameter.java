package babroval.eec_iv.model;

public class Parameter {

	private Integer parameter_id = 0;
	private String number = "";
	private String name = "";
	private String value = "";

	public Parameter() {
	}

	public Integer getParameter_id() {
		return parameter_id;
	}

	public void setParameter_id(Integer parameter_id) {
		this.parameter_id = parameter_id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return "Parameter [parameter_id=" + parameter_id + ", number=" + number + ", name=" + name + ", value=" + value
				+ "]";
	}

}

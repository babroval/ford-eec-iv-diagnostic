package babroval.eec_iv.model;

public class Parameter {

	private Integer parameter_id = 0;
	private String number = "";
	private String name = "";
	private String value = "";

	public Parameter() {
	}

	public Parameter(Integer parameter_id) {
		this.parameter_id = parameter_id;
	}

	public Parameter(String number) {
		this.number = number;
	}

	public Parameter(Integer parameter_id, String number) {
		this.parameter_id = parameter_id;
		this.number = number;
	}

	public Parameter(String number, String name) {
		this.number = number;
		this.name = name;
	}

	public Parameter(Integer parameter_id, String number, String name) {
		this.parameter_id = parameter_id;
		this.number = number;
		this.name = name;
	}

	public Parameter(String number, String name, String value) {
		this.number = number;
		this.name = name;
		this.value = value;
	}

	public Parameter(Integer parameter_id, String number, String name, String value) {
		this.parameter_id = parameter_id;
		this.number = number;
		this.name = name;
		this.value = value;
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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((number == null) ? 0 : number.hashCode());
		result = prime * result + ((parameter_id == null) ? 0 : parameter_id.hashCode());
		result = prime * result + ((value == null) ? 0 : value.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Parameter))
			return false;
		Parameter other = (Parameter) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (number == null) {
			if (other.number != null)
				return false;
		} else if (!number.equals(other.number))
			return false;
		if (parameter_id == null) {
			if (other.parameter_id != null)
				return false;
		} else if (!parameter_id.equals(other.parameter_id))
			return false;
		if (value == null) {
			if (other.value != null)
				return false;
		} else if (!value.equals(other.value))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Parameter [parameter_id=" + parameter_id + ", number=" + number + ", name=" + name + ", value=" + value
				+ "]";
	}
}

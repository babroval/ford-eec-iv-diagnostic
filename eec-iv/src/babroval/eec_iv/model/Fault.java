package babroval.eec_iv.model;

public class Fault {

	private Integer fault_id = 0;
	private String number = "";
	private String info = "";

	public Fault() {
	}

	public Fault(Integer fault_id) {
		this.fault_id = fault_id;
	}

	public Fault(String number) {
		this.number = number;
	}

	public Fault(Integer fault_id, String number) {
		this.fault_id = fault_id;
		this.number = number;
	}

	public Fault(String number, String info) {
		this.number = number;
		this.info = info;
	}

	public Fault(Integer fault_id, String number, String info) {
		this.fault_id = fault_id;
		this.number = number;
		this.info = info;
	}

	public Integer getFault_id() {
		return fault_id;
	}

	public void setFault_id(Integer fault_id) {
		this.fault_id = fault_id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fault_id == null) ? 0 : fault_id.hashCode());
		result = prime * result + ((info == null) ? 0 : info.hashCode());
		result = prime * result + ((number == null) ? 0 : number.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Fault))
			return false;
		Fault other = (Fault) obj;
		if (fault_id == null) {
			if (other.fault_id != null)
				return false;
		} else if (!fault_id.equals(other.fault_id))
			return false;
		if (info == null) {
			if (other.info != null)
				return false;
		} else if (!info.equals(other.info))
			return false;
		if (number == null) {
			if (other.number != null)
				return false;
		} else if (!number.equals(other.number))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Fault [fault_id=" + fault_id + ", number=" + number + ", info=" + info + "]";
	}
}
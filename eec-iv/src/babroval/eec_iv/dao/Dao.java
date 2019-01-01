package babroval.eec_iv.dao;

import java.util.List;

public interface Dao<T> {

	List<T> loadAllFaults(String csvFilePath);
	
	List<T> loadAllParameters(String csvFilePath, StringBuffer data);
	
}

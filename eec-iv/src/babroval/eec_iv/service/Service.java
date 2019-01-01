package babroval.eec_iv.service;

import java.util.List;

public interface Service<T> {

	List<T> getAllFaults(String csvFilePath);

	List<T> getAllParameters(String fileParametersPath, StringBuffer data);

}

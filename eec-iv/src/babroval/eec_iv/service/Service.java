package babroval.eec_iv.service;

import java.util.List;

public interface Service<T> {

	List<T> getAll(String csvFilePath);

	List<T> updateAll(List<T> list, StringBuffer data);
}

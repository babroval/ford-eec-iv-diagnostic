package babroval.eec_iv.service;

import java.io.InputStream;
import java.util.List;

public interface Service<T> {

	List<T> getAll(InputStream csvFile);

	List<T> updateAll(List<T> list, StringBuffer data);
}

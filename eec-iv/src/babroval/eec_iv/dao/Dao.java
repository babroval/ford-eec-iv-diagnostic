package babroval.eec_iv.dao;

import java.io.InputStream;
import java.util.List;

public interface Dao<T> {

	List<T> loadAll(InputStream csvFile);
}

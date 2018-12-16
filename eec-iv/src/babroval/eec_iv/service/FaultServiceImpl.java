package babroval.eec_iv.service;

import java.util.List;

import babroval.eec_iv.dao.Dao;
import babroval.eec_iv.dao.FaultDaoImpl;

public class FaultServiceImpl<T> implements Service<T> {

	@SuppressWarnings("unchecked")
	private Dao<T> dao = (Dao<T>) new FaultDaoImpl();

	@Override
	public List<T> getAllFaults(String csvFilePath) {
		return dao.loadAllFaults(csvFilePath);
	}

}
